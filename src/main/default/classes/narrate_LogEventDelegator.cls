public with sharing class narrate_LogEventDelegator {
    Map<String, narrate_ILogger> loggers = new Map<String, narrate_ILogger>();

    // This is where the magic happens
    // @PlatformEventListen or whatever
    public void receiveEvents(List<narrate_LogEvent__e> events) {
        // Create lists for each Logger
        Map<String, List<narrate_LogEvent__e>> eventsForLoggers = new Map<String, List<narrate_LogEvent__e>>();
        for(narrate_LogEvent__e event : events) {
            Set<String> loggerNamesToLog = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchFilter(event);
            for(String loggerName : loggerNamesToLog) {
                try {
                    // TODO: If loggerType implements ILogger
                    loggers.put(loggerName, (narrate_ILogger) (Type.forName(loggerName)).newInstance());
                    if(eventsForLoggers.get(loggerName)==null){
                        eventsForLoggers.put(loggerName, new List<narrate_LogEvent__e>());
                    }
                    eventsForLoggers.get(loggerName).add(event);
                } catch(Exception error){
                    System.debug(LoggingLevel.FATAL, 'WHAT A TERRIBLE FAILURE: ' + error.getMessage() + '\n' + error.getStackTraceString());
                }
            }
        }
        // Instantiate & emit the events as a list for each logger
        for(String loggerName : eventsForLoggers.keySet()) {
            try {
                loggers.get(loggerName).log(eventsForLoggers.get(loggerName));
            } catch(narrate_NarratorException error) {
                System.debug('NARRATOR ERROR: \n' + error.getStackTraceString());
            } catch(Exception error) {
                System.debug(LoggingLevel.FATAL, 'WHAT A TERRIBLE FAILURE: ' + error.getMessage() + '\n' + error.getStackTraceString());
            }
        }
    }
}
