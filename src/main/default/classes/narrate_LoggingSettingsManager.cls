public without sharing class narrate_LoggingSettingsManager {
    
    @testVisible
    private static List<narrate_LoggingSetting__mdt> activeSettings {get {
        if(activeSettings==null) {
            activeSettings = [SELECT narrate_Logic__c, narrate_Loggers__c FROM narrate_LoggingSetting__mdt WHERE narrate_Active__c = true];
        }
        return activeSettings;
    } private set;}

    private static Map<Id, narrate_IFilterLogic> filtersBySettingsId {get {
        if(filtersBySettingsId == null) {
            filtersBySettingsId = new Map<Id, narrate_IFilterLogic>();
            for(narrate_LoggingSetting__mdt settings : activeSettings) {
                filtersBySettingsId.put(settings.Id, new narrate_SimpleFilterLogic(settings.narrate_Logic__c.split(' '))); //TODO???
            }
        }
        return filtersBySettingsId;
    } private set;}
    
    public static Set<String> getLoggerNamesForSettingsThatMatchFilter(narrate_LogEvent__e logData) {
        Set<String> result = new Set<String>();
        for(narrate_LoggingSetting__mdt setting : activeSettings) {
            if(filtersBySettingsId.get(setting.Id).evaluate(logData) && setting.narrate_Loggers__c != null) {
                result.addAll(setting.narrate_Loggers__c.split('[,;]'));
            }
        }
        return result;
    }
}
