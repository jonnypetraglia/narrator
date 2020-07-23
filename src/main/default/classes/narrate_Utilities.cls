public with sharing class narrate_Utilities {
    public static List<String> castToStringList(List<Object> values) {
        List<String> result = new List<String>();
        if(values!= null) {
            for(Object value : values)
                result.add('' + value);
        }
        return result;
    }
    public static narrate_LogEntry__c constructEntryFromEvent(narrate_LogEvent__e event, Id executionContextId) {
        return new narrate_LogEntry__c(
            narrate_ExecutionContext__c = executionContextId,
            narrate_Class__c = event.narrate_Class__c,
            narrate_Context__c = event.narrate_Context__c,
            narrate_Level__c = event.narrate_Level__c,
            narrate_Line__c = event.narrate_Line__c,
            narrate_Message__c = event.narrate_Message__c,
            narrate_Method__c = event.narrate_Method__c,
            narrate_Timestamp__c = event.narrate_Timestamp__c,
            narrate_User__c = event.narrate_User__c
        );
    }
    public static narrate_LogEvent__e constructLogEvent(String context, narrate_CodeLocationSnapshot.Snapshot codeLocation, String level, String message) {
        return new narrate_LogEvent__e(
            narrate_Context__c = context,
            narrate_Level__c = level,
            narrate_Class__c = codeLocation.theClass,
            narrate_Method__c = codeLocation.theMethod,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = message,
            narrate_User__c = UserInfo.getUserId(),
            narrate_Timestamp__c = System.now()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(String context, narrate_CodeLocationSnapshot.Snapshot codeLocation, Exception error) {
        return new narrate_LogEvent__e(
            narrate_Context__c = context,
            narrate_Level__c = Narrate.EXCEPT,
            narrate_Class__c = codeLocation.theClass,
            narrate_Method__c = codeLocation.theMethod,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = error.getMessage(),
            narrate_User__c = UserInfo.getUserId(),
            narrate_Timestamp__c = System.now()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(String context, narrate_CodeLocationSnapshot.Snapshot codeLocation, RestRequest request) {
        return new narrate_LogEvent__e(
            narrate_Context__c = context,
            narrate_Level__c = Narrate.REST,
            narrate_Class__c = codeLocation.theClass,
            narrate_Method__c = codeLocation.theMethod,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = JSON.serialize(request),
            narrate_User__c = UserInfo.getUserId(),
            narrate_Timestamp__c = System.now()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(String context, narrate_CodeLocationSnapshot.Snapshot codeLocation, RestResponse response) {
        return new narrate_LogEvent__e(
            narrate_Context__c = context,
            narrate_Level__c = Narrate.REST,
            narrate_Class__c = codeLocation.theClass,
            narrate_Method__c = codeLocation.theMethod,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = JSON.serialize(response),
            narrate_User__c = UserInfo.getUserId(),
            narrate_Timestamp__c = System.now()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(String context, narrate_CodeLocationSnapshot.Snapshot codeLocation, HttpRequest request) {
        return new narrate_LogEvent__e(
            narrate_Context__c = context,
            narrate_Level__c = Narrate.REST,
            narrate_Class__c = codeLocation.theClass,
            narrate_Method__c = codeLocation.theMethod,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = request.toString(),
            narrate_User__c = UserInfo.getUserId(),
            narrate_Timestamp__c = System.now()
        );
    }
    public static narrate_LogEvent__e constructLogEvent(String context, narrate_CodeLocationSnapshot.Snapshot codeLocation, HttpResponse response) {
        return new narrate_LogEvent__e(
            narrate_Context__c = context,
            narrate_Level__c = Narrate.REST,
            narrate_Class__c = codeLocation.theClass,
            narrate_Method__c = codeLocation.theMethod,
            narrate_Line__c = codeLocation.theLine,
            narrate_Message__c = response.toString(),
            narrate_User__c = UserInfo.getUserId(),
            narrate_Timestamp__c = System.now()
        );
    }
    
    public static List<narrate_LogEntry__c> createLogEntriesAndNeededExecutionContexts(List<narrate_LogEvent__e> events) {
        List<narrate_ExecutionContext__c> executionContexts = makeMissingExecutionContextsFromEvents(events);
        insert executionContexts;
        Set<String> uniqueKeys = extractContexts(events);
        Map<String, narrate_ExecutionContext__c> existingExecutionContexts = getMapOfExistingExecutionContextsByNameForContexts(uniqueKeys);
        existingExecutionContexts.putAll(makeMapOfExecutionContextsByName(executionContexts));
        List<narrate_LogEntry__c> logEntriesToCreate = new List<narrate_LogEntry__c>();
        for(narrate_LogEvent__e event : events) {
            narrate_LogEntry__c entry = constructEntryFromEvent(event, existingExecutionContexts.get(event.narrate_Context__c).Id);
            logEntriesToCreate.add(entry);
        }
        return logEntriesToCreate;
    }
    public static List<narrate_ExecutionContext__c> makeMissingExecutionContextsFromEvents(List<narrate_LogEvent__e> events) {
        Set<String> potentiallyNewUniqueKeys = extractContexts(events);
        Map<String, narrate_ExecutionContext__c> existingExecutionContexts = getMapOfExistingExecutionContextsByNameForContexts(potentiallyNewUniqueKeys);
        Set<String> contextsToCreate = getWhatsNew(existingExecutionContexts.keySet(), potentiallyNewUniqueKeys);
        return constructExecutionContextsForContexts(contextsToCreate);
    }
    public static Map<String, narrate_ExecutionContext__c> getMapOfExistingExecutionContextsByNameForContexts(Set<String> potentiallyNewUniqueKeys) {
        return makeMapOfExecutionContextsByName(loadLogsByExecutionContext(potentiallyNewUniqueKeys));
    }
    public static Map<String, narrate_ExecutionContext__c> makeMapOfExecutionContextsByName(List<narrate_ExecutionContext__c> logs) {
        Map<String, narrate_ExecutionContext__c> mapNameToExecutionContext = new Map<String, narrate_ExecutionContext__c>();
        for(narrate_ExecutionContext__c log : logs)
            mapNameToExecutionContext.put(log.Name, log);
        return mapNameToExecutionContext;
    }
    public static List<narrate_ExecutionContext__c> constructExecutionContextsForContexts(Set<String> contexts) {
        List<narrate_ExecutionContext__c> executionContexts = new List<narrate_ExecutionContext__c>();
        for(String context : contexts)
            executionContexts.add(new narrate_ExecutionContext__c(Name=context));
        return executionContexts;
    }
    public static Set<String> extractContexts(List<narrate_LogEvent__e> logEvents) {
        Set<String> contexts = new Set<String>();
        for(narrate_LogEvent__e logEvent : logEvents)
            contexts.add(logEvent.narrate_Context__c);
        return contexts;
    }
    public static List<narrate_ExecutionContext__c> loadLogsByExecutionContext(Set<String> contexts) {
        return [SELECT Id, Name FROM narrate_ExecutionContext__c WHERE Name IN :contexts];
    }

    // TODO: Prolly rename
    public static Set<String> getWhatsNew(Set<String> existingSets, Set<String> potentiallyNewSets) {
        Set<String> result = new Set<String>();
        for(String potentiallyNewSet : potentiallyNewSets)
            if(!existingSets.contains(potentiallyNewSet))
                result.add(potentiallyNewSet);
        return result;
    }
}
