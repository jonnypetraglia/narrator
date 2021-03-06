@isTest
public class narrate_AutoContextNarratorTEST {
    @isTest
    private static void log() {
        EventBusSubscriber testSubscriber = getEventBusSubscriber();
        System.assertEquals(0, testSubscriber.Position, 'Sanity check failed on EventBusSubscriber position.');
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
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
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
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
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
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
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
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
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
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
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
        narrator.setCodeLocationSnapshot(narrate_CodeLocationSnapshot.newInstanceForClass('DoesntMatter'));
        narrator.httpResponse(new HttpResponse());
        Test.getEventBus().deliver(); 
        EventBusSubscriber resultSubscriber = getEventBusSubscriber();
        System.assertEquals(1, resultSubscriber.Position, 'Check on Position for EventBusSubscriber failed');
    }

    @isTest
    private static void context() {
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
        System.assertNotEquals(null, narrator.AUTO_CONTEXT);
        System.assertEquals(narrator.AUTO_CONTEXT, narrator.getFullContext());
        narrator.setContext('Blip');
        System.assertEquals('Blip', narrator.getContext());
        narrator.setContext('Blop');
        System.assertEquals('Blip', narrator.getContext());
        System.assert(narrator.getFullContext().contains(narrator.AUTO_CONTEXT));
        System.assert(narrator.getFullContext().contains('Blip'));
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
