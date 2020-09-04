public class narrate_EmailLogger implements narrate_ILogger {
    private static final List<String> NOT_APPLICABLE_VALUES = new List<String>{'NA', 'N/A', 'None'};
    @testVisible
    String[] recipients {get {
        if(recipients == null) {
            recipients = Label.narrate_EmailLoggerEmailRecipients.split('[;,]');
        }
        return recipients;
    } set; }

    override public Integer log(List<narrate_LogEvent__e> logEvents) {
        Integer count = 0;
        try{
            if(hasRecipients()) {
                for(Messaging.SendEmailResult sendResult : Messaging.sendEmail(generateEmails(logEvents), false)) {
                    if(sendResult.isSuccess()) {
                        count+=1;
                    }
                }
            }
        }catch(Exception error){
            System.debug('NARRATOR ERROR: \n' + error.getStackTraceString());
        }
        return count;
    }

    @testVisible
    private List<Messaging.SingleEmailMessage> generateEmails(List<narrate_LogEvent__e> logEvents) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(narrate_LogEvent__e logEvent : logEvents) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.subject = logEvent.narrate_Level__c + ': ' + logEvent.narrate_Context__c;
            message.plaintextbody = logEvent.narrate_Class__c + ':' + logEvent.narrate_Method__c + '[' + logEvent.narrate_Line__c + ']\n' + logEvent.narrate_Message__c;
            message.toAddresses = recipients;
            emails.add(message);
        }
        return emails;
    }

    private Boolean hasRecipients() {
        return !recipients.isEmpty() && recipients.size() != 1 && !NOT_APPLICABLE_VALUES.contains(recipients[0]);
    }
}
