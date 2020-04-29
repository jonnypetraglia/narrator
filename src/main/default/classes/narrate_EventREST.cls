@RestResource(urlMapping='/narrate_Logging')
global with sharing class narrate_EventREST {

    @HttpPost
    global static void postLogEvent() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        response.addHeader('Content-Type', 'application/json');
        try {
            narrate_LogEvent__e requestBody = (narrate_LogEvent__e)JSON.deserialize(request.requestBody.toString(), narrate_LogEvent__e.class);
            Database.SaveResult saveResult = EventBus.publish(requestBody);
            response.statusCode = 200;
            response.responseBody = Blob.valueOf(JSON.serialize(saveResult));
            //TODO: Set body? To something useful?
        } catch(JSONException e) {
            System.debug(LoggingLevel.ERROR, 'oh noooooo');
            System.debug(LoggingLevel.ERROR, e.getStackTraceString());
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(JSON.serialize(e));
            // TODO: Better error reporting in response
        }
    }
}