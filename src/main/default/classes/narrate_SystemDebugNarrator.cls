public with sharing class narrate_SystemDebugNarrator implements narrate_INarrator {
    Map<String, LoggingLevel> loggingLevels = new Map<String, LoggingLevel> {
            LoggingLevel.NONE.name() => LoggingLevel.NONE,
            LoggingLevel.DEBUG.name() => LoggingLevel.DEBUG,
            LoggingLevel.INFO.name() => LoggingLevel.INFO,
            LoggingLevel.WARN.name() => LoggingLevel.WARN,
            LoggingLevel.ERROR.name() => LoggingLevel.ERROR,
            LoggingLevel.FINE.name() => LoggingLevel.FINE,
            LoggingLevel.FINER.name() => LoggingLevel.FINER,
            LoggingLevel.FINEST.name() => LoggingLevel.FINEST
    };

    public void log(String level, String message, List<Object> values) {
        if(values == null) {
            values = new List<Object>();
        }
        String premsg = context != null ? '[' + context + '] ' : '';
        LoggingLevel lvl = loggingLevels.containsKey(level.toUpperCase()) ? loggingLevels.get(level.toUpperCase()) : LoggingLevel.DEBUG;
        String msg = message == null ? null : String.format(message, narrate_Utilities.castToStringList(values));
        System.debug(lvl, premsg + msg);
        lastLevel = lvl;
        lastLog = premsg + msg;
    }

    public void except(Exception error) {
        System.debug(LoggingLevel.ERROR, error.getTypeName() + ': ' + error.getMessage());
        System.debug(LoggingLevel.ERROR, error.getStackTraceString());
        lastLevel = LoggingLevel.ERROR;
        lastLog = error.getStackTraceString();
    }

    public void restRequest(RestRequest request) {
        System.debug('REST[METHOD]=' + request.httpMethod);
        System.debug('REST[URI]=' + request.requestURI);
        System.debug('REST[Path]=' + request.resourcePath);
        System.debug('REST[Remote]=' + request.remoteAddress);
        System.debug('REST[Headers]=' + request.headers);
        System.debug('REST[Params]=' + request.params);
        lastLog = 'REST[Body]=' + (request.requestBody!=null ? request.requestBody.toString() : null);
        System.debug(lastLog);
        lastLevel = LoggingLevel.DEBUG;
    }

    public void restResponse(RestResponse response) {
        System.debug('REST[Status]=' + response.statusCode);
        System.debug('REST[Headers]=' + response.headers);
        lastLevel = LoggingLevel.DEBUG;
        lastLog = 'REST[Body]=' + (response.responseBody!=null ? response.responseBody.toString() : null);
        System.debug(lastLog);
    }

    public void httpRequest(HttpRequest request) {
        System.debug('HTTP[METHOD]=' + request.getMethod());
        System.debug('HTTP[URI]=' + request.getEndpoint());
        System.debug('HTTP[Body]=' + request.getBody());
        // TODO: IT would be lovely to print headers here but Apex provides no way to retrieve the headers of an HttpRequest
        lastLevel = LoggingLevel.DEBUG;
        lastLog = 'HTTP[Body]=' + request.getBody();
    }

    public void httpResponse(HttpResponse response) {
        System.debug('HTTP[Code]=' + response.getStatusCode());
        System.debug('HTTP[Status]=' + response.getStatus());
        System.debug('HTTP[Status]=' + response.getStatus());
        for(String headerKey : response.getHeaderKeys()) {
            System.debug('HTTP[Header="' + headerKey + '"]=' + response.getHeader(headerKey));
        }
        System.debug('HTTP[Body]=' + response.getBody());
        lastLog = 'HTTP[Body]=' + response.getBody();
    }

    public String getContext() {
        return context;
    }
    public void setContext(String context) {
        this.context = context;
    }

    public void setCodeLocationSnapshot(narrate_CodeLocationSnapshot snapshot) {
        // Don't care
    }

    //// Private

    private String context;
    @TestVisible
    private String lastLog;
    @TestVisible
    private LoggingLevel lastLevel;
}

