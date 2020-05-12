public without sharing class narrate_AutoContextNarrator implements narrate_INarrator {

    public narrate_AutoContextNarrator() {
    }

    public void log(String level, String message, List<Object> values) {
        String formattedMessage = String.format(message, narrate_Utilities.castToStringList(values));
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(getFullContext(), takeSnapshot(), level, formattedMessage);
        Set<String> loggerNamesToLog = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchFilter(logData);
        for(String loggerName : loggerNamesToLog) {
            buffer.add(logData); 
        }
    }

    public void except(Exception error) {
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(getFullContext(), takeSnapshot(error), error);
        System.assertNotEquals(null, logData);
        Set<String> loggerNamesToLog = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchFilter(logData);
        for(String loggerName : loggerNamesToLog) {
            buffer.add(logData);
        }
    }

    // TODO: Write test?
    public void restRequest(RestRequest request) {
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(getFullContext(), takeSnapshot(), request);
        Set<String> loggerNamesToLog = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchFilter(logData);
        for(String loggerName : loggerNamesToLog) {
            buffer.add(logData);
        }
    }

    // TODO: Write test?
    public void restResponse(RestResponse response) {
        narrate_LogEvent__e logData = narrate_Utilities.constructLogEvent(getFullContext(), takeSnapshot(), response);
        Set<String> loggerNamesToLog = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchFilter(logData);
        for(String loggerName : loggerNamesToLog) {
            buffer.add(logData);
        }
    }

    public void flush() {
        buffer.flush();
    }

    public String getContext() {
        return userContext;
    }

    public void setContext(String context) {
        if(this.userContext==null) {
            this.userContext = context;
        }
    }

    public void setCodeLocationSnapshot(narrate_CodeLocationSnapshot snapshot) {
        this.snapshot = snapshot;
    }

    public void setBufferSizeLimit(Integer size) {
        buffer.setBufferSizeLimit(size);
    }

    public Integer getBufferSizeLimit() {
        return buffer.getBufferSizeLimit();
    }

    // PRIVATE

    @testVisible
    private final String AUTO_CONTEXT = System.now().formatGmt('HH:mm:ss.SSS');
    private String userContext = null;
    @testVisible
    private narrate_LogEventBuffer buffer = new narrate_LogEventBuffer();
    private narrate_CodeLocationSnapshot snapshot;

    private narrate_CodeLocationSnapshot.Snapshot takeSnapshot(Exception e) {
        return snapshot == null ? new narrate_CodeLocationSnapshot.Snapshot() : snapshot.snap(e);
    }

    private narrate_CodeLocationSnapshot.Snapshot takeSnapshot() {
        return snapshot == null ? new narrate_CodeLocationSnapshot.Snapshot() : snapshot.snap();
    }

    @testVisible
    private String getFullContext() {
        return AUTO_CONTEXT + (userContext!=null ? (' ' + + userContext) : '');
    }
}