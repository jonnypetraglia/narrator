public with sharing class narrate_RecordLogger implements narrate_ILogger {
    public Integer log(List<narrate_LogEvent__e> events) {
        Integer count = 0;
        try{
            Map<String, narrate_ExecutionContext__c> executionContextsByRequest = createExecutionContextsForLogEvents(events);
            Map<String, narrate_ExecutionContext__c> preexistingExecutionContexts = loadExecutionContextsByRequest(executionContextsByRequest.keySet());
            executionContextsByRequest.putAll(preexistingExecutionContexts);
            upsert executionContextsByRequest.values();
            List<narrate_LogEntry__c> logEntries = createLogEntriesForLogEvents(events, executionContextsByRequest);
            for(Database.SaveResult saveResult : Database.insert(logEntries)) {
                if(saveResult.isSuccess()) {
                    count+=1;
                }
            }
        }catch(Exception error){
            throw new narrate_NarratorException(error, 'narrate_RecordLogger');
        }
        return count;
    }

    @InvocableMethod(label='Narrator Record Logger' description='Save as a Log entry' category='narrate_LogEvent__e')
    public static List<narrate_LogEvent__e> logInvokableMethod(List<narrate_LogEvent__e> logEvents) {
        new narrate_RecordLogger().log(logEvents);
        return logEvents;
    }

    private List<narrate_LogEntry__c> createLogEntriesForLogEvents(List<narrate_LogEvent__e> events, Map<String, narrate_ExecutionContext__c> executionContextsByRequest){
        List<narrate_LogEntry__c> entries = new List<narrate_LogEntry__c>();
        for(narrate_LogEvent__e event : events){
            narrate_ExecutionContext__c execContext = executionContextsByRequest.get(event.Request__c);
            entries.add(constructEntryFromEvent(event, execContext?.Id));
        }
        return entries;
    }

    @testVisible
    private static narrate_LogEntry__c constructEntryFromEvent(narrate_LogEvent__e logEvent, Id executionContextId) {
        return new narrate_LogEntry__c(
            Class__c = logEvent.Class__c,
            ExecutionContext__c = executionContextId,
            Level__c = logEvent.Level__c,
            Line__c = logEvent.Line__c,
            Message__c = logEvent.Message__c,
            Method__c = logEvent.Method__c,
            Timestamp__c = logEvent.Timestamp__c,
            User__c = logEvent.User__c
        );
    }

    @testVisible
    private static Map<String, narrate_ExecutionContext__c> createExecutionContextsForLogEvents(List<narrate_LogEvent__e> events){
        Map<String, narrate_ExecutionContext__c> result = new Map<String, narrate_ExecutionContext__c>();
        for(narrate_LogEvent__e event : events){
            result.put(event.Request__c, new narrate_ExecutionContext__c(Request__c = event.Request__c, Quiddity__c = event.Quiddity__c));
        }
        result.remove(null);
        return result;
    }

    @testVisible
    private static Map<String, narrate_ExecutionContext__c> loadExecutionContextsByRequest(Set<String> requests) {
        Map<String, narrate_ExecutionContext__c> result = new Map<String, narrate_ExecutionContext__c>();
        List<narrate_ExecutionContext__c> execs = [SELECT Id, Name, Request__c, Quiddity__c FROM narrate_ExecutionContext__c WHERE Request__c IN :requests];
        for(narrate_ExecutionContext__c exec : execs){
            result.put(exec.Request__c, exec);
        }
        return result;
    }
}
