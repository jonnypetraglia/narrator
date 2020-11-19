@isTest
public class narrate_PlatformEventNarratorTEST {
    @isTest
    private static void log() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        narrate_PlatformEventNarrator narrator = new narrate_PlatformEventNarrator();
        narrator.setCodeLocationSnapshot(narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter'));
        narrator.log('Level', 'Message', new List<String>{'values'});
        Test.getEventBus().deliver();
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }
    
    @isTest
    private static void except() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        narrate_PlatformEventNarrator narrator = new narrate_PlatformEventNarrator();
        narrator.setCodeLocationSnapshot(narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter'));
        narrator.except(new DmlException());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }
    
    @isTest
    private static void restRequest() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        narrate_PlatformEventNarrator narrator = new narrate_PlatformEventNarrator();
        narrator.setCodeLocationSnapshot(narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter'));
        narrator.restRequest(new RestRequest());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }

    @isTest
    private static void restResponse() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        narrate_PlatformEventNarrator narrator = new narrate_PlatformEventNarrator();
        narrator.setCodeLocationSnapshot(narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter'));
        narrator.restResponse(new RestResponse());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }
    
    @isTest
    private static void httpRequest() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        narrate_PlatformEventNarrator narrator = new narrate_PlatformEventNarrator();
        narrator.setCodeLocationSnapshot(narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter'));
        narrator.httpRequest(new HttpRequest());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }
    
    @isTest
    private static void httpResponse() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        narrate_PlatformEventNarrator narrator = new narrate_PlatformEventNarrator();
        narrator.setCodeLocationSnapshot(narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter'));
        narrator.httpResponse(new HttpResponse());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }

    @isTest
    private static void constructLogEvent() {
        DateTime timestamp = DateTime.now();
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_PlatformEventNarratorTEST.class.getName()).snap();
        narrate_LogEvent__e result = narrate_PlatformEventNarrator.constructLogEvent(snappy, 'MuhLevel', 'MAH BOI!');
        System.assertEquals('MuhLevel', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
    }

    @isTest
    private static void constructLogEventFromException() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_PlatformEventNarratorTEST.class.getName()).snap();
        narrate_LogEvent__e result = narrate_PlatformEventNarrator.constructLogEvent(snappy, new DmlException('MAH BOI!'));
        System.assertEquals('Except', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
    }

    @isTest
    private static void constructLogEventFromRestRequest() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_PlatformEventNarratorTEST.class.getName()).snap();
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf('Hello there');
        request.httpMethod = 'GET';
        narrate_LogEvent__e result = narrate_PlatformEventNarrator.constructLogEvent(snappy, request);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(JSON.serialize(request), result.narrate_Message__c);
    }

    @isTest
    private static void constructLogEventFromRestResponse() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_PlatformEventNarratorTEST.class.getName()).snap();
        RestResponse response = new RestResponse();
        response.responseBody = Blob.valueOf('General Kenobi!');
        response.statusCode = 200;
        narrate_LogEvent__e result = narrate_PlatformEventNarrator.constructLogEvent(snappy, response);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(JSON.serialize(response), result.narrate_Message__c);
    }

    @isTest
    private static void constructLogEventFromHttpRequest() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_PlatformEventNarratorTEST.class.getName()).snap();
        HttpRequest request = new HttpRequest();
        request.setBody('Hello there');
        request.setMethod('GET');
        narrate_LogEvent__e result = narrate_PlatformEventNarrator.constructLogEvent(snappy, request);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(request.toString(), result.narrate_Message__c);
    }

    @isTest
    private static void constructLogEventFromHttpResponse() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_PlatformEventNarratorTEST.class.getName()).snap();
        HttpResponse response = new HttpResponse();
        response.setBody('General Kenobi!');
        response.setStatusCode(200);
        narrate_LogEvent__e result = narrate_PlatformEventNarrator.constructLogEvent(snappy, response);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(response.toString(), result.narrate_Message__c);
    }

    private static EventBusSubscriber getEventBusSubscriber(){
        List<EventBusSubscriber> subscribers = [SELECT Name, Position, Retries, LastError FROM EventBusSubscriber WHERE Topic='narrate_LogEvent__e' AND Type='ApexTrigger'];
        for(EventBusSubscriber subscriber : subscribers){
            if(subscriber.Name == 'narrate_LogEvent'){
                return subscriber;
            }
        }
        return null;
    }
}
