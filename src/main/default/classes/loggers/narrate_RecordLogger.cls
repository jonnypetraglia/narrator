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

    @testVisible
    private List<narrate_LogEntry__c> createLogEntriesForLogEvents(List<narrate_LogEvent__e> events, Map<String, narrate_ExecutionContext__c> executionContextsByRequest){
        List<narrate_LogEntry__c> entries = new List<narrate_LogEntry__c>();
        for(narrate_LogEvent__e event : events){
            narrate_ExecutionContext__c execContext = executionContextsByRequest.get(event.narrate_Request__c);
            entries.add(constructEntryFromEvent(event, execContext?.Id));
        }
        return entries;
    }

    @testVisible
    private static narrate_LogEntry__c constructEntryFromEvent(narrate_LogEvent__e logEvent, Id executionContextId) {
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

    @testVisible
    private Map<String, narrate_ExecutionContext__c> createExecutionContextsForLogEvents(List<narrate_LogEvent__e> events){
        Map<String, narrate_ExecutionContext__c> result = new Map<String, narrate_ExecutionContext__c>();
        for(narrate_LogEvent__e event : events){
            result.put(event.narrate_Request__c, new narrate_ExecutionContext__c(narrate_Request__c = event.narrate_Request__c, narrate_Quiddity__c = event.narrate_Quiddity__c));
        }
        return result;
    }

    @testVisible
    private static Map<String, narrate_ExecutionContext__c> loadExecutionContextsByRequest(Set<String> requests) {
        Map<String, narrate_ExecutionContext__c> result = new Map<String, narrate_ExecutionContext__c>();
        List<narrate_ExecutionContext__c> execs = [SELECT Id, Name, narrate_Request__c, narrate_Quiddity__c FROM narrate_ExecutionContext__c WHERE narrate_Request__c IN :requests];
        for(narrate_ExecutionContext__c exec : execs){
            result.put(exec.narrate_Request__c, exec);
        }
        return result;
    }
}
