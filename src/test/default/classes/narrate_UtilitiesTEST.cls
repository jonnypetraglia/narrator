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
            narrate_Context__c = 'MuhContext',
            narrate_Class__c = 'MuhClass',
            narrate_Method__c = 'MuhMethod',
            narrate_Line__c = 42,
            narrate_Message__c = 'MAH BOI!',
            narrate_Timestamp__c = timestamp,
            narrate_User__c = UserInfo.getUserId()
        ), UserInfo.getUserId());  // Not technically an ExecutionContext ID but who cares lol
        System.assertEquals(UserInfo.getUserId(), result.narrate_ExecutionContext__c);
        System.assertEquals('MuhContext', result.narrate_Context__c);
        System.assertEquals('MuhClass', result.narrate_Class__c);
        System.assertEquals('MuhMethod', result.narrate_Method__c);
        System.assertEquals(42, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
    }

    @isTest
    private static void constructLogEvent() {
        DateTime timestamp = DateTime.now();
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.snap();
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent('MuhContext', snappy, 'MuhLevel', 'MAH BOI!');
        System.assertEquals('MuhContext', result.narrate_Context__c);
        System.assertEquals('MuhLevel', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
    }

    @isTest
    private static void constructLogEventFromException() {
        DateTime timestamp = DateTime.now();
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.snap();
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent('MuhContext', snappy, new DmlException());
        System.assertEquals('MuhContext', result.narrate_Context__c);
        System.assertEquals('Except', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
    }

    @isTest
    private static void constructLogEventFromRestRequest() {
        DateTime timestamp = DateTime.now();
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.snap();
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf('Hello there');
        request.httpMethod = 'GET';
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent('MuhContext', snappy, request);
        System.assertEquals('MuhContext', result.narrate_Context__c);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(JSON.serialize(request), result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
    }

    @isTest
    private static void constructLogEventFromRestResponse() {
        DateTime timestamp = DateTime.now();
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.snap();
        RestResponse response = new RestResponse();
        response.responseBody = Blob.valueOf('General Kenobi!');
        response.statusCode = 200;
        narrate_LogEvent__e result = narrate_Utilities.constructLogEvent('MuhContext', snappy, response);
        System.assertEquals('MuhContext', result.narrate_Context__c);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(JSON.serialize(response), result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
    }

    @isTest
    private static void getUserIdsFromEvents() {
        List<narrate_LogEvent__e> events = new List<narrate_LogEvent__e>();
        Test.startTest();
        Map<Id, User> users = new Map<Id, User>([SELECT Id FROM User LIMIT 10]);
        System.assert(users.size() > 3);
        Test.stopTest();
        for(Id userId : users.keySet()) {
            events.add(new narrate_LogEvent__e(narrate_User__c=userId));
        }
        Set<Id> resultIds = narrate_Utilities.getUserIdsFromEvents(events);
        for(Id userId : users.keySet()) {
            System.assert(resultIds.contains(userId));
        }
        for(Id userId : resultIds) {
            System.assert(users.containsKey(userId));
        }
    }
}
