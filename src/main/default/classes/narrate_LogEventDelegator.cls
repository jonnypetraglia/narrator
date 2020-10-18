public with sharing class narrate_LogEventDelegator {
    Map<String, narrate_ILogger> loggers = new Map<String, narrate_ILogger>();
    @testVisible
    private List<narrate_LoggingSetting__mdt> activeSettingsForQuiddity {get {
        if(activeSettingsForQuiddity==null) {
            activeSettingsForQuiddity = [SELECT narrate_Logic__c, narrate_Loggers__c FROM narrate_LoggingSetting__mdt WHERE narrate_Active__c = true AND (narrate_Quiddity__c = null OR narrate_Quiddity__c = :String.valueOf(System.Request.getCurrent().getQuiddity()))];
        }
        return activeSettingsForQuiddity;
    } set;}

    // This is where the magic happens
    // @PlatformEventListen or whatever
    public void receiveEvents(List<narrate_LogEvent__e> events) {
        if(!activeSettingsForQuiddity.isEmpty()){
            // Create lists for each Logger
            Map<String, List<narrate_LogEvent__e>> eventsForLoggers = new Map<String, List<narrate_LogEvent__e>>();
            Set<String> failedLoggerNames = new Set<String>();
            for(narrate_LogEvent__e event : events) {
                Set<String> loggerNamesToLog = narrate_LoggingSettingsManager.getLoggerNamesForSettingsThatMatchFilter(event);
                loggerNamesToLog.removeAll(failedLoggerNames);
                for(String loggerName : loggerNamesToLog) {
                    try {
                        if(! ( Type.forName(loggerName) instanceof narrate_ILogger)){
                            throw new InvalidMetadataException(loggerName);
                        }
                        loggers.put(loggerName, (narrate_ILogger) (Type.forName(loggerName)).newInstance());
                        if(eventsForLoggers.get(loggerName)==null){
                            eventsForLoggers.put(loggerName, new List<narrate_LogEvent__e>());
                        }
                        eventsForLoggers.get(loggerName).add(event);
                    } catch(InvalidMetadataException error){
                        failedLoggerNames.add(loggerName);
                        System.debug('NARRATOR ERROR: Tried to instantiate a class that is not a Logger - ' + loggerName);
                    } catch(Exception error){
                        failedLoggerNames.add(loggerName);
                        System.debug(LoggingLevel.ERROR, 'WHAT A TERRIBLE FAILURE: ' + error.getMessage() + '\n' + error.getStackTraceString());
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
                    System.debug(LoggingLevel.ERROR, 'WHAT A TERRIBLE FAILURE: ' + error.getMessage() + '\n' + error.getStackTraceString());
                }
            }
        }
    }

    public class InvalidMetadataException extends Exception{}
}
