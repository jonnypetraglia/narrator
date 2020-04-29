public virtual without sharing class Narrate {

    public static final String DEBUG = LoggingLevel.DEBUG.name().toLowerCase().capitalize(),
                INFO = LoggingLevel.INFO.name().toLowerCase().capitalize(),
                WARN = LoggingLevel.WARN.name().toLowerCase().capitalize(),
                ERROR = LoggingLevel.ERROR.name().toLowerCase().capitalize(),
                FINE = LoggingLevel.FINE.name().toLowerCase().capitalize(),
                FINER = LoggingLevel.FINER.name().toLowerCase().capitalize(),
                FINEST = LoggingLevel.FINEST.name().toLowerCase().capitalize(),
                WTF = 'Wtf',
                EXCEPT = 'Except',
                REST = 'Rest';

    public static void debug(String message) {
        System.debug('Inside debug ' + message);
        log(DEBUG, message, new List<Object>());
    }
    public static void debug(String message, List<Object> values) {
        System.debug('Inside debug ' + message);
        log(DEBUG, message, values);
    }
    
    public static void info(String message) {
        log(INFO, message, new List<Object>());
    }
    public static void info(String message, List<Object> values) {
        log(INFO, message, values);
    }
    
    public static void warn(String message) {
        log(WARN, message, new List<Object>());
    }
    public static void warn(String message, List<Object> values) {
        log(WARN, message, values);
    }
    
    public static void error(String message) {
        log(ERROR, message, new List<Object>());
    }
    public static void error(String message, List<Object> values) {
        log(ERROR, message, values);
    }
    
    public static void wtf(String message) {
        log(WTF, message, new List<Object>());
    }
    public static void wtf(String message, List<Object> values) {
        log(WTF, message, values);
    }
    
    public static void fine(String message) {
        log(FINE, message, new List<Object>());
    }
    public static void fine(String message, List<Object> values) {
        log(FINE, message, values);
    }

    public static void finer(String message) {
        log(FINER, message, new List<Object>());
    }
    public static void finer(String message, List<Object> values) {
        log(FINER, message, values);
    }
    
    public static void finest(String message) {
        log(FINEST, message, new List<Object>());
    }
    public static void finest(String message, List<Object> values) {
        log(FINEST, message, values);
    }

    public static void log(String level, String message, List<Object> values) {
        for(narrate_INarrator narrator : narrators) {
            narrator.log(level, message, values);
        }
    }

    public static void except(Exception error) {
        for(narrate_INarrator narrator : narrators) {
            narrator.except(error);
        }
    }

    public static void rest(RestRequest request) {
        for(narrate_INarrator narrator : narrators) {
            narrator.restRequest(request);
        }
    }

    public static void rest(RestResponse response) {
        for(narrate_INarrator narrator : narrators) {
            narrator.restResponse(response);
        }
    }

    public static void start(String context) {
        for(narrate_INarrator narrator : narrators) {
            narrator.setContext(context);
        }
    }

    public static void finish() {
        for(narrate_INarrator narrator : narrators) {
            narrator.flush();
        }
    }

    private static List<narrate_INarrator> narrators {get {
        if(narrators == null) {
            // TODO: Read from custom metadata & create narrators based on that
            narrators = new List<narrate_INarrator> {new narrate_AutoContextNarrator(), new narrate_SystemDebugNarrator()};
            System.debug('There are ' + narrators.size() + ' narrators');
        }
        return narrators;
    } set;}
    
}