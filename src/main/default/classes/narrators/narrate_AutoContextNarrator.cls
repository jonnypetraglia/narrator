public without sharing class narrate_AutoContextNarrator implements narrate_INarrator {

    public narrate_AutoContextNarrator() {
    }

    public void log(String level, String message, List<Object> values) {
        String formattedMessage = String.format(message, narrate_Utilities.castToStringList(values));
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(snapshot.snap(), level, formattedMessage, CURRENT_REQUEST_ID, CURRENT_REQUEST_QUIDDITY);
        EventBus.publish(logData);
    }

    public void except(Exception error) {
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(snapshot.snap(error), error, CURRENT_REQUEST_ID, CURRENT_REQUEST_QUIDDITY);
        EventBus.publish(logData);
    }

    public void restRequest(RestRequest request) {
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(snapshot.snap(), request, CURRENT_REQUEST_ID, CURRENT_REQUEST_QUIDDITY);
        EventBus.publish(logData);
    }

    public void restResponse(RestResponse response) {
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(snapshot.snap(), response, CURRENT_REQUEST_ID, CURRENT_REQUEST_QUIDDITY);
        EventBus.publish(logData);
    }

    public void httpRequest(HttpRequest request) {
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(snapshot.snap(), request, CURRENT_REQUEST_ID, CURRENT_REQUEST_QUIDDITY);
        EventBus.publish(logData);
    }

    public void httpResponse(HttpResponse response) {
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(snapshot.snap(), response, CURRENT_REQUEST_ID, CURRENT_REQUEST_QUIDDITY);
        EventBus.publish(logData);
    }

    public String getContext() {
        return userContext;
    }

    public void setContext(String context) {
        if(this.userContext==null) {
            this.userContext = context;
        }
    }

    public void setCodeLocationSnapshot(narrate_CodeLocationSnapshot snapshot) {
        this.snapshot = snapshot;
    }

    // PRIVATE
    @testVisible
    private static final System.Request CURRENT_REQUEST = System.Request.getCurrent();
    private static final String CURRENT_REQUEST_ID {get {
        if(CURRENT_REQUEST_ID==null){
            CURRENT_REQUEST_ID = CURRENT_REQUEST.getRequestId();
        }
        return CURRENT_REQUEST_ID;
    } private set;}
    private static final String CURRENT_REQUEST_QUIDDITY {get {
        if(CURRENT_REQUEST_QUIDDITY==null){
            CURRENT_REQUEST_QUIDDITY = String.valueOf(CURRENT_REQUEST.getQuiddity());
        }
        return CURRENT_REQUEST_QUIDDITY;
    } private set;}
    @testVisible
    private String getFullContext() {
        return AUTO_CONTEXT + (userContext!=null ? (' ' + + userContext) : '');
    }

    @testVisible
    private final String AUTO_CONTEXT {get {
        if(AUTO_CONTEXT==null){
            AUTO_CONTEXT = System.now().formatGmt('HH:mm:ss.SSS') + '  ' + CURRENT_REQUEST_ID;
        }
        return AUTO_CONTEXT;
    } private set;}
    private String userContext = null;
    @testVisible
    private narrate_CodeLocationSnapshot snapshot;
}