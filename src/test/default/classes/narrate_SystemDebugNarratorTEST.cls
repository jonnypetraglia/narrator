@IsTest
public class narrate_SystemDebugNarratorTEST {
    @IsTest
    private static void logNoValues() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        narrator.log('INFO', 'Hello', null);
        System.assertEquals(LoggingLevel.INFO, narrator.lastLevel);
        System.assertEquals('Hello', narrator.lastLog);
    }

    @IsTest
    private static void logWithValues() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        narrator.log('INFO', 'My name is {0}', new List<String>{'Walter'});
        System.assertEquals(LoggingLevel.INFO, narrator.lastLevel);
        System.assertEquals('My name is Walter', narrator.lastLog);
    }

    @IsTest
    private static void except() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        Exception whatsit = new DmlException();
        narrator.except(whatsit);
        System.assertEquals(LoggingLevel.ERROR, narrator.lastLevel);
        System.assertEquals(whatsit.getStackTraceString(), narrator.lastLog);
    }

    @IsTest
    private static void context() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        System.assertEquals(null, narrator.getContext());
        narrator.setContext('First Context');
        System.assertEquals('First Context', narrator.getContext());
        narrator.setContext('Second Context');
        System.assertEquals('Second Context', narrator.getContext());
    }

    @IsTest
    private static void defaultToDebug() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        narrator.log('INVALID_LEVEL', 'Hello', null);
        System.assertEquals(LoggingLevel.DEBUG, narrator.lastLevel);
    }
}
