public with sharing class narrate_Utilities {

    @testVisible
    private static System.Request systemRequest {get {
        if(systemRequest==null){
            systemRequest = System.Request.getCurrent();
        }
        return systemRequest;
    } set;}

    public static List<String> castToStringList(List<Object> values) {
        List<String> result = new List<String>();
        if(values!= null) {
            for(Object value : values)
                result.add('' + value);
        }
        return result;
    }
    public static narrate_LogEntry__c constructEntryFromEvent(narrate_LogEvent__e logEvent, Id executionContextId) {
        return new narrate_LogEntry__c(
            narrate_Class__c = logEvent.narrate_Class__c,
            narrate_ExecutionContext__c = executionContextId,
            narrate_Level__c = logEvent.narrate_Level__c,
            narrate_Line__c = logEvent.narrate_Line__c,
            narrate_Message__c = logEvent.narrate_Message__c,
            narrate_Method__c = logEvent.narrate_Method__c,
            narrate_Quiddity__c = logEvent.narrate_Quiddity__c,
            narrate_Timestamp__c = logEvent.narrate_Timestamp__c,
            narrate_User__c = logEvent.narrate_User__c
        );
    }
    public static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, String level, String message, String systemRequest, String quiddity) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = level,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = message,
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = quiddity,
            narrate_Request__c = systemRequest,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, Exception error, String systemRequest, String quiddity) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.EXCEPT,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = error.getMessage(),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = quiddity,
            narrate_Request__c = systemRequest,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, RestRequest request, String systemRequest, String quiddity) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.REST,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = JSON.serialize(request),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = quiddity,
            narrate_Request__c = systemRequest,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, RestResponse response, String systemRequest, String quiddity) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.REST,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = JSON.serialize(response),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = quiddity,
            narrate_Request__c = systemRequest,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, HttpRequest request, String systemRequest, String quiddity) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.REST,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = request.toString(),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = quiddity,
            narrate_Request__c = systemRequest,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(narrate_CodeLocationSnapshot.Snapshot codeLocation, HttpResponse response, String systemRequest, String quiddity) {
        return new narrate_LogEvent__e(
            narrate_Class__c = codeLocation.theClass,
            narrate_Level__c = Narrate.REST,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = response.toString(),
            narrate_Method__c = codeLocation.theMethod,
            narrate_Quiddity__c = quiddity,
            narrate_Request__c = systemRequest,
            narrate_Timestamp__c = System.now(),
            narrate_User__c = UserInfo.getUserId()
        );
    }
    public static List<narrate_LogEntry__c> createLogEntriesAndNeededExecutionContexts(List<narrate_LogEvent__e> logEvents) {
        List<narrate_ExecutionContext__c> executionContexts = makeMissingExecutionContextsFromEvents(logEvents);
        insert executionContexts;
        Set<String> requests = extractRequestsFromLogEvents(logEvents);
        Map<String, narrate_ExecutionContext__c> existingExecutionContexts = getMapOfExistingExecutionContextsByRequest(requests);
        existingExecutionContexts.putAll(makeMapOfExecutionContextsByRequest(executionContexts));
        List<narrate_LogEntry__c> logEntriesToCreate = new List<narrate_LogEntry__c>();
        for(narrate_LogEvent__e logEvent : logEvents) {
            narrate_LogEntry__c entry = constructEntryFromEvent(logEvent, existingExecutionContexts.get(logEvent.narrate_Request__c).Id);
            logEntriesToCreate.add(entry);
        }
        return logEntriesToCreate;
    }

    @testVisible
    private static List<narrate_ExecutionContext__c> makeMissingExecutionContextsFromEvents(List<narrate_LogEvent__e> logEvents) {
        Set<String> potentiallyNewUniqueKeys = extractRequestsFromLogEvents(logEvents);
        Map<String, narrate_ExecutionContext__c> existingExecutionContexts = getMapOfExistingExecutionContextsByRequest(potentiallyNewUniqueKeys);
        Map<String, narrate_LogEvent__e> logEventsByRequest = makeMapOfLogEventsByRequest(logEvents);
        logEventsByRequest = (Map<String, narrate_LogEvent__e>)removeExistingKeysFromMap(logEventsByRequest, existingExecutionContexts.keySet());
        return constructExecutionContextsForLogEvents(logEventsByRequest.values());
    }
    private static Map<String, Object> removeExistingKeysFromMap(Map<String, Object> objects, Set<String> keysToRemove){
        for(String key : keysToRemove){
            objects.remove(key);
        }
        return objects;
    }
    @testVisible
    private static Map<String, narrate_LogEvent__e> makeMapOfLogEventsByRequest(List<narrate_LogEvent__e> logEvents) {
        Map<String, narrate_LogEvent__e> result = new Map<String, narrate_LogEvent__e>();
        for(narrate_LogEvent__e logEvent : logEvents)
            result.put(logEvent.narrate_Request__c, logEvent);
        return result;
    }
    @testVisible
    private static Map<String, narrate_ExecutionContext__c> getMapOfExistingExecutionContextsByRequest(Set<String> requests) {
        return makeMapOfExecutionContextsByRequest(loadExecutionContextsByRequest(requests));
    }
    @testVisible
    private static Map<String, narrate_ExecutionContext__c> makeMapOfExecutionContextsByRequest(List<narrate_ExecutionContext__c> logs) {
        Map<String, narrate_ExecutionContext__c> mapRequestToExecutionContext = new Map<String, narrate_ExecutionContext__c>();
        for(narrate_ExecutionContext__c log : logs)
            mapRequestToExecutionContext.put(log.narrate_Request__c, log);
        return mapRequestToExecutionContext;
    }
    @testVisible
    private static List<narrate_ExecutionContext__c> constructExecutionContextsForLogEvents(List<narrate_LogEvent__e> logEvents) {
        List<narrate_ExecutionContext__c> executionContexts = new List<narrate_ExecutionContext__c>();
        Set<String> requestRemaining = extractRequestsFromLogEvents(logEvents);
        for(narrate_LogEvent__e logEvent : logEvents){
            if(requestRemaining.contains(logEvent.narrate_Request__c)){
                executionContexts.add(new narrate_ExecutionContext__c(narrate_Request__c = logEvent.narrate_Request__c, narrate_Quiddity__c = logEvent.narrate_Quiddity__c));
                requestRemaining.add(logEvent.narrate_Request__c);
            }
        }
        return executionContexts;
    }
    @testVisible
    private static Set<String> extractRequestsFromLogEvents(List<narrate_LogEvent__e> logEvents) {
        Set<String> requests = new Set<String>();
        for(narrate_LogEvent__e logEvent : logEvents)
        requests.add(logEvent.narrate_Request__c);
        return requests;
    }
    private static List<narrate_ExecutionContext__c> loadExecutionContextsByRequest(Set<String> requests) {
        return [SELECT Id, Name, narrate_Request__c, narrate_Quiddity__c FROM narrate_ExecutionContext__c WHERE narrate_Request__c IN :requests];
    }
    // TODO: Prolly rename
    private static Set<String> getWhatsNew(Set<String> existingSets, Set<String> potentiallyNewSets) {
        Set<String> result = new Set<String>();
        for(String potentiallyNewSet : potentiallyNewSets)
            if(!existingSets.contains(potentiallyNewSet))
                result.add(potentiallyNewSet);
        return result;
    }
}
