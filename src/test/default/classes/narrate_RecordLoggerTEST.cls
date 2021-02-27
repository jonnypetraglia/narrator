@isTest
public class narrate_RecordLoggerTEST {
    @isTest
    public static void testLog() {
        narrate_LogEvent__e event = new narrate_LogEvent__e(
            Level__c = 'grok',
            Class__c = 'Classy',
            Method__c = 'Methody',
            Line__c = 42,
            Message__c = 'Don\'t Panic',
            Request__c='HelloFromTheOtherSide',
            Quiddity__c='SuperAwesome'
        );
        narrate_RecordLogger logger = new narrate_RecordLogger();
        Integer successCount = logger.log(new List<narrate_LogEvent__e>{event});
        System.assertEquals(1, successCount);
        List<narrate_LogEntry__c> testEntries = [SELECT Level__c, Class__c, Method__c, Line__c, Message__c FROM narrate_LogEntry__c];
        System.assertEquals(1, testEntries.size(), testEntries + '');
        narrate_LogEntry__c testEntry = testEntries.get(0);
        System.assertEquals('grok', testEntry.Level__c);
        System.assertEquals('Classy', testEntry.Class__c);
        System.assertEquals('Methody', testEntry.Method__c);
        System.assertEquals(42, testEntry.Line__c);
        System.assertEquals('Don\'t Panic', testEntry.Message__c);
    }

    @isTest
    public static void testLogFailure() {
        try {
            narrate_RecordLogger logger = new narrate_RecordLogger();
            logger.log(null);
            System.assert(false, 'Expected exception to be thrown but none was.');
        }catch(narrate_UnhandledException error){
            List<narrate_LogEntry__c> testEntries = [SELECT Level__c, Class__c, Method__c, Line__c, Message__c FROM narrate_LogEntry__c];
            System.assertEquals(0, testEntries.size(), testEntries + '');
            System.assertNotEquals(null, error.getMessage(), 'Honestly just tryna get stupid code coverage.');
        }catch(Exception error){
            System.assertEquals('narrate_UnhandledException', error.getTypeName(), 'Caught Exception is not the correct type.');
        }
    }

    @isTest
    private static void constructEntryFromEvent() {
        DateTime timestamp = DateTime.now();
        narrate_LogEntry__c result = narrate_RecordLogger.constructEntryFromEvent(new narrate_LogEvent__e(
            Class__c = 'MuhClass',
            Method__c = 'MuhMethod',
            Line__c = 42,
            Message__c = 'MAH BOI!',
            Timestamp__c = timestamp,
            User__c = UserInfo.getUserId()
        ), UserInfo.getUserId());  // Not technically an ExecutionContext ID but who cares lol
        System.assertEquals(UserInfo.getUserId(), result.ExecutionContext__c);
        System.assertEquals('MuhClass', result.Class__c);
        System.assertEquals('MuhMethod', result.Method__c);
        System.assertEquals(42, result.Line__c);
        System.assertEquals('MAH BOI!', result.Message__c);
        System.assertEquals(timestamp, result.Timestamp__c);
    }

    @isTest
    private static void createExecutionContextsForLogEvents(){
        List<narrate_LogEvent__e> testEvents = new List<narrate_LogEvent__e>();
        for(Integer i=0; i<100; i++){
            testEvents.add(new narrate_LogEvent__e(
                Request__c='Request' + i,
                Quiddity__c='Quiddity' + i
            ));
        }
        Map<String, narrate_ExecutionContext__c> resultContexts = narrate_RecordLogger.createExecutionContextsForLogEvents(testEvents);
        for(Integer i=0; i<100; i++){
            System.assert(resultContexts.containsKey('Request' + i));
            System.assertEquals('Request' + i, resultContexts.get('Request' + i).Request__c);
            System.assertEquals('Quiddity' + i, resultContexts.get('Request' + i).Quiddity__c);
        }
    }

    @isTest
    private static void loadExecutionContextsByRequest(){
        List<narrate_ExecutionContext__c> executionContexts = new List<narrate_ExecutionContext__c>();
        for(Integer i=0; i<100; i++){
            executionContexts.add(new narrate_ExecutionContext__c(
                Request__c='Request' + i,
                Quiddity__c='Quiddity' + i
            ));
        }
        insert executionContexts;
        Map<String, Id> requestsToId = new Map<String, Id>();
        for(narrate_ExecutionContext__c context : executionContexts){
            requestsToId.put(context.Request__c, context.Id);
        }
        Map<String, narrate_ExecutionContext__c> resultContexts = narrate_RecordLogger.loadExecutionContextsByRequest(requestsToId.keySet());
        for(Integer i=0; i<100; i++){
            System.assert(resultContexts.containsKey('Request' + i));
            narrate_ExecutionContext__c resultContext = resultContexts.get('Request' + i);
            System.assertEquals('Request' + i, resultContext.Request__c);
            System.assertEquals('Quiddity' + i, resultContext.Quiddity__c);
            System.assertEquals(requestsToId.get('Request' + i), resultContext.Id);
        }
    }
}
