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

    @isTest
    public static void logFailure() {
        try {
            narrate_EmailLogger logger = new narrate_EmailLogger();
            logger.recipients = new String[] {'bademail'};
            logger.log(null);
            System.assert(false, 'Expected exception to be thrown but none was.');
        }catch(narrate_NarratorException error){
            List<narrate_LogEntry__c> testEntries = [SELECT narrate_Level__c, narrate_Class__c, narrate_Method__c, narrate_Line__c, narrate_Message__c, narrate_Request__c, narrate_Quiddity__c FROM narrate_LogEntry__c];
            System.assertEquals(0, testEntries.size(), testEntries + '');
        }catch(Exception error){
            System.assertEquals('narrate_NarratorException', error.getTypeName(), 'Caught Exception is not the correct type.');
        }
    }

    private static narrate_LogEvent__e generateTestLogEvent(){
        return new narrate_LogEvent__e(
            narrate_Level__c = 'grok',
            narrate_Class__c = 'Classy',
            narrate_Method__c = 'Methody',
            narrate_Line__c = 42,
            narrate_Message__c = 'Don\'t Panic'
            // TODO: Request & Quiddity?
        );
    }
}
