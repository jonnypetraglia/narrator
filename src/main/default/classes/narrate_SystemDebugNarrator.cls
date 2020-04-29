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
        LoggingLevel lvl = loggingLevels.containsKey(level) ? loggingLevels.get(level) : LoggingLevel.DEBUG;
        String msg = String.format(message, narrate_Utilities.castToStringList(values));
        System.debug(lvl, lastLog);
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
        System.debug('REST[HTTP]=' + request.httpMethod);
        System.debug('REST[URI]=' + request.requestURI);
        System.debug('REST[Path]=' + request.resourcePath);
        System.debug('REST[Remote]=' + request.remoteAddress);
        System.debug('REST[Headers]=' + request.headers);
        System.debug('REST[Params]=' + request.params);
        System.debug('REST[Body]=' + request.requestBody);
    }

    public void restResponse(RestResponse response) {
        System.debug('REST[Status]=' + response.statusCode);
        System.debug('REST[Headers]=' + response.headers);
        System.debug('REST[Body]=' + response.responseBody);
    }

    public void flush() {
        // Nothing to do
    }
    public String getContext() {
        return context;
    }
    public void setContext(String context) {
        this.context = context;
    }

    //// Private

    private String context;
    @TestVisible
    private String lastLog;
    @TestVisible
    private LoggingLevel lastLevel;
}

