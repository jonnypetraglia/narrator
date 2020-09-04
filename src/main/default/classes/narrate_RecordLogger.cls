public with sharing class narrate_RecordLogger implements narrate_ILogger {
    override public Integer log(List<narrate_LogEvent__e> events) {
        Integer count = 0;
        try{
            for(Database.SaveResult saveResult : Database.insert(narrate_Utilities.createLogEntriesAndNeededExecutionContexts(events), false)) {
                if(saveResult.isSuccess()) {
                    count+=1;
                }
            }
        }catch(Exception error){
            System.debug('NARRATOR ERROR: \n' + error.getStackTraceString());
        }
        return count;
    }
}
