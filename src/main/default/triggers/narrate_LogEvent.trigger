trigger narrate_LogEvent on narrate_LogEvent__e (after insert) {
    List<narrate_LogEvent__e> logEvents = (List<narrate_LogEvent__e>) Trigger.New;
    narrate_LogEventDelegator delegator = new narrate_LogEventDelegator();
    delegator.receiveEvents(logEvents);
}