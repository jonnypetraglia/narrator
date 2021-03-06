public with sharing class narrate_RecordLogger implements narrate_ILogger {
    public Integer log(List<narrate_LogEvent__e> events) {
        Integer count = 0;
        try{
            for(Database.SaveResult saveResult : Database.insert(narrate_Utilities.createLogEntriesAndNeededExecutionContexts(events), false)) {
                if(saveResult.isSuccess()) {
                    count+=1;
                }
            }
        }catch(Exception error){
            throw new narrate_NarratorException(error, 'narrate_RecordLogger');
        }
        return count;
    }
}
