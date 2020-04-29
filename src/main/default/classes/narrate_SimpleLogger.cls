public abstract class narrate_SimpleLogger implements narrate_ILogger {
    public abstract Integer processEvents(List<narrate_LogEvent__e> logs);

    public void log(narrate_LogEvent__e data) {
        logEvents.add(data);
    }

    public void flush() {
        processEvents(logEvents);
        logEvents.clear();
    }

    //// Private
    @testVisible
    protected List<narrate_LogEvent__e> logEvents = new List<narrate_LogEvent__e>();
}
