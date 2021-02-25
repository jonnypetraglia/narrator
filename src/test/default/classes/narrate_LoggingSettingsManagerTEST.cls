@isTest
public class narrate_LoggingSettingsManagerTEST {

    @isTest
    private static void getEventsByLoggerNamesForSettingsThatMatchActiveLoggerSettings(){
        List<narrate_LoggingSetting__mdt> testSettings = new List<narrate_LoggingSetting__mdt>();
        testSettings.add(testLoggingSetting('InfoLogger', 'Level__c', '=', 'INFO'));
        testSettings.add(testLoggingSetting('DerpLogger', 'Message__c', 'CONTAINS', 'Derp'));
        testSettings.add(testLoggingSetting('InfoLogger;DerpLogger', 'Message__c', 'STARTS WITH', 'Listen'));
        narrate_LoggingSettingsManager.activeSettings = testSettings;

        List<narrate_LogEvent__e> testEvents = new List<narrate_LogEvent__e>();
        testEvents.add(new narrate_LogEvent__e(Level__c='INFO', Message__c='Blah'));
        testEvents.add(new narrate_LogEvent__e(Level__c='Radda', Message__c='Herpa Derp'));
        testEvents.add(new narrate_LogEvent__e(Level__c='INFO', Message__c='Herpa Derp'));
        testEvents.add(new narrate_LogEvent__e(Level__c='INFO', Message__c='Listen, I think it is time we get pizza'));


        Map<String, List<narrate_LogEvent__e>> resultEventsByLoggerName = narrate_LoggingSettingsManager.getEventsByLoggerNamesForSettingsThatMatchActiveLoggerSettings(testEvents);
        System.assertEquals(2, resultEventsByLoggerName.size());
        System.assert(resultEventsByLoggerName.containsKey('InfoLogger'));
        System.assert(resultEventsByLoggerName.containsKey('DerpLogger'));
        System.assertEquals(3, resultEventsByLoggerName.get('InfoLogger').size());
        System.assertEquals(3, resultEventsByLoggerName.get('DerpLogger').size());
    }
    @isTest
    private static void getLoggerNamesForSettingsThatMatchLoggerSettings(){
        List<narrate_LoggingSetting__mdt> testSettings = new List<narrate_LoggingSetting__mdt>();
        testSettings.add(testLoggingSetting('InfoLogger', 'Level__c', '=', 'INFO'));
        testSettings.add(testLoggingSetting('DerpLogger', 'Message__c', 'CONTAINS', 'Derp'));
        narrate_LoggingSettingsManager.activeSettings = testSettings;

        Set<String> resultLogNames = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchLoggerSettings(new narrate_LogEvent__e(Level__c='INFO', Message__c='Blah'));
        System.assertEquals(1, resultLogNames.size());
        System.assert(resultLogNames.contains('InfoLogger'));
        resultLogNames = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchLoggerSettings(new narrate_LogEvent__e(Level__c='Radda', Message__c='Herpa Derp'));
        System.assertEquals(1, resultLogNames.size());
        System.assert(resultLogNames.contains('DerpLogger'));
        resultLogNames = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchLoggerSettings(new narrate_LogEvent__e(Level__c='INFO', Message__c='Herpa Derp'));
        System.assertEquals(2, resultLogNames.size());
        System.assert(resultLogNames.contains('InfoLogger'));
        System.assert(resultLogNames.contains('DerpLogger'));
    }

    private static narrate_LoggingSetting__mdt testLoggingSetting(String logger, String field, String operator, String compareTo){
        List<String> logic = new List<String>{field, operator};
        if(compareTo!=null){
            logic.add(compareTo);
        }
        return new narrate_LoggingSetting__mdt(
            Id=generateTestId(),
            Active__c=true,
            Loggers__c=logger,
            Logic__c=JSON.serialize(logic)
        );
    }
    // Borrowed this from FFLIB:
    // https://github.com/apex-enterprise-patterns/fflib-apex-mocks/blob/master/sfdx-source/apex-mocks/main/classes/fflib_IDGenerator.cls
    private static Integer fakeIdCount = 0;
    private static final String MDT_PREFIX = narrate_LoggingSetting__mdt.SObjectType.getDescribe().getKeyPrefix();
    private static Id generateTestId(){
        return MDT_PREFIX + '000000000000'.substring(0, 12 - String.valueOf(fakeIdCount).length()) + String.valueOf(fakeIdCount++);
    }
}
