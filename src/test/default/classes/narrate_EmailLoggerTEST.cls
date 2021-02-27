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
        System.assert(testEmail.Subject.contains('DeepThought'), 'Subject does not contain the Request: ' + testEmail.Subject);
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
        }catch(narrate_Exception error){
            List<narrate_LogEntry__c> testEntries = [SELECT Level__c, Class__c, Method__c, Line__c, Message__c FROM narrate_LogEntry__c];
            System.assertEquals(0, testEntries.size(), testEntries + '');
        }catch(Exception error){
            System.assertEquals('narrate_UnhandledException', error.getTypeName(), 'Caught Exception is not the correct type.');
        }
    }

    @isTest
    public static void groupLogEventsByRequest(){
        // groupLogEventsByRequest
    }

    @isTest
    public static void wrapHtmlTable(){
        List<String> htmlLines = new List<String>{'Test', 'List'};
        List<String> resultList = (new narrate_EmailLogger()).wrapHtmlTable(htmlLines);
        System.assertEquals(htmlLines.get(0), '<html>');
        System.assertEquals(htmlLines.get(1), '<body>');
        System.assertEquals(htmlLines.get(2), '<table>');
        System.assertEquals(htmlLines.get(3), '<tr><th>Level</th><th>Class</th><th>Method</th><th>Line</th><th>Message</th></tr>');
        System.assertEquals(htmlLines.get(4), 'Test');
        System.assertEquals(htmlLines.get(5), 'List');
        System.assertEquals(htmlLines.get(6), '</table>');
        System.assertEquals(htmlLines.get(7), '</body>');
        System.assertEquals(htmlLines.get(8), '</html>');
    }

    @isTest
    public static void formatLogEventsAsHTMLTableRows(){
        List<narrate_LogEvent__e> testEvents = new List<narrate_LogEvent__e>{
            new narrate_LogEvent__e(
                Level__c = 'LevelA',
                Class__c = 'ClassA',
                Method__c = 'MethodA',
                Line__c = 24,
                Message__c = 'Herp'
            ),
            new narrate_LogEvent__e(
                Level__c = 'LevelB',
                Class__c = 'ClassB',
                Method__c = 'MethodB',
                Line__c = 42,
                Message__c = 'Derp'
            )
        };
        List<String> resultList = (new narrate_EmailLogger()).formatLogEventsAsHTMLTableRows(testEvents);
        System.assertEquals(resultList.get(0), '<tr><td>LevelA</td><td>ClassA</td><td>MethodA</td><td>24</td><td>Herp</td></tr>');
        System.assertEquals(resultList.get(1), '<tr><td>LevelB</td><td>ClassB</td><td>MethodB</td><td>42</td><td>Derp</td></tr>');
    }

    @isTest
    public static void formatLogEventsAsHumanReadableText(){
        List<narrate_LogEvent__e> testEvents = new List<narrate_LogEvent__e>{
            new narrate_LogEvent__e(
                Level__c = 'LevelA',
                Class__c = 'ClassA',
                Method__c = 'MethodA',
                Line__c = 24,
                Message__c = 'Herp'
            ),
            new narrate_LogEvent__e(
                Level__c = 'LevelB',
                Class__c = 'ClassB',
                Method__c = 'MethodB',
                Line__c = 42,
                Message__c = 'Derp'
            )
        };
        List<String> resultList = (new narrate_EmailLogger()).formatLogEventsAsHumanReadableText(testEvents);
        System.assertEquals(resultList.get(0), '[LevelA] ClassA.MethodA:24\tHerp');
        System.assertEquals(resultList.get(1), '[LevelB] ClassB.MethodB:42\tDerp');
    }

    private static narrate_LogEvent__e generateTestLogEvent(){
        return new narrate_LogEvent__e(
            Level__c = 'grok',
            Class__c = 'Classy',
            Method__c = 'Methody',
            Request__c = 'DeepThought',
            Quiddity__c = 'yerawizardharry',
            Line__c = 42,
            Message__c = 'Don\'t Panic'
        );
    }
}
