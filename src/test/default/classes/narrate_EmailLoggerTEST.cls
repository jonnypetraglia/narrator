@isTest
public class narrate_EmailLoggerTEST {

    @isTest
    public static void generateEmails() {
        narrate_LogEvent__e event = new narrate_LogEvent__e(
            narrate_Level__c = 'grok',
            narrate_Class__c = 'Classy',
            narrate_Method__c = 'Methody',
            narrate_Line__c = 42,
            narrate_Message__c = 'Don\'t Panic',
            narrate_Context__c = 'Where\'s your towel?'
        );
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
}
