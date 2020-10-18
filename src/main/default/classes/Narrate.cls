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
        log(DEBUG, message, new List<Object>());
    }
    public static void debug(String message, List<Object> values) {
        log(DEBUG, message, values);
    }
    public static void debug(String message, Object param) {
        log(DEBUG, message, asList(param));
    }
    
    public static void info(String message) {
        log(INFO, message, new List<Object>());
    }
    public static void info(String message, List<Object> values) {
        log(INFO, message, values);
    }
    public static void info(String message, Object param) {
        log(INFO, message, asList(param));
    }
    
    public static void warn(String message) {
        log(WARN, message, new List<Object>());
    }
    public static void warn(String message, List<Object> values) {
        log(WARN, message, values);
    }
    public static void warn(String message, Object param) {
        log(WARN, message, asList(param));
    }
    
    public static void error(String message) {
        log(ERROR, message, new List<Object>());
    }
    public static void error(String message, List<Object> values) {
        log(ERROR, message, values);
    }
    public static void error(String message, Object param) {
        log(ERROR, message, asList(param));
    }
    
    public static void wtf(String message) {
        log(WTF, message, new List<Object>());
    }
    public static void wtf(String message, List<Object> values) {
        log(WTF, message, values);
    }
    public static void wtf(String message, Object param) {
        log(WTF, message, asList(param));
    }
    
    public static void fine(String message) {
        log(FINE, message, new List<Object>());
    }
    public static void fine(String message, List<Object> values) {
        log(FINE, message, values);
    }
    public static void fine(String message, Object param) {
        log(FINE, message, asList(param));
    }

    public static void finer(String message) {
        log(FINER, message, new List<Object>());
    }
    public static void finer(String message, List<Object> values) {
        log(FINER, message, values);
    }
    public static void finer(String message, Object param) {
        log(FINER, message, asList(param));
    }
    
    public static void finest(String message) {
        log(FINEST, message, new List<Object>());
    }
    public static void finest(String message, List<Object> values) {
        log(FINEST, message, values);
    }
    public static void finest(String message, Object param) {
        log(FINEST, message, asList(param));
    }

    public static void log(String level, String message, List<Object> values) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            for(narrate_INarrator narrator : narrators) {
                narrator.log(level, message, values);
            }
        } else {
            output(level, String.format(message, values));
        }
    }

    public static void except(Exception ohno) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            for(narrate_INarrator narrator : narrators) {
                narrator.except(ohno);
            }
        } else {
            output(ERROR, ohno.getTypeName() + ': ' + ohno.getMessage());
            output(ERROR, ohno.getStackTraceString());
        }
    }

    public static void http(HttpRequest request) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            for(narrate_INarrator narrator : narrators) {
                narrator.httpRequest(request);
            }
        } else {
            output(DEBUG, request == null ? '' : request.toString());
        }
    }

    public static void http(HttpResponse response) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            for(narrate_INarrator narrator : narrators) {
                narrator.httpResponse(response);
            }
        } else {
            output(DEBUG, response == null ? '' : response.toString());
        }
    }

    public static void rest(RestRequest request) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            for(narrate_INarrator narrator : narrators) {
                narrator.restRequest(request);
            }
        } else {
            output(DEBUG, request == null ? '' : request.toString());
        }
    }

    public static void rest(RestResponse response) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            for(narrate_INarrator narrator : narrators) {
                narrator.restResponse(response);
            }
        } else {
            output(DEBUG, response == null ? '' : response.toString());
        }
    }

    public static void start(String context) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            for(narrate_INarrator narrator : narrators) {
                narrator.setContext(context);
            }
        } else {
            output(DEBUG, 'Starting context: ' + context);
        }
    }

    @testVisible
    private static List<narrate_INarrator> narrators {get {
        if(narrators == null) {
            narrators = new List<narrate_INarrator> {new narrate_SystemDebugNarrator(), new narrate_AutoContextNarrator()};
            for(narrate_INarrator narrator : narrators) {
                narrator.setCodeLocationSnapshot(makeSnapshot());
            }
        }
        return narrators;
    } set;}

    public static narrate_CodeLocationSnapshot makeSnapshot() {
        return narrate_CodeLocationSnapshot.newInstanceForClass(Narrate.class.getName());
    }
    private static Boolean narratorIsEnabled() {
        return !Test.isRunningTest() && settings.Enabled__c;
    }
    private static Boolean narratorIsEnabledTesting() {
        return Test.isRunningTest() && settings.EnabledTests__c;
    }
    private static List<Object> asList(Object obj) {return obj instanceof List<Object> ? (List<Object>)obj : new List<Object>{obj};}
    private static void output(String level, String message) {
        LoggingLevel logLevel = LoggingLevel.DEBUG; // DEBUG, WTF, REST, and anything else
        switch on level.toUpperCase() {
            when 'INFO' {
                logLevel = LoggingLevel.INFO;
            }
            when 'WARN' {
                logLevel = LoggingLevel.WARN;
            }
            when 'ERROR', 'EXCEPT' {
                logLevel = LoggingLevel.ERROR;
            }
            when 'FINE' {
                logLevel = LoggingLevel.FINE;
            }
            when 'FINER' {
                logLevel = LoggingLevel.FINER;
            }
            when 'FINEST' {
                logLevel = LoggingLevel.FINEST;
            }
        }
        System.debug(logLevel, message);
    }
    @testVisible
    private static narrate_NarratorSettings__c settings {get {
        if(settings==null){
            settings = narrate_NarratorSettings__c.getInstance();
        }
        return settings;
    } set;}
}
