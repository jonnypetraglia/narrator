public with sharing class narrate_LogEventDelegator {
    Map<String, narrate_ILogger> loggers =new Map<String, narrate_ILogger>();

    // This is where the magic happens
    // @PlatformEventListen or whatever
    public void receiveEvents(List<narrate_LogEvent__e> events) {
        // Create lists for each Logger
        Map<String, List<narrate_LogEvent__e>> eventsForLoggers = new Map<String, List<narrate_LogEvent__e>>();
        for(narrate_LogEvent__e event : events) {
            Set<String> loggerNamesToLog = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchFilter(event);
            for(String loggerName : loggerNamesToLog) {
                eventsForLoggers.get(loggerName).add(event);
            }
        }
        // Instantiate & emit the events as a list for each logger
        for(String loggerName : eventsForLoggers.keySet()){
            List<narrate_LogEvent__e> events = eventsForLoggers.get(loggerName);
            if(!loggers.containsKey(loggerName)) {
                loggers.put(loggerName, instantiateLogger(loggerName));
            }
            if(loggers.get(loggerName) != null) {
                loggers.get(loggerName).log(events);
            }
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
            System.debug('NARRATOR ERROR: \n' + e.getStackTraceString()());
            return null;
        }
    }
}
