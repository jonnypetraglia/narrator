public class narrate_PlatformEventLogger extends narrate_SimpleLogger {
    // Yes, a class to emit a *different* Platform Event
    override public Integer processEvents(List<narrate_LogEvent__e> events) {
        Integer count = 0;
        for(Database.SaveResult saveResult : EventBus.publish(events)) {
            if(saveResult.isSuccess()) {
                count+=1;
            }
        }
        return count;
    }
}
