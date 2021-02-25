import { publishEvent, formatString, castToStringList } from 'c/narrate_utilities';
import Id from '@salesforce/user/Id';

const USER_ID = Id,
        DEBUG = 'Debug',
        INFO = 'Info',
        WARN = 'Warn',
        ERROR = 'Error',
        WTF = 'Wtf',
        FINE = 'Fine',
        FINER = 'Finer',
        FINEST = 'Finest';

class narrate_Logger { 

    AUTO_CONTEXT = ('0' + (new Date()).getHours() + ':0' + (new Date()).getMinutes() + ':0' + (new Date()).getSeconds()).replace(/[0-9]{3}/, '');
    userContext = null;

    setContext(context) {
        if(this.userContext == null) {
            this.userContext = context;
        }
    }

    debug(message, values) {
        this.emit(DEBUG, message, values || {});
    }
    info(message, values) {
        this.emit(INFO, message, values || {});
    }
    error(message, values) {
        this.emit(ERROR, message, values || {});
    }
    wtf(message, values) {
        this.emit(WTF, message, values || {});
    }
    fine(message, values) {
        this.emit(FINE, message, values || {});
    }
    finer(message, values) {
        this.emit(FINER, message, values || {});
    }
    finest(message, values) {
        this.emit(FINEST, message, values || {});
    }
    
    log(level, message, values) {
        this.emit(level, message, values);
    }

    emit(level, message, values) {
        console.log(level, message, values);
        message = formatString(message, castToStringList(values));
        let currentEvent = {
            user: USER_ID,
            message: message,
            level: level,
            message: JSON.stringify(values),
            context: this.fullContext()
        };
        /*
        narrate_StackTraceEvent stackTrace = new narrate_StackTraceEvent(CLASS_NAME);
        currentEvent.Class__c = stackTrace.theClass;
        currentEvent.Method__c = stackTrace.theMethod;
        currentEvent.Line__c = stackTrace.theLine;
        */ //TODO: set stack trace variables?
        publishEvent(currentEvent)
            .then((response) => {
                console.log('publishEvent', JSON.stringify(response));
            })
            .catch((response) => {
                console.error('publishEvent', JSON.stringify(response));
            });
    }

    fullContext() {
        return ((this.userContext != null ? this.userContext + ' ' : '') + this.AUTO_CONTEXT).trim();
    }
}

let Log = new narrate_Logger();

export default Log;

export {narrate_Logger, DEBUG, INFO, WARN, ERROR, WTF, FINE, FINER, FINEST};