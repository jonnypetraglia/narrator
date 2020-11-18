public with sharing class narrate_LogEventDelegator {
    // This is where the magic happens
    // @PlatformEventListen or whatever
    public void receiveEvents(List<narrate_LogEvent__e> events) {
        if(!narrate_LoggingSettingsManager.hasActiveSettings()){
            Map<String, List<narrate_LogEvent__e>> eventsForLoggers = narrate_LoggingSettingsManager.getEventsByLoggerNamesForSettingsThatMatchLoggerSettings(events);
            Map<String, narrate_ILogger> loggers = instantiateLoggersByName(eventsForLoggers.keySet());
            logEventsToLoggers(eventsForLoggers, loggers);
        }
    }
    
    @testVisible
    private Map<String, narrate_ILogger> instantiateLoggersByName(Set<String> loggerNames){
        Map<String, narrate_ILogger> loggers = new Map<String, narrate_ILogger>();
        for(String loggerName : loggerNames) {
            try {
                Object logger = Type.forName(loggerName).newInstance();
                if(!(logger instanceof narrate_ILogger)){
                    throw new InvalidMetadataException(loggerName);
                }
                loggers.put(loggerName, (narrate_ILogger) logger);
            } catch(InvalidMetadataException error){
                System.debug('NARRATOR ERROR: Tried to instantiate a class that is not a Logger - ' + loggerName);
            } catch(Exception error){
                System.debug(LoggingLevel.ERROR, 'WHAT A TERRIBLE FAILURE: ' + error.getMessage() + '\n' + error.getStackTraceString());
            }
        }
        return loggers;
    }
    
    @testVisible
    private void logEventsToLoggers(Map<String, List<narrate_LogEvent__e>> eventsForLoggers , Map<String, narrate_ILogger> loggers){
        for(String loggerName : eventsForLoggers.keySet()) {
            try {
                loggers.get(loggerName).log(eventsForLoggers.get(loggerName));
            } catch(narrate_NarratorException error) {
                System.debug('NARRATOR ERROR: \n' + error.getStackTraceString());
            } catch(Exception error) {
                System.debug(LoggingLevel.ERROR, 'WHAT A TERRIBLE FAILURE: ' + error.getMessage() + '\n' + error.getStackTraceString());
            }
        }
    }
    
    public class InvalidMetadataException extends Exception{}
}
