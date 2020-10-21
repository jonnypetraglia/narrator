@isTest
public class narrate_UtilitiesTEST {
    @isTest
    private static void castToStringList() {
        List<Object> objects = new List<Object>{
            null,
            true,
            'Derp',
            42,
            3.50,
            new Account(Name='Adele')
        };
        List<String> result = narrate_Utilities.castToStringList(objects);
        Integer i = 0;
        System.assertEquals('null', result.get(i++));
        System.assertEquals('true', result.get(i++));
        System.assertEquals('Derp', result.get(i++));
        System.assertEquals('42', result.get(i++));
        System.assertEquals('3.50', result.get(i++));
        System.assertEquals(String.valueOf(new Account(Name='Adele')), result.get(i++));

        result = narrate_Utilities.castToStringList(null);
        System.assertNotEquals(null, result);
        System.assertEquals(0, result.size());
    }

    @isTest
    private static void constructEntryFromEvent() {
        DateTime timestamp = DateTime.now();
        narrate_LogEntry__c result = narrate_Utilities.constructEntryFromEvent(new narrate_LogEvent__e(
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
    private static void constructLogEvent() {
        DateTime timestamp = DateTime.now();
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_UtilitiesTest.class.getName()).snap();
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent(snappy, 'MuhLevel', 'MAH BOI!', 'RequestId', 'Quiddity');
        System.assertEquals('MuhLevel', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
    }

    @isTest
    private static void constructLogEventFromException() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_UtilitiesTest.class.getName()).snap();
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent(snappy, new DmlException('MAH BOI!'), 'RequestId', 'Quiddity');
        System.assertEquals('Except', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
    }

    @isTest
    private static void constructLogEventFromRestRequest() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_UtilitiesTest.class.getName()).snap();
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf('Hello there');
        request.httpMethod = 'GET';
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent(snappy, request, 'RequestId', 'Quiddity');
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(JSON.serialize(request), result.narrate_Message__c);
    }

    @isTest
    private static void constructLogEventFromRestResponse() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_UtilitiesTest.class.getName()).snap();
        RestResponse response = new RestResponse();
        response.responseBody = Blob.valueOf('General Kenobi!');
        response.statusCode = 200;
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent(snappy, response, 'RequestId', 'Quiddity');
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(JSON.serialize(response), result.narrate_Message__c);
    }

    @isTest
    private static void constructLogEventFromHttpRequest() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_UtilitiesTest.class.getName()).snap();
        HttpRequest request = new HttpRequest();
        request.setBody('Hello there');
        request.setMethod('GET');
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent(snappy, request, 'RequestId', 'Quiddity');
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(request.toString(), result.narrate_Message__c);
    }

    @isTest
    private static void constructLogEventFromHttpResponse() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_UtilitiesTest.class.getName()).snap();
        HttpResponse response = new HttpResponse();
        response.setBody('General Kenobi!');
        response.setStatusCode(200);
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent(snappy, response, 'RequestId', 'Quiddity');
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(response.toString(), result.narrate_Message__c);
    }

    @isTest
    private static void extractRequestsFromLogEvents() {
        narrate_CodeLocationSnapshot.Snapshot snappy = new narrate_CodeLocationSnapshot.Snapshot();
        List<narrate_LogEvent__e> logEvents = new List<narrate_LogEvent__e>();
        for(Integer i=0; i<10; i++) {
            logEvents.add(narrate_Utilities.constructLogEvent(snappy, 'Radda', 'Radda', 'Give me a ' + i + '!', 'Quiddity'));
        }
        Set<String> requestResults = narrate_Utilities.extractRequestsFromLogEvents(logEvents);
        for(Integer i=0; i<10; i++) {
            System.assert(requestResults.contains('Give me a ' + i + '!'), 'i=' + i + ';' + requestResults);
        }
    }

    // @isTest
    // private static void constructExecutionContextsForLogEvents() {
    //     Map<String, Integer> contexts = new Map<String, Integer> {'This'=>0, 'That'=>0, 'The Other'=>0, 'Lunch'=>0};
    //     for(narrate_ExecutionContext__c executionContext : narrate_Utilities.constructExecutionContextsForContexts(contexts.keySet())) {
    //         contexts.put(executionContext.Name, contexts.get(executionContext.Name)+1);
    //     }
    //     for(String context : contexts.keySet()) {
    //         System.assertEquals(1, contexts.get(context), context);
    //     }
    // }

    @isTest
    private static void makeMissingExecutionContextsFromEvents() {
        narrate_CodeLocationSnapshot.Snapshot snappy = new narrate_CodeLocationSnapshot.Snapshot();
        List<narrate_ExecutionContext__c> preexistingExecutionContexts = new List<narrate_ExecutionContext__c>();
        for(Integer i=0; i<24; i++) {
            preexistingExecutionContexts.add(new narrate_ExecutionContext__c(narrate_Request__c = i + ' pizza slices'));
        }
        insert preexistingExecutionContexts;
        List<narrate_LogEvent__e> logEvents = new List<narrate_LogEvent__e>();
        for(Integer i=7; i<42; i++) {
            logEvents.add(narrate_Utilities.constructLogEvent(snappy, 'Radda', 'Radda', i + ' pizza slices', 'Quiddity'));
        }
        List<narrate_ExecutionContext__c> executionContexts = narrate_Utilities.makeMissingExecutionContextsFromEvents(logEvents);
        System.assertEquals(42-24, executionContexts.size());
        Set<String> newContextNames = new Set<String>();
        for(narrate_ExecutionContext__c execContext : executionContexts) {
            newContextNames.add(execContext.Name);
        }
        for(Integer i=24; i<42; i++) {
            System.assert(newContextNames.contains(i + ' pizza slices'), 'i=' + i + ';' + newContextNames);
        }
        System.assertEquals(42-24, newContextNames.size());
    }

    @isTest
    private static void makeMapOfExecutionContextsByRequest() {
        List<narrate_ExecutionContext__c> executionContexts = new List<narrate_ExecutionContext__c>();
        for(Integer i=0; i<10; i++) {
            executionContexts.add(new narrate_ExecutionContext__c(narrate_Request__c = i + ' potato'));
        }
        Map<String, narrate_ExecutionContext__c> mapResult = narrate_Utilities.makeMapOfExecutionContextsByRequest(executionContexts);
        for(Integer i=0; i<10; i++) {
            String potoooooooo = i + ' potato'; //Pot 8 O's
            System.assert(mapResult.containsKey(potoooooooo), 'i=' + i + ';' + mapResult);
            System.assertNotEquals(null, mapResult.get(potoooooooo), 'i=' + i);
            System.assertEquals(potoooooooo, mapResult.get(potoooooooo).Name, 'i=' + i);
        }
    }

    // TODO: I find this test kind of blegh
    @isTest
    private static void createLogEntriesAndNeededExecutionContexts() {
        narrate_CodeLocationSnapshot.Snapshot snappy = new narrate_CodeLocationSnapshot.Snapshot();
        List<narrate_ExecutionContext__c> preexistingExecutionContextsToInsert = new List<narrate_ExecutionContext__c>();
        for(Integer i=0; i<13; i++) {
            preexistingExecutionContextsToInsert.add(new narrate_ExecutionContext__c(narrate_Request__c = 'I have ' + i + ' cookies'));
        }
        insert preexistingExecutionContextsToInsert;
        Map<ID, narrate_ExecutionContext__c> preexistingExecutionContexts = new Map<ID, narrate_ExecutionContext__c>([SELECT Name FROM narrate_ExecutionContext__c WHERE Id IN :preexistingExecutionContextsToInsert]);
        List<narrate_LogEvent__e> logEvents = new List<narrate_LogEvent__e>();
        for(Integer i=0; i<42; i++) {
            logEvents.add(narrate_Utilities.constructLogEvent(snappy, 'Radda', 'Radda', 'I have ' + i + ' cookies', 'Quiddity'));
            if(i>36)
                logEvents.add(narrate_Utilities.constructLogEvent(snappy, 'Radda', 'Radda', 'I have ' + i + ' cookies', 'Quiddity'));
        }
        Test.startTest();
        List<narrate_LogEntry__c> createdEntries = narrate_Utilities.createLogEntriesAndNeededExecutionContexts(logEvents);
        Test.stopTest();
        for(narrate_LogEntry__c createdEntry : createdEntries) {
            System.assertNotEquals(null, createdEntry.narrate_ExecutionContext__c);
        }
        Map<ID, narrate_ExecutionContext__c> createdContexts = new Map<ID, narrate_ExecutionContext__c>([SELECT Name FROM narrate_ExecutionContext__c WHERE Id NOT IN :preexistingExecutionContexts.keySet()]);
        System.assertEquals(42-13, createdContexts.size());
        for(ID execID : createdContexts.keySet()) {
            System.assert(!preexistingExecutionContexts.containsKey(execID));
        }
        for(ID execID : preexistingExecutionContexts.keySet()) {
            System.assert(!createdContexts.containsKey(execID));
        }
    }
}
