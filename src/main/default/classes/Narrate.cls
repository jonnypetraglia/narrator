/*
    This is the heart of Narrator and what should be primarly used in external code.


    A sane logging class designed to be extended (i.e. virtual) to be able to use a custom name for use throughout code.
    The extended class can then make its own custom functions (e.g. error(String message, Exception error)) while also providing what is in this class as a base.


    A full list of what it provides:
        (1) Functions for the built in LoggingLevels and a few more that all take (a) a String, (b) a String and an object (formatted with String.format, so include '{0}' in your message), and a List of Strings (also formatted with String.format). Valid levels are:
            - Debug
            - Info
            - Warn(ing)
            - Error
            - Fine
            - Finer
            - Finest
            - WTF (What a Terrible Failure); treated as ERROR when output to System.debug
            - Except; meant to parse Exceptions into a pretty readable format, treated as ERROR when output to System.debug
            - HTTP; for HTTP requests and responses, treated as DEBUG when output to System.debug
            - REST; for REST requests and resposes, treated as DEBUG when output to System.debug
        (2) Ability to be enabled/disabled in production and tests via NarratorConfig Custom Settings. If disabled, only outputs to System.debug
        (3) Access to Quiddity and RequestId
        (4) Auto-inserts Timestamp__c and User__c for narrate_LogEvent__e Platform Events
        (5) Auto-inserts Timestamp__c and User__c for narrate_LogEvent__e Platform Events
        (6) Auto-inserts Class__c, Method__c, and Line__c for narrate_LogEvent__e Platform Events behind the scenes (via CodeLocationSnapshot)
*/

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
                X_HTTP = 'Http',
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
    // "What a Terrible Failure"
    public static void wtf(String message) {
        log(WTF, message, new List<Object>());
    }
    public static void wtf(String message, Object param) {
        log(WTF, message, asList(param));
    }
    public static void wtf(String message, List<Object> values) {
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
            String formattedMessage = String.format(message, castToStringList(values));
            narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), level, formattedMessage);
            Database.SaveResult result = EventBus.publish(logData);
        }
        systemDebugOutput(level, String.format(message, values));
    }
    public static void except(Exception ohno) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(ohno), ohno);
            EventBus.publish(logData);
        }
        systemDebugOutput(ERROR, ohno.getTypeName() + ': ' + ohno.getMessage());
        systemDebugOutput(ERROR, ohno.getStackTraceString());
    }
    public static void http(HttpRequest request) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), request);
            EventBus.publish(logData);
        }
        systemDebugOutput(DEBUG, request == null ? '' : request.toString());
    }
    public static void http(HttpResponse response) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), response);
            EventBus.publish(logData);
        }
        systemDebugOutput(DEBUG, response == null ? '' : response.toString());
    }
    public static void rest(RestRequest request) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), request);
            EventBus.publish(logData);
        }
        systemDebugOutput(DEBUG, request == null ? '' : request.toString());
    }
    public static void rest(RestResponse response) {
        if(narratorIsEnabled() || narratorIsEnabledTesting()) {
            narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), response);
            EventBus.publish(logData);
        }
        systemDebugOutput(DEBUG, response == null ? '' : response.toString());
    }

    // PRIVATE

    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, String level, String message) {
        return new narrate_LogEvent__e(
            Class__c = codeLocation.theClass,
            Level__c = level,
            Line__c = codeLocation.theLine,
            Message__c = message,
            Method__c = codeLocation.theMethod,
            Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            Request__c = CURRENT_REQUEST_ID,
            Timestamp__c = System.now(),
            User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, Exception error) {
        return new narrate_LogEvent__e(
            Class__c = codeLocation.theClass,
            Level__c = Narrate.EXCEPT,
            Line__c = codeLocation.theLine,
            Message__c = error.getMessage(),
            Method__c = codeLocation.theMethod,
            Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            Request__c = CURRENT_REQUEST_ID,
            Timestamp__c = System.now(),
            User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, RestRequest request) {
        return new narrate_LogEvent__e(
            Class__c = codeLocation.theClass,
            Level__c = Narrate.REST,
            Line__c = codeLocation.theLine,
            Message__c = JSON.serialize(request),
            Method__c = codeLocation.theMethod,
            Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            Request__c = CURRENT_REQUEST_ID,
            Timestamp__c = System.now(),
            User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, RestResponse response) {
        return new narrate_LogEvent__e(
            Class__c = codeLocation.theClass,
            Level__c = Narrate.REST,
            Line__c = codeLocation.theLine,
            Message__c = JSON.serialize(response),
            Method__c = codeLocation.theMethod,
            Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            Request__c = CURRENT_REQUEST_ID,
            Timestamp__c = System.now(),
            User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, HttpRequest request) {
        return new narrate_LogEvent__e(
            Class__c = codeLocation.theClass,
            Level__c = Narrate.REST,
            Line__c = codeLocation.theLine,
            Message__c = request.toString(),
            Method__c = codeLocation.theMethod,
            Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            Request__c = CURRENT_REQUEST_ID,
            Timestamp__c = System.now(),
            User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, HttpResponse response) {
        return new narrate_LogEvent__e(
            Class__c = codeLocation.theClass,
            Level__c = Narrate.REST,
            Line__c = codeLocation.theLine,
            Message__c = response.toString(),
            Method__c = codeLocation.theMethod,
            Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            Request__c = CURRENT_REQUEST_ID,
            Timestamp__c = System.now(),
            User__c = UserInfo.getUserId()
        );
    }
    private static List<String> castToStringList(List<Object> values) {
        List<String> result = new List<String>();
        if(values!= null) {
            for(Object value : values)
                result.add('' + value);
        }
        return result;
    }
    @testVisible
    private static final String CURRENT_REQUEST_ID {get {
        if(CURRENT_REQUEST_ID==null){
            CURRENT_REQUEST_ID =  System.Request.getCurrent().getRequestId();
        }
        return CURRENT_REQUEST_ID;
    } private set;}
    @testVisible
    private static final String CURRENT_REQUEST_QUIDDITY {get {
        if(CURRENT_REQUEST_QUIDDITY==null){
            CURRENT_REQUEST_QUIDDITY = String.valueOf( System.Request.getCurrent().getQuiddity());
        }
        return CURRENT_REQUEST_QUIDDITY;
    } private set;}
    @testVisible
    private static narrate_CodeLocationSnapshot snapshot {get {
        if(snapshot==null){
            snapshot = narrate_CodeLocationSnapshot.newInstanceForClass(Narrate.class.getName());
        }
        return snapshot;
    } set;}
    private static Boolean narratorIsEnabled() {
        return !Test.isRunningTest() && settings.Enabled__c;
    }
    private static Boolean narratorIsEnabledTesting() {
        return Test.isRunningTest() && settings.EnabledTests__c;
    }
    private static List<Object> asList(Object obj) {return obj instanceof List<Object> ? (List<Object>)obj : new List<Object>{obj};}
    private static void systemDebugOutput(String level, String message) {
        LoggingLevel logLevel = LoggingLevel.DEBUG; // DEBUG, WTF, REST, and anything else
        // Switch here gives us guaranteed O(1)
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
    private static narrate_NarratorConfig__c settings {get {
        if(settings==null){
            settings = narrate_NarratorConfig__c.getInstance();
        }
        return settings;
    } set;}
}
