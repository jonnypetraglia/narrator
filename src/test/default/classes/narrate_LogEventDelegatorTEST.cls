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
    private static void receiveEventsSomehow() {
        // TODO
        
    }
}
