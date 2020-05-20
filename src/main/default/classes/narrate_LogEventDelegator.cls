public with sharing class narrate_LogEventDelegator {
    Map<String, narrate_ILogger> loggers =new Map<String, narrate_ILogger>();

    // This is where the magic happens
    // @PlatformEventListen or whatever
    public void receiveEvents(List<narrate_LogEvent__e> events) {
        Map<Id, User> userMap = narrate_Query.loadUsersByIDs(narrate_Utilities.getUserIdsFromEvents(events));
        for(narrate_LogEvent__e event : events) {
            Set<String> loggerNamesToLog = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchFilter(event);
            for(String loggerName : loggerNamesToLog) {
                if(!loggers.containsKey(loggerName)) {
                    loggers.put(loggerName, instantiateLogger(loggerName));
                }
                if(loggers.get(loggerName) != null) {
                    loggers.get(loggerName).log(event);
                }
            }
        }
        for(narrate_ILogger logger : loggers.values()) {
            logger.flush();
        }
    }

    //// Private

    @testVisible
    private static narrate_ILogger instantiateLogger(String className) {
        try {
            System.debug(className);
            Type loggerType = Type.forName(className);
            System.debug(loggerType);
            // TODO: If loggerType implements ILogger
            return (narrate_ILogger) loggerType.newInstance();
        } catch(Exception e) {
            System.debug(e.getMessage());
            return null;
        }
    }
}
