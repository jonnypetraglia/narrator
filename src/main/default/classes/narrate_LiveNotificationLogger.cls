public class narrate_LiveNotificationLogger extends narrate_SimpleLogger {
    override public Integer processEvents(List<narrate_LogEvent__e> logs) {
        Integer count = 0;
        List<FeedItem> feedItems = new List<FeedItem>();
        System.debug('LiveNotificationLogger ' + logs);
        for(narrate_LogEvent__e log : logs) {
            feedItems.add(new FeedItem(
                ParentId = '00555000004eY2mAAE',
                Body = log.narrate_Message__c,
                Title = log.narrate_Context__c
            ));
        }
        for(Database.SaveResult saveResult : Database.insert(feedItems, false)) {
            if(saveResult.isSuccess()) {
                count+=1;
            }
        }
        System.debug('count ' + count);
        return count;
    }
}