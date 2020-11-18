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
    private static void restRequest() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        RestRequest testRestRequest = new RestRequest();
        testRestRequest.requestBody = Blob.valueOf('Hello');
        narrator.restRequest(testRestRequest);
        System.assertEquals(LoggingLevel.DEBUG, narrator.lastLevel);
        System.assertEquals('REST[Body]=Hello', narrator.lastLog);
    }

    @IsTest
    private static void restResponse() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        RestResponse testRestResponse = new RestResponse();
        testRestResponse.responseBody = Blob.valueOf('Goodbye');
        narrator.restResponse(testRestResponse);
        System.assertEquals(LoggingLevel.DEBUG, narrator.lastLevel);
        System.assertEquals('REST[Body]=Goodbye', narrator.lastLog);
    }

    @IsTest
    private static void httpRequest() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        HttpRequest testHttpRequest = new HttpRequest();
        testHttpRequest.setBody('Hi thar');
        narrator.httpRequest(testHttpRequest);
        System.assertEquals(LoggingLevel.DEBUG, narrator.lastLevel);
        System.assertEquals('HTTP[Body]=Hi thar', narrator.lastLog);
    }

    @IsTest
    private static void httpResponse() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        HttpResponse testHttpResponse = new HttpResponse();
        testHttpResponse.setBody('Laterz');
        narrator.httpResponse(testHttpResponse);
        System.assertEquals(LoggingLevel.DEBUG, narrator.lastLevel);
        System.assertEquals('HTTP[Body]=Laterz', narrator.lastLog);
    }
    @IsTest
    private static void defaultToDebug() {
        narrate_SystemDebugNarrator narrator = new narrate_SystemDebugNarrator();
        narrator.log('INVALID_LEVEL', 'Hello', null);
        System.assertEquals(LoggingLevel.DEBUG, narrator.lastLevel);
    }
}
