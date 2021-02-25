@isTest
public class narrate_LogEntryTruncatorTEST {
    private static final Integer TEST_RECORD_QUANTITY = 200;
    private static final Date ALL_TIME = Date.newInstance(1970, 1, 1);
    private static final Date TEST_DATE = Date.today(); //Date.newInstance(1952, 3, 11);

    @TestSetup
    private static void makeData(){
        List<narrate_ExecutionContext__c> testExecutionContexts = generateTestExecutionContexts(TEST_RECORD_QUANTITY);
        insert testExecutionContexts;
        List<narrate_LogEntry__c> testLogEntries = generateTestLogEntries(testExecutionContexts);
        insert testLogEntries;
        System.assertEquals(TEST_RECORD_QUANTITY, [SELECT Id FROM narrate_ExecutionContext__c WHERE EndTime__c != null].size());
    }

    @isTest
    private static void truncateFromSettings(){
        narrate_LogEntryTruncator truncator = new narrate_LogEntryTruncator();
        Integer numberToKeep = 42;
        Integer numberToDelete = TEST_RECORD_QUANTITY - numberToKeep;
        truncator.settings = new narrate_NarratorConfig__c(AutoTruncateDays__c=numberToKeep, AutoTruncateMax__c=null);
        truncator.execute(null);
        List<SObject> resultSObjects = [SELECT Id FROM narrate_ExecutionContext__c];
        System.assertEquals(numberToKeep, resultSObjects.size(), 'Unexpected number of results returned.');
        truncator.settings = new narrate_NarratorConfig__c(AutoTruncateDays__c=null, AutoTruncateMax__c=numberToKeep);
        truncator.execute(null);
        resultSObjects = [SELECT Id FROM narrate_ExecutionContext__c];
        System.assertEquals(numberToKeep, resultSObjects.size(), 'Unexpected number of results returned.');
    }

    @isTest
    private static void truncateWithMax(){
        narrate_LogEntryTruncator truncator = new narrate_LogEntryTruncator();
        Integer numberToKeep = 42;
        truncator.truncate(numberToKeep);
        List<SObject> resultSObjects = [SELECT Id FROM narrate_ExecutionContext__c];
        System.assertEquals(numberToKeep, resultSObjects.size(), 'Unexpected number of results returned.');
    }

    @isTest
    private static void truncateWithAfter(){
        narrate_LogEntryTruncator truncator = new narrate_LogEntryTruncator();
        Integer numberToKeep = 42;
        truncator.truncate(TEST_DATE.addDays(-1 * numberToKeep));
        List<SObject> resultSObjects = [SELECT Id FROM narrate_ExecutionContext__c];
        System.assertEquals(numberToKeep, resultSObjects.size(), 'Unexpected number of results returned.');
    }

    @isTest
    private static void getAllObjectsToDelete(){
        List<SObject> testSObjects = [SELECT Id FROM narrate_ExecutionContext__c];
        System.assertEquals(TEST_RECORD_QUANTITY, testSObjects.size());
        narrate_LogEntryTruncator truncator = new narrate_LogEntryTruncator();
        List<SObject> resultSObjects = truncator.getObjectsToDelete(ALL_TIME, TEST_RECORD_QUANTITY);
        System.assertEquals(0, resultSObjects.size(), 'Unexpected number of results returned.');
        Integer numberToKeep = 42;
        Integer numberToDelete = TEST_RECORD_QUANTITY - numberToKeep;
        resultSObjects = truncator.getObjectsToDelete(TEST_DATE.addDays(-1 * numberToKeep), TEST_RECORD_QUANTITY);
        System.assertEquals(numberToDelete, resultSObjects.size(), 'Unexpected number of results returned.');
        resultSObjects = truncator.getObjectsToDelete(ALL_TIME, numberToKeep);
        System.assertEquals(numberToDelete, resultSObjects.size(), 'Unexpected number of results returned.');
    }

    @isTest
    private static void getObjectsToDeleteWithAfter(){
        List<SObject> testSObjects = [SELECT Id FROM narrate_ExecutionContext__c];
        System.assertEquals(TEST_RECORD_QUANTITY, testSObjects.size());
        Integer numberToKeep = 42;
        Integer numberToDelete = TEST_RECORD_QUANTITY - numberToKeep;
        narrate_LogEntryTruncator truncator = new narrate_LogEntryTruncator();
        List<SObject> resultSObjects = truncator.getObjectsToDelete(TEST_DATE.addDays(-1 * numberToKeep), TEST_RECORD_QUANTITY);
        System.assertEquals(numberToDelete, resultSObjects.size(), 'Unexpected number of results returned.');
    }

    @isTest
    private static void getObjectsToDeleteWithMax(){
        List<SObject> testSObjects = [SELECT Id FROM narrate_ExecutionContext__c];
        System.assertEquals(TEST_RECORD_QUANTITY, testSObjects.size());
        Integer numberToKeep = 42;
        Integer numberToDelete = TEST_RECORD_QUANTITY - numberToKeep;
        narrate_LogEntryTruncator truncator = new narrate_LogEntryTruncator();
        List<SObject> resultSObjects = truncator.getObjectsToDelete(ALL_TIME, numberToKeep);
        System.assertEquals(numberToDelete, resultSObjects.size(), 'Unexpected number of results returned.');
    }

    private static List<narrate_ExecutionContext__c> generateTestExecutionContexts(Integer quantity){
        List<narrate_ExecutionContext__c> result = new List<narrate_ExecutionContext__c>();
        for(Integer i=0; i<quantity; i++){
            result.add(new narrate_ExecutionContext__c());
        }
        return result;
    }

    private static List<narrate_LogEntry__c> generateTestLogEntries(List<narrate_ExecutionContext__c> testExecutionContexts){
        List<narrate_LogEntry__c> entries = new List<narrate_LogEntry__c>();
        for(Integer i=0; i<testExecutionContexts.size(); i++){
            entries.add(new narrate_LogEntry__c(
                ExecutionContext__c=testExecutionContexts.get(i).Id,
                Timestamp__c=TEST_DATE.addDays(-1 * i - 1)
            ));
        }
        return entries;
    }
}
