@isTest
public with sharing class narrate_NarrateTEST {
    static {
        Narrate.CURRENT_REQUEST_ID = 'MuhRequest';
        Narrate.CURRENT_REQUEST_QUIDDITY = 'MuhQuiddity';
    }

    @isTest
    private static void log() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        Narrate.settings = new narrate_NarratorConfig__c(EnabledTests__c=true);
        Narrate.snapshot = narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter');
        Narrate.log('Level', 'Message', new List<String>{'values'});
        Test.getEventBus().deliver();
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }
    
    @isTest
    private static void except() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        Narrate.settings = new narrate_NarratorConfig__c(EnabledTests__c=true);
        Narrate.snapshot = narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter');
        Narrate.except(new DmlException());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }
    
    @isTest
    private static void restRequest() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        Narrate.settings = new narrate_NarratorConfig__c(EnabledTests__c=true);
        Narrate.snapshot = narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter');
        Narrate.rest(new RestRequest());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }

    @isTest
    private static void restResponse() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        Narrate.settings = new narrate_NarratorConfig__c(EnabledTests__c=true);
        Narrate.snapshot = narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter');
        Narrate.rest(new RestResponse());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }
    
    @isTest
    private static void httpRequest() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        Narrate.settings = new narrate_NarratorConfig__c(EnabledTests__c=true);
        Narrate.snapshot = narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter');
        Narrate.http(new HttpRequest());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }
    
    @isTest
    private static void httpResponse() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        Narrate.settings = new narrate_NarratorConfig__c(EnabledTests__c=true);
        Narrate.snapshot = narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter');
        Narrate.http(new HttpResponse());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }

    @isTest
    private static void constructLogEvent() {
        DateTime timestamp = DateTime.now();
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_NarrateTEST.class.getName()).snap();
        narrate_LogEvent__e result = Narrate.constructLogEvent(snappy, 'MuhLevel', 'MAH BOI!');
        System.assertEquals('MuhLevel', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
        System.assertEquals(timestamp, result.narrate_Timestamp__c);
        System.assertEquals('MuhRequest', result.narrate_Request__c);
        System.assertEquals('MuhQuiddity', result.narrate_Quiddity__c);
    }

    @isTest
    private static void constructLogEventFromException() {

        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_NarrateTEST.class.getName()).snap();
        narrate_LogEvent__e result = Narrate.constructLogEvent(snappy, new DmlException('MAH BOI!'));
        System.assertEquals('Except', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals('MAH BOI!', result.narrate_Message__c);
        System.assertEquals('MuhRequest', result.narrate_Request__c);
        System.assertEquals('MuhQuiddity', result.narrate_Quiddity__c);
    }

    @isTest
    private static void constructLogEventFromRestRequest() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_NarrateTEST.class.getName()).snap();
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf('Hello there');
        request.httpMethod = 'GET';
        narrate_LogEvent__e result = Narrate.constructLogEvent(snappy, request);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(JSON.serialize(request), result.narrate_Message__c);
        System.assertEquals('MuhRequest', result.narrate_Request__c);
        System.assertEquals('MuhQuiddity', result.narrate_Quiddity__c);
    }

    @isTest
    private static void constructLogEventFromRestResponse() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_NarrateTEST.class.getName()).snap();
        RestResponse response = new RestResponse();
        response.responseBody = Blob.valueOf('General Kenobi!');
        response.statusCode = 200;
        narrate_LogEvent__e result = Narrate.constructLogEvent(snappy, response);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(JSON.serialize(response), result.narrate_Message__c);
        System.assertEquals('MuhRequest', result.narrate_Request__c);
        System.assertEquals('MuhQuiddity', result.narrate_Quiddity__c);
    }

    @isTest
    private static void constructLogEventFromHttpRequest() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_NarrateTEST.class.getName()).snap();
        HttpRequest request = new HttpRequest();
        request.setBody('Hello there');
        request.setMethod('GET');
        narrate_LogEvent__e result = Narrate.constructLogEvent(snappy, request);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(request.toString(), result.narrate_Message__c);
        System.assertEquals('MuhRequest', result.narrate_Request__c);
        System.assertEquals('MuhQuiddity', result.narrate_Quiddity__c);
    }

    @isTest
    private static void constructLogEventFromHttpResponse() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.newInstanceForClass(narrate_NarrateTEST.class.getName()).snap();
        HttpResponse response = new HttpResponse();
        response.setBody('General Kenobi!');
        response.setStatusCode(200);
        narrate_LogEvent__e result = Narrate.constructLogEvent(snappy, response);
        System.assertEquals('Rest', result.narrate_Level__c);
        System.assertEquals(snappy.theClass, result.narrate_Class__c);
        System.assertEquals(snappy.theMethod, result.narrate_Method__c);
        System.assertEquals(snappy.theLine, result.narrate_Line__c);
        System.assertEquals(response.toString(), result.narrate_Message__c);
        System.assertEquals('MuhRequest', result.narrate_Request__c);
        System.assertEquals('MuhQuiddity', result.narrate_Quiddity__c);
    }

    @isTest
    private static void narratorDisabled(){
        Narrate.settings = new narrate_NarratorConfig__c(EnabledTests__c=false);
        Narrate.debug('Herpaderp');
        Narrate.info('Herpaderp');
        Narrate.warn('Herpaderp');
        Narrate.error('Herpaderp');
        Narrate.wtf('Herpaderp');
        Narrate.fine('Herpaderp');
        Narrate.finer('Herpaderp');
        Narrate.finest('Herpaderp');
        Narrate.except(new DmlException('Test Exception'));
        Narrate.rest(new RestRequest());
        Narrate.rest(new RestResponse());
        Narrate.http(new HttpRequest());
        Narrate.http(new HttpResponse());
    }

    @isTest
    private static void coveringOverloadSignatures(){
        Narrate.debug('Herp', 'Derp');
        Narrate.debug('Herp', new String[]{'Derpy', 'Derp'});
        Narrate.info('Herp', 'Derp');
        Narrate.info('Herp', new String[]{'Derpy', 'Derp'});
        Narrate.warn('Herp', 'Derp');
        Narrate.warn('Herp', new String[]{'Derpy', 'Derp'});
        Narrate.error('Herp', 'Derp');
        Narrate.error('Herp', new String[]{'Derpy', 'Derp'});
        Narrate.wtf('Herp', 'Derp');
        Narrate.wtf('Herp', new String[]{'Derpy', 'Derp'});
        Narrate.fine('Herp', 'Derp');
        Narrate.fine('Herp', new String[]{'Derpy', 'Derp'});
        Narrate.finer('Herp', 'Derp');
        Narrate.finer('Herp', new String[]{'Derpy', 'Derp'});
        Narrate.finest('Herp', 'Derp');
        Narrate.finest('Herp', new String[]{'Derpy', 'Derp'});
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
