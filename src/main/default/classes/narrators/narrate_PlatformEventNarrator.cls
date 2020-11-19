public without sharing class narrate_PlatformEventNarrator implements narrate_INarrator {

    public narrate_PlatformEventNarrator() {}

    public void log(String level, String message, List<Object> values) {
        String formattedMessage = String.format(message, castToStringList(values));
        narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), level, formattedMessage);
        EventBus.publish(logData);
    }

    public void except(Exception error) {
        narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(error), error);
        EventBus.publish(logData);
    }

    public void restRequest(RestRequest request) {
        narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), request);
        EventBus.publish(logData);
    }

    public void restResponse(RestResponse response) {
        narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), response);
        EventBus.publish(logData);
    }

    public void httpRequest(HttpRequest request) {
        narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), request);
        EventBus.publish(logData);
    }

    public void httpResponse(HttpResponse response) {
        narrate_LogEvent__e logData = constructLogEvent(snapshot.snap(), response);
        EventBus.publish(logData);
    }

    public void setCodeLocationSnapshot(narrate_CodeLocationSnapshot snapshot) {
        this.snapshot = snapshot;
    }

    // PRIVATE

    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, String level, String message) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = level,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = message,
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            narrate_Request__c = CURRENT_REQUEST_ID,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, Exception error) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.EXCEPT,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = error.getMessage(),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            narrate_Request__c = CURRENT_REQUEST_ID,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, RestRequest request) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.REST,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = JSON.serialize(request),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            narrate_Request__c = CURRENT_REQUEST_ID,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, RestResponse response) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.REST,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = JSON.serialize(response),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            narrate_Request__c = CURRENT_REQUEST_ID,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, HttpRequest request) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.REST,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = request.toString(),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            narrate_Request__c = CURRENT_REQUEST_ID,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    @testVisible
    private static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, HttpResponse response) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.REST,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = response.toString(),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = CURRENT_REQUEST_QUIDDITY,
            narrate_Request__c = CURRENT_REQUEST_ID,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
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