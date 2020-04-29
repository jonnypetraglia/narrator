public class narrate_EmailLogger extends narrate_SimpleLogger {
    override public Integer processEvents(List<narrate_LogEvent__e> logEvents) {
        Integer count = 0;
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(narrate_LogEvent__e logEvent : logEvents) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.subject = logEvent.narrate_Level__c + ': ' + logEvent.narrate_Context__c;
            message.plaintextbody = logEvent.narrate_Class__c + '.' + logEvent.narrate_Method__c + ':' + logEvent.narrate_Line__c 
                                + '\n' + logEvent.narrate_Message__c;
            message.toAddresses = new String[] {'jpetraglia@inspirato.com'};
            emails.add(message);
        }
        for(Messaging.SendEmailResult sendResult : Messaging.sendEmail(emails, false)) {
            if(sendResult.isSuccess()) {
                count+=1;
            }
        }
        return count;
    }
}
