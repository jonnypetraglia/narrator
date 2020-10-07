@isTest
public class narrate_EmailLoggerTEST {

    @isTest
    public static void logWithRecipients(){
        narrate_LogEvent__e testEvent = generateTestLogEvent();
        Integer testEmailInvocations = Limits.getEmailInvocations();
        Test.startTest();
        narrate_EmailLogger logger = new narrate_EmailLogger();
        logger.recipients = new String[] {'obiwan@star.wars', 'anakin@star.wars'};
        Integer successCount = logger.log(new List<narrate_LogEvent__e>{testEvent});
        Integer resultEmailInvocations = Limits.getEmailInvocations();
        Test.stopTest();
        System.assertEquals(1, successCount);
        System.asserTEquals(testEmailInvocations+1, resultEmailInvocations);
    }

    @isTest
    public static void logWithoutRecipients(){
        narrate_LogEvent__e testEvent = generateTestLogEvent();
        Integer testEmailInvocations = Limits.getEmailInvocations();
        Test.startTest();
        narrate_EmailLogger logger = new narrate_EmailLogger();
        logger.recipients = narrate_EmailLogger.NOT_APPLICABLE_VALUES;
        Integer successCount = logger.log(new List<narrate_LogEvent__e>{testEvent});
        Integer resultEmailInvocations = Limits.getEmailInvocations();
        Test.stopTest();
        System.assertEquals(0, successCount);
        System.asserTEquals(testEmailInvocations, resultEmailInvocations);
    }

    @isTest
    public static void generateEmails() {
        narrate_LogEvent__e event = generateTestLogEvent();
        narrate_EmailLogger logger = new narrate_EmailLogger();
        logger.recipients = new String[] {'test@test.test'};
        List<Messaging.SingleEmailMessage> testEmails = logger.generateEmails(new List<narrate_LogEvent__e>{event});
        System.assertEquals(1, testEmails.size());
        Messaging.SingleEmailMessage testEmail = testEmails.get(0);
        System.assertEquals(testEmail.toAddresses, new String[]{'test@test.test'});
        System.assert(testEmail.Subject.contains('grok'), testEmail.Subject);
        System.assert(testEmail.PlainTextBody.contains('Classy'), testEmail.PlainTextBody);
        System.assert(testEmail.PlainTextBody.contains('Methody'), testEmail.PlainTextBody);
        System.assert(testEmail.PlainTextBody.contains('Don\'t Panic'), testEmail.PlainTextBody);
    }

    private static narrate_LogEvent__e generateTestLogEvent(){
        return new narrate_LogEvent__e(
            narrate_Level__c = 'grok',
            narrate_Class__c = 'Classy',
            narrate_Method__c = 'Methody',
            narrate_Line__c = 42,
            narrate_Message__c = 'Don\'t Panic',
            narrate_Context__c = 'Where\'s your towel?'
        );
    }
}
