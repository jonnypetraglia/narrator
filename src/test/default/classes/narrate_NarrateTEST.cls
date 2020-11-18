@isTest
public with sharing class narrate_NarrateTEST {
    @isTest
    private static void logDebug() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.debug('Application');
        System.assertEquals('Debug', narrator.loggedLevel);
        System.assertEquals('Application', narrator.loggedMessage);
        Narrate.debug('Application', testValues());
        System.assertEquals('Debug', narrator.loggedLevel);
        System.assertEquals('Application!!!', narrator.loggedMessage);
    }

    @isTest
    private static void logInfo() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.info('Presentation');
        System.assertEquals('Info', narrator.loggedLevel);
        System.assertEquals('Presentation', narrator.loggedMessage);
        Narrate.info('Presentation', testValues());
        System.assertEquals('Info', narrator.loggedLevel);
        System.assertEquals('Presentation!!!', narrator.loggedMessage);
    }

    @isTest
    private static void logWarn() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.warn('Session');
        System.assertEquals('Warn', narrator.loggedLevel);
        System.assertEquals('Session', narrator.loggedMessage);
        Narrate.warn('Session', testValues());
        System.assertEquals('Warn', narrator.loggedLevel);
        System.assertEquals('Session!!!', narrator.loggedMessage);
    }

    @isTest
    private static void logError() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.error('Transport');
        System.assertEquals('Error', narrator.loggedLevel);
        System.assertEquals('Transport', narrator.loggedMessage);
        Narrate.error('Transport', testValues());
        System.assertEquals('Error', narrator.loggedLevel);
        System.assertEquals('Transport!!!', narrator.loggedMessage);
    }

    @isTest
    private static void logFine() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.fine('Network');
        System.assertEquals('Fine', narrator.loggedLevel);
        System.assertEquals('Network', narrator.loggedMessage);
        Narrate.fine('Network', testValues());
        System.assertEquals('Fine', narrator.loggedLevel);
        System.assertEquals('Network!!!', narrator.loggedMessage);
    }

    @isTest
    private static void logFiner() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.finer('Data Link');
        System.assertEquals('Finer', narrator.loggedLevel);
        System.assertEquals('Data Link', narrator.loggedMessage);
        Narrate.finer('Data Link', testValues());
        System.assertEquals('Finer', narrator.loggedLevel);
        System.assertEquals('Data Link!!!', narrator.loggedMessage);
    }

    @isTest
    private static void logFinest() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.finest('Physical');
        System.assertEquals('Finest', narrator.loggedLevel);
        System.assertEquals('Physical', narrator.loggedMessage);
        Narrate.finest('Physical', testValues());
        System.assertEquals('Finest', narrator.loggedLevel);
        System.assertEquals('Physical!!!', narrator.loggedMessage);
    }

    @isTest
    private static void logWtf() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.wtf('Electrons');
        System.assertEquals('Wtf', narrator.loggedLevel);
        System.assertEquals('Electrons', narrator.loggedMessage);
        Narrate.wtf('Electrons', testValues());
        System.assertEquals('Wtf', narrator.loggedLevel);
        System.assertEquals('Electrons!!!', narrator.loggedMessage);
    }


    @isTest
    private static void except() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.except(new DmlException('Test Exception'));
        System.assertEquals('Except', narrator.loggedLevel);
        System.assertEquals('Test Exception', narrator.loggedMessage);
    }

    @isTest
    private static void restRequest() {
        TestNarrator narrator = setupTestNarrator();
        RestRequest req = new RestRequest();
        req.requestBody = Blob.valueOf('Greetings');
        Narrate.rest(req);
        System.assertEquals('REST', narrator.loggedLevel);
        System.assertEquals('Greetings', narrator.loggedMessage);
    }

    @isTest
    private static void restResponse() {
        TestNarrator narrator = setupTestNarrator();
        RestResponse res = new RestResponse();
        res.responseBody = Blob.valueOf('Farewell');
        Narrate.rest(res);
        System.assertEquals('REST', narrator.loggedLevel);
        System.assertEquals('Farewell', narrator.loggedMessage);
    }

    @isTest
    private static void httpRequest() {
        TestNarrator narrator = setupTestNarrator();
        HttpRequest req = new HttpRequest();
        req.setBody('Greetings');
        Narrate.http(req);
        System.assertEquals('HTTP', narrator.loggedLevel);
        System.assertEquals('Greetings', narrator.loggedMessage);
    }

    @isTest
    private static void httpResponse() {
        TestNarrator narrator = setupTestNarrator();
        HttpResponse res = new HttpResponse();
        res.setBody('Farewell');
        Narrate.http(res);
        System.assertEquals('HTTP', narrator.loggedLevel);
        System.assertEquals('Farewell', narrator.loggedMessage);
    }

    @isTest
    private static void start() {
        TestNarrator narrator = setupTestNarrator();
        Narrate.start('Contexty!');
        System.assertEquals('Contexty!', narrator.getContext());
    }

    public class TestNarrator implements narrate_INarrator {
        private String loggedLevel, loggedMessage;
        private List<Object> loggedValues;
        private String testContext;
        TestNarrator() {}
        public void log(String level, String message, List<Object> values) {
            loggedLevel = level;
            loggedMessage = message;
            if(values != null && values.contains('Don\'t Panic')) {
                loggedMessage += '!!!';
            }
        }
        public void except(Exception error) {
            loggedLevel = 'Except';
            loggedMessage = error.getMessage();
        }
        public void httpRequest(httpRequest request) {
            loggedLevel = 'HTTP';
            loggedMessage = request.getBody();
        }
        public void httpResponse(httpResponse response) {
            loggedLevel = 'HTTP';
            loggedMessage = response.getBody();
        }
        public void restRequest(RestRequest request) {
            loggedLevel = 'REST';
            loggedMessage = request.requestBody.toString();
        }
        public void restResponse(RestResponse response) {
            loggedLevel = 'REST';
            loggedMessage = response.responseBody.toString();
        }
        public String getContext() {return testContext;}
        public void setContext(String context) { testContext = context;}
        public void setCodeLocationSnapshot(narrate_CodeLocationSnapshot snap) {}
    }

    static TestNarrator setupTestNarrator() {
        TestNarrator narrator = new TestNarrator();
        Narrate.narrators = new List<narrate_INarrator> {narrator};
        Narrate.settings = new narrate_NarratorConfig__c(EnabledTests__c=true);
        return narrator;
    }

    static List<String> testValues() {
        return new List<String>{'Don\'t Panic'};
    }
}
