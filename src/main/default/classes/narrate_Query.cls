public with sharing class narrate_Query {
    public static List<narrate_ExecutionContext__c> loadLogsByExecutionContext(Set<String> contexts) {
        return [SELECT Id, Name FROM narrate_ExecutionContext__c WHERE Name IN :contexts];
    }

    @AuraEnabled(cacheable=true)
    public static narrate_ExecutionContext__c loadExecutionContextsWithLogs(String logId) {
        return [SELECT Id, Name, narrate_NumberOfEntries__c, narrate_StartTime__c, narrate_EndTime__c, (SELECT Id, Name, narrate_Class__c, narrate_Context__c, narrate_Level__c, narrate_Line__c, narrate_ExecutionContext__c, narrate_Message__c, narrate_Method__c, narrate_User__c FROM narrate_LogEntries__r) FROM narrate_ExecutionContext__c WHERE Id = :logId LIMIT 1];
    }

    public static Map<Id, User> loadUsersByIDs(Set<Id> ids) {
        return new Map<Id, User>([SELECT Email FROM User WHERE Id IN :ids]);
    }
}
