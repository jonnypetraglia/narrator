import { LightningElement, track, api } from 'lwc';
import { LIST_COLUMNS } from 'c/narrate_utilities';

export default class narrate_logEventList extends LightningElement {

    @api
    filterFunction = null;

    @api
    addLog(log) {
        console.log('addLog', JSON.stringify(log));
        if(!this.logs) this.logs = {};
        this.logs[log.Name] = [];
        for(var i=0; i<log.narrate_LogEntries__r.length; i++) {
            this.logs[log.Name].push(log.narrate_LogEntries__r[i]);
        }
    }

    @api
    addLogs(logs) {
        console.log('addLogs', JSON.stringify(logs));
        for(var index = 0; index < logs.length; index++) this.addLog(logs[index]);
    }

    @api
    addLogEntries(logEntries) {
        console.log('addLogEntries', logEntries.length, JSON.stringify(logEntries));
        for(var index = 0; index < logEntries.length; index++) {
            const logEntry = logEntries[index];
            if(!this.logs) this.logs = {};
            if(!this.logs[logEntry.narrate_Context__c]) this.logs[logEntry.narrate_Context__c] = [];
            this.logs[logEntry.narrate_Context__c].push(logEntry);
        }
    }
    
    @api
    refreshView() {
        console.log('refreshView', JSON.stringify(this.logs));
        this.treeData = [];
        for(const context in this.logs) {
            let log = this.logs[context][0];
            if(!this.filterFunction || this.filterFunction(log)) {
                if(this.logs[context].length > 1) {
                    log._children = this.logs[context].slice(1);
                }
                this.treeData.push(log);
            }
        }
        console.log('refreshedView', JSON.stringify(this.treeData));
    }

    @api
    clear() {
        this.logs = {};
        this.treeData = [];
    }

    ////// Private //////

    @track logs = {};
    @track treeData = [];

    get columns() {
        return LIST_COLUMNS;
    }

    cloneLog(log) {
        var result = {};
        for(var thing in log) {
            result[thing] = log[thing];
        }
        console.log(JSON.stringify(result), 'vs', JSON.stringify(log));
        return result;
    }
}