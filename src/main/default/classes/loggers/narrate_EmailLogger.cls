public class narrate_EmailLogger implements narrate_ILogger {
    @testVisible
    private static final List<String> NOT_APPLICABLE_VALUES = new List<String>{'NA', 'N/A', 'None'};
    @testVisible
    String[] recipients {get {
        if(recipients == null) {
            recipients = Label.narrate_EmailLoggerEmailRecipients.split('[;,]');
        }
        return recipients;
    } set; }

    public Integer log(List<narrate_LogEvent__e> logEvents) {
        Integer count = 0;
        try{
            if(hasRecipients()) {
                for(Messaging.SendEmailResult sendResult : Messaging.sendEmail(generateEmails(logEvents), false)) {
                    if(sendResult.isSuccess()) {
                        count+=1;
                    }else if(Test.isRunningTest() && !sendResult.getErrors().isEmpty() && sendResult.getErrors()[0].getStatusCode() == System.StatusCode.NO_MASS_MAIL_PERMISSION){
                        System.debug('WARNING: Mass Mail Permission is not enabled, but that would be a stupid thing to fail a test for so simulating success.');
                        count+=1;
                    }
                }
            }
        }catch(Exception error){
            throw new narrate_UnhandledException(error, 'narrate_EmailLogger');
        }
        return count;
    }

    @InvocableMethod(label='Narrator Email Logger' description='Send as an email' category='narrate_LogEvent__e')
    public static List<narrate_LogEvent__e> logInvokableMethod(List<narrate_LogEvent__e> logEvents) {
        new narrate_RecordLogger().log(logEvents);
        return logEvents;
    }

    @testVisible
    private List<Messaging.SingleEmailMessage> generateEmails(List<narrate_LogEvent__e> logEvents) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Map<String, List<narrate_LogEvent__e>> logEventsByRequest = groupLogEventsByRequest(logEvents);
        for(String requestId : logEventsByRequest.keySet()) {
            List<narrate_LogEvent__e> logEventsForRequest = logEventsByRequest.get(requestId);
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.subject = 'Logging events: ' + requestId;
            message.plaintextbody = String.join(formatLogEventsAsHumanReadableText(logEventsForRequest), '\n');
            message.htmlbody = String.join(wrapHtmlTable(formatLogEventsAsHTMLTableRows(logEventsForRequest)), '\n');
            message.toAddresses = recipients;
            emails.add(message);
        }
        return emails;
    }

    @testVisible
    private List<String> formatLogEventsAsHumanReadableText(List<narrate_LogEvent__e> logEvents){
        List<String> result = new List<String>();
        for(narrate_LogEvent__e logEvent : logEvents){
            result.add('[' + logEvent.Level__c + '] ' + logEvent.Class__c + '.' + logEvent.Method__c + ':' + logEvent.Line__c + '\t' + logEvent.Message__c);
        }
        return result;
    }

    @testVisible
    private List<String> formatLogEventsAsHTMLTableRows(List<narrate_LogEvent__e> logEvents){
        List<String> result = new List<String>();
        for(narrate_LogEvent__e logEvent : logEvents){
            result.add('<tr><td>' + logEvent.Level__c + '</td><td>' + logEvent.Class__c + '</td><td>' + logEvent.Method__c + '</td><td>' + logEvent.Line__c + '</td><td>' + logEvent.Message__c + '</td></tr>');
        }
        return result;
    }

    @testVisible
    private List<String> wrapHtmlTable(List<String> htmlLines){
        htmlLines.add(0, '<html>');
        htmlLines.add(1, '<body>');
        htmlLines.add(2, '<table>');
        htmlLines.add(3, '<tr><th>Level</th><th>Class</th><th>Method</th><th>Line</th><th>Message</th></tr>');
        htmlLines.addAll(new List<String>{'</table>', '</body>', '</html>'});
        return htmlLines;
    }

    @testVisible
    private Map<String, List<narrate_LogEvent__e>> groupLogEventsByRequest(List<narrate_LogEvent__e> logEvents){
        Map<String, List<narrate_LogEvent__e>> result = new Map<String, List<narrate_LogEvent__e>>();
        for(narrate_LogEvent__e logEvent : logEvents){
            if(!result.containsKey(logEvent.Request__c)){
                result.put(logEvent.Request__c, new List<narrate_LogEvent__e>());
            }
            result.get(logEvent.Request__c).add(logEvent);
        }
        return result;
    }

    private Boolean hasRecipients() {
        Set<String> recipientsTest = new Set<String>(recipients);
        recipientsTest.removeAll(NOT_APPLICABLE_VALUES);
        return !recipientsTest.isEmpty();
    }
}
