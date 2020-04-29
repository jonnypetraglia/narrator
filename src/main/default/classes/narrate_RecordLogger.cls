public with sharing class narrate_RecordLogger extends narrate_SimpleLogger {
    override public Integer processEvents(List<narrate_LogEvent__e> events) {
        Integer count = 0;
        for(Database.SaveResult saveResult : Database.insert(narrate_Utilities.createLogEntriesAndNeededExecutionContexts(events), false)) {
            if(saveResult.isSuccess()) {
                count+=1;
            }
        }
        return count;
    }
}
