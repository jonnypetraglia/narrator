@isTest
public class narrate_RecordLoggerTEST {
    @isTest
    public static void testLog() {
        narrate_LogEvent__e event = new narrate_LogEvent__e(
            narrate_Level__c = 'grok',
            narrate_Class__c = 'Classy',
            narrate_Method__c = 'Methody',
            narrate_Line__c = 42,
            narrate_Message__c = 'Don\'t Panic',
            narrate_Request__c='HelloFromTheOtherSide',
            narrate_Quiddity__c='SuperAwesome'
        );
        narrate_RecordLogger logger = new narrate_RecordLogger();
        Integer successCount = logger.log(new List<narrate_LogEvent__e>{event});
        System.assertEquals(1, successCount);
        List<narrate_LogEntry__c> testEntries = [SELECT narrate_Level__c, narrate_Class__c, narrate_Method__c, narrate_Line__c, narrate_Message__c FROM narrate_LogEntry__c];
        System.assertEquals(1, testEntries.size(), testEntries + '');
        narrate_LogEntry__c testEntry = testEntries.get(0);
        System.assertEquals('grok', testEntry.narrate_Level__c);
        System.assertEquals('Classy', testEntry.narrate_Class__c);
        System.assertEquals('Methody', testEntry.narrate_Method__c);
        System.assertEquals(42, testEntry.narrate_Line__c);
        System.assertEquals('Don\'t Panic', testEntry.narrate_Message__c);
    }

    @isTest
    public static void testLogFailure() {
        try {
            narrate_RecordLogger logger = new narrate_RecordLogger();
            logger.log(null);
            System.assert(false, 'Expected exception to be thrown but none was.');
        }catch(narrate_NarratorException error){
            List<narrate_LogEntry__c> testEntries = [SELECT narrate_Level__c, narrate_Class__c, narrate_Method__c, narrate_Line__c, narrate_Message__c FROM narrate_LogEntry__c];
            System.assertEquals(0, testEntries.size(), testEntries + '');
            System.assertNotEquals(null, error.getMessage(), 'Honestly just tryna get stupid code coverage.');
        }catch(Exception error){
            System.assertEquals('narrate_NarratorException', error.getTypeName(), 'Caught Exception is not the correct type.');
        }
    }

    @isTest
    private static void constructEntryFromEvent() {
        DateTime timestamp = DateTime.now();
        narrate_LogEntry__c result = narrate_RecordLogger.constructEntryFromEvent(new narrate_LogEvent__e(
            narrate_Class__c = 'MuhClass',
            narrate_Method__c = 'MuhMethod',
            narrate_Line__c = 42,
            narrate_Message__c = 'MAH BOI!',
            narrate_Timestamp__c = timestamp,
            narrate_User__c = UserInfo.getUserId()
        ), UserInfo.getUserId());  // Not technically an ExecutionContext ID but who cares lol
        System.assertEquals(UserInfo.getUserId(), result.narrate_ExecutionContext__c);
        System.assertEquals('MuhClass', result.narrate_Class__c);
        System.assertEquals('MuhMethod', result.narrate_Method__c);
        System.assertEquals(42, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
    }

    @isTest
    private static void createExecutionContextsForLogEvents(){
        List<narrate_LogEvent__e> testEvents = new List<narrate_LogEvent__e>();
        for(Integer i=0; i<100; i++){
            testEvents.add(new narrate_LogEvent__e(
                narrate_Request__c='Request' + i,
                narrate_Quiddity__c='Quiddity' + i
            ));
        }
        Map<String, narrate_ExecutionContext__c> resultContexts = narrate_RecordLogger.createExecutionContextsForLogEvents(testEvents);
        for(Integer i=0; i<100; i++){
            System.assert(resultContexts.containsKey('Request' + i));
            System.assertEquals('Request' + i, resultContexts.get('Request' + i).narrate_Request__c);
            System.assertEquals('Quiddity' + i, resultContexts.get('Request' + i).narrate_Quiddity__c);
        }
    }

    @isTest
    private static void loadExecutionContextsByRequest(){
        List<narrate_ExecutionContext__c> executionContexts = new List<narrate_ExecutionContext__c>();
        for(Integer i=0; i<100; i++){
            executionContexts.add(new narrate_ExecutionContext__c(
                narrate_Request__c='Request' + i,
                narrate_Quiddity__c='Quiddity' + i
            ));
        }
        insert executionContexts;
        Map<String, Id> requestsToId = new Map<String, Id>();
        for(narrate_ExecutionContext__c context : executionContexts){
            requestsToId.put(context.narrate_Request__c, context.Id);
        }
        Map<String, narrate_ExecutionContext__c> resultContexts = narrate_RecordLogger.loadExecutionContextsByRequest(requestsToId.keySet());
        for(Integer i=0; i<100; i++){
            System.assert(resultContexts.containsKey('Request' + i));
            narrate_ExecutionContext__c resultContext = resultContexts.get('Request' + i);
            System.assertEquals('Request' + i, resultContext.narrate_Request__c);
            System.assertEquals('Quiddity' + i, resultContext.narrate_Quiddity__c);
            System.assertEquals(requestsToId.get('Request' + i), resultContext.Id);
        }
    }
}
