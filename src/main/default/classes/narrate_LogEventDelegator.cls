/*
    (1) Takes narrate_LogEvent__e Platform Events as input
    (2) Calls narrate_LoggingSettingsManager to determine which ones ought to go to which Loggers
    (3) Instantiates needed Loggers
    (4) Passes said events to appropriate loggers for each event
*/
public with sharing class narrate_LogEventDelegator {

    public void receiveEvents(List<narrate_LogEvent__e> events) {
        if(narrate_LoggingSettingsManager.hasActiveSettings()){
            Map<String, List<narrate_LogEvent__e>> eventsForLoggers = narrate_LoggingSettingsManager.getEventsByLoggerNamesForSettingsThatMatchActiveLoggerSettings(events);
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
                    throw new narrate_InvalidMetadataException(loggerName);
                }
                loggers.put(loggerName, (narrate_ILogger) logger);
            } catch(narrate_InvalidMetadataException error){
                System.debug(LoggingLevel.ERROR, error.getMessage());
            } catch(Exception error){
                System.debug(LoggingLevel.ERROR, 'NARRATOR WHAT A TERRIBLE FAILURE: ' + error.getMessage() + '\n' + error.getStackTraceString());
            }
        }
        return loggers;
    }
    
    @testVisible
    private void logEventsToLoggers(Map<String, List<narrate_LogEvent__e>> eventsForLoggers , Map<String, narrate_ILogger> loggers){
        for(String loggerName : eventsForLoggers.keySet()) {
            try {
                loggers.get(loggerName).log(eventsForLoggers.get(loggerName));
            } catch(narrate_Exception error) {
                System.debug(LoggingLevel.ERROR, error.getMessage());
            } catch(Exception error) {
                System.debug(LoggingLevel.ERROR, 'NARRATOR WHAT A TERRIBLE FAILURE: ' + error.getMessage() + '\n' + error.getStackTraceString());
            }
        }
    }
}