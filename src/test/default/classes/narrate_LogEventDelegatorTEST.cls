@isTest
public class narrate_LogEventDelegatorTEST {

    @isTest
    private static void receiveEvents() {
        narrate_LoggingSetting__mdt setting = new narrate_LoggingSetting__mdt(
            Active__c = true,
            Loggers__c = 'narrate_LogEventDelegatorTEST.TestLogger',
            Logic__c = '["Level__c", "=", "INFO"]'
        );
        narrate_LoggingSettingsManager.activeSettings = new List<narrate_LoggingSetting__mdt>{setting};

        narrate_LogEvent__e infoEvent = new narrate_LogEvent__e(
            Level__c = 'INFO',
            Message__c = 'This should log'
        );
        narrate_LogEvent__e errorEvent = new narrate_LogEvent__e(
            Level__c = 'ERROR',
            Message__c = 'This should not log'
        );
        narrate_LogEventDelegator delegator = new narrate_LogEventDelegator();
        delegator.receiveEvents(new List<narrate_LogEvent__e>{infoEvent, errorEvent});
    }




    @isTest
    private static void instantiateLoggersByName() {
        Set<String> testLoggerNames = new Set<String>{'narrate_LogEventDelegatorTEST.TestLogger', 'narrate_LogEntryTruncator', 'narrate_ThisIsNotEvenARealClass'};
        narrate_LogEventDelegator delegator = new narrate_LogEventDelegator();
        Map<String, narrate_ILogger> resultLoggers = delegator.instantiateLoggersByName(testLoggerNames);
        System.assert(resultLoggers.containsKey('narrate_LogEventDelegatorTEST.TestLogger'), 'TestLogger class was not instantiated in results.');
        System.assert(!resultLoggers.containsKey('narrate_LogEntryTruncator'), 'Result contained class that is not an instance of narrate_ILogger.');
        System.assert(!resultLoggers.containsKey('narrate_ThisIsNotEvenARealClass'), 'Result contained class name that doesn\'t even exist. I\'m not even mad, that\'s amazing.');
        System.assertEquals(1, resultLoggers.size(), 'An incorrect number of instantiated logger classes was returned.');
    }

    @isTest
    private static void logEventsToLoggers() {
        Map<String, narrate_ILogger> testLoggers = new Map<String, narrate_ILogger>{
            'narrate_LogEventDelegatorTEST.TestLogger' => new TestLogger(),
            'narrate_LogEventDelegatorTEST.NarratorExceptionLogger' => new NarratorExceptionLogger(),
            'narrate_LogEventDelegatorTEST.MiscExceptionLogger' => new MiscExceptionLogger()
        };
        Map<String, List<narrate_LogEvent__e>> testLogEvents = new Map<String, List<narrate_LogEvent__e>>();
        for(String testLoggerName : testLoggers.keySet()){
            testLogEvents.put(testLoggerName, new List<narrate_LogEvent__e>{new narrate_LogEvent__e(
                Level__c = 'INFO',
                Message__c = 'This should log'
            )});
        }
        narrate_LogEventDelegator delegator = new narrate_LogEventDelegator();
        delegator.logEventsToLoggers(testLogEvents, testLoggers);
        System.assert(((TestLogger)testLoggers.get('narrate_LogEventDelegatorTEST.TestLogger')).logCalled, 'The log function was not called for the TestLogger class.');
        System.assert(((NarratorExceptionLogger)testLoggers.get('narrate_LogEventDelegatorTEST.NarratorExceptionLogger')).logCalled, 'The log function was not called for the NarratorExceptionLogger class.');
        System.assert(((MiscExceptionLogger)testLoggers.get('narrate_LogEventDelegatorTEST.MiscExceptionLogger')).logCalled, 'The log function was not called for the MiscExceptionLogger class.');
    }

    public class TestLogger implements narrate_ILogger {
        public boolean logCalled = false;
        public Integer log(List<narrate_LogEvent__e> events) {
            logCalled = true;
            for(narrate_LogEvent__e event : events){
                System.assertEquals('This should log', event.Message__c);
                System.assertEquals('INFO', event.Level__c);
            }
            return events.size();
        }
    }
    public class NarratorExceptionLogger implements narrate_ILogger {
        public boolean logCalled = false;
        public Integer log(List<narrate_LogEvent__e> events) {
            logCalled = true;
            throw new narrate_NarratorException(new DmlException('NESTED FAIL!'), 'FAIL!');
        }
    }
    public class MiscExceptionLogger implements narrate_ILogger {
        public boolean logCalled = false;
        public Integer log(List<narrate_LogEvent__e> events) {
            logCalled = true;
            throw new DmlException('FAIL!');
        }
    }
}
