global with sharing class narrate_Truncator implements Schedulable {
    global static final Integer DEFAULT_MAX = 10000;
    private static final Date ALL_DATES = Date.newInstance(1990, 1, 1);
    private static final Integer ALL_RECORDS = 1000000000;
    global void execute(SchedulableContext sc){
        System.debug('NARRATOR MSG - Beginning Narrator Record Truncation');
        truncate();
    }
    global void truncate(){
        narrate_NarratorSettings__c settings = narrate_NarratorSettings__c.getOrgDefaults();
        Date after = settings.AutoTruncateDays__c != null ? Date.today().addDays(Integer.valueOf(-1 * settings.AutoTruncateDays__c)) : ALL_DATES;
        Integer max = settings.AutoTruncateMax__c != null ? Integer.valueOf(settings.AutoTruncateMax__c) : DEFAULT_MAX;
        deleteSObjects(getObjectsToDelete(after, max));
    }
    global void truncate(Date after){
        deleteSObjects(getObjectsToDelete(after, ALL_RECORDS));
    }
    global void truncate(Integer max){
        deleteSObjects(getObjectsToDelete(ALL_DATES, max));
    }
    private void deleteSObjects(List<SObject> toBeDeleted){
        System.debug('NARRATOR MSG - Records to be truncated ' + toBeDeleted.size());
        if(!toBeDeleted.isEmpty()){
            delete toBeDeleted;
            System.debug('NARRATOR MSG - ' + toBeDeleted.size() + ' records successfully truncated.');
        }
    }
    private List<SObject> getObjectsToDelete(Date after, Integer max) {
        List<narrate_ExecutionContext__c> recordsToSave = [SELECT Id FROM narrate_ExecutionContext__c WHERE narrate_EndTime__c >= :after ORDER BY narrate_EndTime__c DESC LIMIT :max];
        return [SELECT Id FROM narrate_ExecutionContext__c WHERE ID NOT IN :recordsToSave];
    }
}
