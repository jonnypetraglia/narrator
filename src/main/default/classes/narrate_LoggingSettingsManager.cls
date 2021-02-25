public without sharing class narrate_LoggingSettingsManager {
    
    @testVisible
    private static List<narrate_LoggingSetting__mdt> activeSettings {get {
        if(activeSettings==null) {
            activeSettings = [SELECT Logic__c, Loggers__c FROM narrate_LoggingSetting__mdt WHERE Active__c = true];
        }
        return activeSettings;
    } private set;}

    private static Map<Id, narrate_IFilterLogic> filtersBySettingsId {get {
        if(filtersBySettingsId == null) {
            filtersBySettingsId = new Map<Id, narrate_IFilterLogic>();
            for(narrate_LoggingSetting__mdt settings : activeSettings) {
                narrate_IFilterLogic filterLogic = createFilterLogicForLogic(settings.Logic__c);
                if(filterLogic!=null){
                    filtersBySettingsId.put(settings.Id, filterLogic);
                }
            }
        }
        return filtersBySettingsId;
    } private set;}

    public static Boolean hasActiveSettings() {
        return !activeSettings.isEmpty();
    }
    
    public static Map<String, List<narrate_LogEvent__e>> getEventsByLoggerNamesForSettingsThatMatchActiveLoggerSettings(List<narrate_LogEvent__e> events){
        Map<String, List<narrate_LogEvent__e>> eventsByLoggerName = new Map<String, List<narrate_LogEvent__e>>();
        for(narrate_LogEvent__e event : events){
            Set<String> loggerNamesToLogForevent = getLoggerNamesForSettingsThatMatchLoggerSettings(event);
            // Add Event to the List<> of each Logger that it qualifies for based on the settings that were evaluated
            for(String loggerName : loggerNamesToLogForevent){
                if(!eventsByLoggerName.containsKey(loggerName)){
                    eventsByLoggerName.put(loggerName, new List<narrate_LogEvent__e>());
                }
                eventsByLoggerName.get(loggerName).add(event);
            }
        }
        return eventsByLoggerName;
    }
    
    @testVisible
    private static Set<String> getLoggerNamesForSettingsThatMatchLoggerSettings(narrate_LogEvent__e logData) {
        Set<String> result = new Set<String>();
        for(narrate_LoggingSetting__mdt setting : activeSettings) {
            if(setting.Loggers__c != null && filtersBySettingsId.containsKey(setting.Id) && (filtersBySettingsId.get(setting.Id) == null || (filtersBySettingsId.get(setting.Id).evaluate(logData)))) {
                result.addAll(setting.Loggers__c.split('[,;]'));
            }
        }
        return result;
    }

    // Eventually this will/may be the entry point for more complex dependency injection based on different types of IFilterLogic
    private static narrate_IFilterLogic createFilterLogicForLogic(String logicString){
        narrate_IFilterLogic result;
        if(String.isNotEmpty(logicString)) {
                try {
                result = new narrate_SimpleFilterLogic();
                result.setLogic(logicString);
            } catch(JSONException jsonError) {
                System.debug('NARRATOR MSG - Error parsing JSON logic: ' + logicString);
                result = null;
                // Dude that's on you, not on me.
            }
        }
        return result;
    }
}
