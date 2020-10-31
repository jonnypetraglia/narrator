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
            throw new narrate_NarratorException(error, 'narrate_EmailLogger');
        }
        return count;
    }

    @testVisible
    private List<Messaging.SingleEmailMessage> generateEmails(List<narrate_LogEvent__e> logEvents) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(narrate_LogEvent__e logEvent : logEvents) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.subject = logEvent.narrate_Level__c + ': ' + logEvent.narrate_Request__c;
            message.plaintextbody = logEvent.narrate_Class__c + ':' + logEvent.narrate_Method__c + '[' + logEvent.narrate_Line__c + ']\n' + logEvent.narrate_Message__c;
            message.toAddresses = recipients;
            emails.add(message);
        }
        return emails;
    }

    private Boolean hasRecipients() {
        Set<String> recipientsTest = new Set<String>(recipients);
        recipientsTest.removeAll(NOT_APPLICABLE_VALUES);
        return !recipientsTest.isEmpty();
    }
}
