@IsTest
public class narrate_LogEventBufferTEST {
    
    @IsTest
    private static void AutoFlushAtBufferSizeLimit() {
        Test.startTest();
        narrate_LogEventBuffer buffer = new narrate_LogEventBuffer(100);
        for(Integer i=0; i<99; i++) {
            buffer.add(new narrate_LogEvent__e());
        }
        System.assertEquals(99, buffer.getBufferSize());
        buffer.add(new narrate_LogEvent__e());
        System.assertEquals(0, buffer.getBufferSize());
        Test.stopTest();
    }

    @IsTest
    private static void ManualFlush() {
        Test.startTest();
        narrate_LogEventBuffer buffer = new narrate_LogEventBuffer(50);
        for(Integer i=0; i<25; i++) {
            buffer.add(new narrate_LogEvent__e());
        }
        System.assertEquals(25, buffer.getBufferSize());
        buffer.flush();
        System.assertEquals(0, buffer.getBufferSize());
        Test.stopTest();
    }

    @IsTest
    private static void reachedBufferLimit() {
        Test.startTest();
        narrate_LogEventBuffer buffer = new narrate_LogEventBuffer(100);
        for(Integer i=0; i<99; i++) {
            buffer.add(new narrate_LogEvent__e());
        }
        System.assertEquals(false, buffer.reachedBufferLimit());
        buffer.bufferSizeLimit = 99;
        System.assertEquals(true, buffer.reachedBufferLimit());
        Test.stopTest();
    }
}
