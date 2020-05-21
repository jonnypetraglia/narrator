trigger narrate_LogEvent on narrate_LogEvent__e (after insert) {
    (new narrate_LogEventDelegator()).receiveEvents((List<narrate_LogEvent__e>) Trigger.New);
}