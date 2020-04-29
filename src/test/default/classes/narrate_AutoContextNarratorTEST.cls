@isTest
public class narrate_AutoContextNarratorTEST {
    @isTest
    private static void logAndFlush() {
        narrate_LoggingSettingsManager.activeSettings = new List<narrate_LoggingSetting__mdt> {
            new narrate_LoggingSetting__mdt(narrate_Logic__c = 'narrate_Level__c = INFO', narrate_Loggers__c = 'narrate_RecordLogger__c')
        };
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
        narrator.setBufferSizeLimit(3);
        System.assertEquals(3, narrator.getBufferSizeLimit());
        System.assertEquals(0, narrator.buffer.getBufferSize());
        narrator.log('INFO', 'Howdy', null);
        System.assertEquals(1, narrator.buffer.getBufferSize());
        narrator.log('INFO', 'Howdy', null);
        narrator.log('INFO', 'Howdy', null);
        System.assertEquals(0, narrator.buffer.getBufferSize());
        narrator.log('INFO', 'Howdy', null);
        System.assertEquals(1, narrator.buffer.getBufferSize());
        narrator.flush();
        System.assertEquals(0, narrator.buffer.getBufferSize());
    }
    
    @isTest
    private static void except() {
        narrate_LoggingSettingsManager.activeSettings = new List<narrate_LoggingSetting__mdt> {
            new narrate_LoggingSetting__mdt(narrate_Logic__c = 'narrate_Level__c = EXCEPT', narrate_Loggers__c = 'narrate_RecordLogger__c')
        };
        narrate_AutoContextNarrator narrator = new narrate_AutoContextNarrator();
        narrator.setBufferSizeLimit(3);
        narrator.except(new DmlException());
        System.assertEquals(1, narrator.buffer.getBufferSize());
        narrator.flush();
        System.assertEquals(0, narrator.buffer.getBufferSize());
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
}
