public class narrate_EmailLogger extends narrate_SimpleLogger {
    @testVisible
    String[] recipients {get {
        if(recipients == null) {
            recipients = Label.narrate_EmailLoggerEmailRecipients.split('[;,]');
        }
        return recipients;
    } set; }

    override public Integer processEvents(List<narrate_LogEvent__e> logEvents) {
        if(noRecipients()) {
            return 0;
        }
        Integer count = 0;
        for(Messaging.SendEmailResult sendResult : Messaging.sendEmail(generateEmails(logEvents), false)) {
            if(sendResult.isSuccess()) {
                count+=1;
            }
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

    private Boolean noRecipients() {
        return recipients.isEmpty() || (recipients.size() == 1 && (recipients[0] == 'NA' || recipients[0] == 'N/A' || recipients[0] == 'None'));
    }
}
