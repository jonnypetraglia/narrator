public without sharing class narrate_PlatformEventNarrator implements narrate_INarrator {

    public narrate_PlatformEventNarrator() {}

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
    private narrate_CodeLocationSnapshot snapshot;
}