import { LightningElement, track, api } from 'lwc';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Id from '@salesforce/user/Id';
import { validRegex, logMatchesFilter } from 'c/narrate_utilities';

const USER_ID = Id;

export default class narrate_Monitor extends LightningElement {

    constructor() {
        super();
        const self = this;
        onError(error => { console.log('error', error); self.handleError(error); });
        this.resume();
    }

    renderedCallback() {
        const refs = this.template.querySelector('c-narrate_log-event-list');
        this.list = refs;
        const self = this;
        this.list.filterFunction = function(log) { return self.matchesFilter(log); }
    }

    disconnectedCallback() {
        console.log('disconnectedCallback', this.isListening, this.subscription);
        if(!this.isListening) {
            this.pause();
        }
    }

    @api
    resume() {
        console.log('resume');
        const self = this;
        subscribe('/event/narrate_LogEvent__e', -1, response => { self.receive(response); })
            .then(response => {
                self.subscription = response;
                console.log('resume', JSON.stringify(response));
            })
            .catch(error => {
                console.error('resume', JSON.stringify(error));
            });
    }

    @api
    pause() {
        console.log('pause');
        unsubscribe(this.subscription, (response) => { this.subscription = null; });
    }

    @api
    get isListening() {
        return this.subscription != null;
    }

    @api
    clear() {
        this.list.clear();
    }

    @api
    pauseOrResume() {
        if(this.isListening) {
            this.pause();
        } else {
            this.resume();
        }
    }


    ////// Private //////

    @track filter = "";
    @track enableRegex = false;
    @track enableLongText = false
    list = undefined;
    subscription = null;
    
    get pauseOrResumeText() {
        return this.isListening ? 'Pause' : 'Resume';
    }

    get pauseOrResumeIcon() {
        return this.isListening ? 'utility:pause' : 'utility:play';
    }
    
    get validFilter() {
        return this.filter.length == 0 || !this.enableRegex || validRegex(this.filter);
    }

    matchesFilter(log) {
        return !this.validFilter || logMatchesFilter(log, this.filter, this.enableLongText ? 9000 : 255);
    }

    handleFilter(evt) {
        if(this.filter != evt.target.value) {
            this.filter = evt.target.value;
            this.list.refreshView();
        }
    }

    handleRegex(evt) {
        if(this.enableRegex != evt.target.checked) {
            this.enableRegex = evt.target.checked;
            this.list.refreshView();
        }
    }

    handleLongText(evt) {
        if(this.enableLongText != evt.target.checked) {
            this.enableLongText = evt.target.checked;
            this.list.refreshView();
        }
    }

    handleError(response) {
        console.error('handleError', JSON.stringify(response), response);
        let errorMessage;
        if(response.ext && response.ext.sfdc && response.ext.sfdc.failureReason) {
            errorMessage = response.ext.sfdc.failureReason; 
        } else if(response.error) {
            errorMessage = response.error;
        } else {
            errorMessage = JSON.stringify(response);
        }
        const event = new ShowToastEvent({
            title: 'An error occurred, check the console log for more details',
            message: errorMessage,
            variant: 'error'
        });
        this.dispatchEvent(event);
    }

    receive(response) {
        console.log('receive', JSON.stringify(response));
        let log = response.data.payload;
        if(this.isCurrentUser(log)) {
            this.list.addLogEntries([log]);
            if(this.matchesFilter(log)) {
                this.list.refreshView();
            }
            console.log('Received', JSON.stringify(log))
        }
    }

    isCurrentUser(log) {
        return log.narrate_User__c === USER_ID;
    }
}