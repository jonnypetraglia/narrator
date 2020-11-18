@isTest
public class narrate_LogEventDelegatorTEST {

    @isTest
    private static void receiveEvents() {
        narrate_LoggingSetting__mdt setting = new narrate_LoggingSetting__mdt(
            narrate_Active__c = true,
            narrate_Loggers__c = 'narrate_LogEventDelegatorTEST.TestLogger',
            narrate_Logic__c = '["narrate_Level__c", "=", "INFO"]'
        );
        narrate_LoggingSettingsManager.activeSettings = new List<narrate_LoggingSetting__mdt>{setting};

        narrate_LogEvent__e infoEvent = new narrate_LogEvent__e(
            narrate_Level__c = 'INFO',
            narrate_Message__c = 'This should log'
        );
        narrate_LogEvent__e errorEvent = new narrate_LogEvent__e(
            narrate_Level__c = 'ERROR',
            narrate_Message__c = 'This should not log'
        );
        narrate_LogEventDelegator delegator = new narrate_LogEventDelegator();
        delegator.receiveEvents(new List<narrate_LogEvent__e>{infoEvent, errorEvent});
    }

    @isTest
    private static void instantiateLoggersByName() {
        Set<String> testLoggerNames = new Set<String>{'narrate_LogEventDelegatorTEST.TestLogger', 'narrate_Truncator', 'narrate_ThisIsNotEvenARealClass'};
        narrate_LogEventDelegator delegator = new narrate_LogEventDelegator();
        Map<String, narrate_ILogger> resultLoggers = delegator.instantiateLoggersByName(testLoggerNames);
        System.assert(resultLoggers.containsKey('narrate_LogEventDelegatorTEST.TestLogger'), 'TestLogger class was not instantiated in results.');
        System.assert(!resultLoggers.containsKey('narrate_Truncator'), 'Result contained class that is not an instance of narrate_ILogger.');
        System.assert(!resultLoggers.containsKey('narrate_ThisIsNotEvenARealClass'), 'Result contained class name that doesn\'t even exist. I\'m not even mad, that\'s amazing.');
        System.assertEquals(1, resultLoggers.size(), 'An incorrect number of instantiated logger classes was returned.');
    }
    // logEventsToLoggers

    public class TestLogger implements narrate_ILogger {
        public Integer log(List<narrate_LogEvent__e> events) {
            for(narrate_LogEvent__e event : events){
                System.assertEquals('This should log', event.narrate_Message__c);
                System.assertEquals('INFO', event.narrate_Level__c);
            }
            return events.size();
        }
    }
}
