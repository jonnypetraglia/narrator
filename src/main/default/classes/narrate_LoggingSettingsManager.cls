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
                if(String.isEmpty(settings.narrate_Logic__c)) {
                    filtersBySettingsId.put(settings.Id, null);
                } else {
                    try {
                        filtersBySettingsId.put(settings.Id, new narrate_SimpleFilterLogic((String[])JSON.deserialize(settings.narrate_Logic__c, String[].class)));
                    } catch(JSONException jsonError) {
                        // Dude that's on you, not on me.
                    }
                }
            }
        }
        return filtersBySettingsId;
    } private set;}
    
    public static Set<String> getLoggerNamesForSettingsThatMatchFilter(narrate_LogEvent__e logData) {
        Set<String> result = new Set<String>();
        for(narrate_LoggingSetting__mdt setting : activeSettings) {
            if(filtersBySettingsId.containsKey(setting.Id) && (filtersBySettingsId.get(setting.Id) == null || (filtersBySettingsId.get(setting.Id).evaluate(logData) && setting.narrate_Loggers__c != null))) {
                result.addAll(setting.narrate_Loggers__c.split('[,;]'));
            }
        }
        return result;
    }
}
