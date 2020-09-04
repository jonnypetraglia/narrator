@isTest
public class narrate_LogEventDelegatorTEST {

    @isTest
    private static void instantiateLogger() {
        narrate_ILogger logger = narrate_LogEventDelegator.instantiateLogger('narrate_RecordLogger');
        System.assertNotEquals(null, logger);
        System.assert(logger instanceof narrate_RecordLogger);
    }

    @isTest
    private static void instantiateLoggerInvalidClass() {
        narrate_ILogger logger = narrate_LogEventDelegator.instantiateLogger('narrate_LogEventBuffer');
        System.assertEquals(null, logger);
    }

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


    public class TestLogger implements narrate_ILogger {
        public void log(List<narrate_LogEvent__e> events) {
            for(narrate_LogEvent__e event : events){
                System.assertEquals('This should log', event.narrate_Message__c);
                System.assertEquals('INFO', event.narrate_Level__c);
            }
        }
    }
}
