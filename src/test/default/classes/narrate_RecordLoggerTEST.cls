@isTest
public class narrate_RecordLoggerTEST {
    @isTest
    public static void testLog() {
        narrate_LogEvent__e event = new narrate_LogEvent__e(
            narrate_Level__c = 'grok',
            narrate_Class__c = 'Classy',
            narrate_Method__c = 'Methody',
            narrate_Line__c = 42,
            narrate_Message__c = 'Don\'t Panic'
        );
        narrate_RecordLogger logger = new narrate_RecordLogger();
        Integer successCount = logger.log(new List<narrate_LogEvent__e>{event});
        System.assertEquals(1, successCount);
        List<narrate_LogEntry__c> testEntries = [SELECT narrate_Level__c, narrate_Class__c, narrate_Method__c, narrate_Line__c, narrate_Message__c, narrate_Request__c, narrate_Quiddity__c FROM narrate_LogEntry__c];
        System.assertEquals(1, testEntries.size(), testEntries + '');
        narrate_LogEntry__c testEntry = testEntries.get(0);
        System.assertEquals('grok', testEntry.narrate_Level__c);
        System.assertEquals('Classy', testEntry.narrate_Class__c);
        System.assertEquals('Methody', testEntry.narrate_Method__c);
        System.assertEquals(42, testEntry.narrate_Line__c);
        System.assertEquals('Don\'t Panic', testEntry.narrate_Message__c);
    }

    @isTest
    public static void testLogFailure() {
        narrate_LogEvent__e event = new narrate_LogEvent__e();
        narrate_RecordLogger logger = new narrate_RecordLogger();
        Integer successCount = logger.log(new List<narrate_LogEvent__e>{event});
        System.assertEquals(0, successCount);
        List<narrate_LogEntry__c> testEntries = [SELECT narrate_Level__c, narrate_Class__c, narrate_Method__c, narrate_Line__c, narrate_Message__c, narrate_Request__c, narrate_Quiddity__c FROM narrate_LogEntry__c];
        System.assertEquals(0, testEntries.size(), testEntries + '');
    }
}
