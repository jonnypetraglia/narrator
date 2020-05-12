public without sharing class narrate_LogEventBuffer {

    public narrate_LogEventBuffer() {}

    public narrate_LogEventBuffer(Integer bufferSizeLimit) {
        this.bufferSizeLimit = bufferSizeLimit;
    }

    public void add(narrate_LogEvent__e data) {
        buffer.add(data);
        if(reachedBufferLimit()) {
            flush();
        }
    }

    public void addAll(List<narrate_LogEvent__e> data) {
        for(narrate_LogEvent__e d : data) {
            buffer.add(d);
        }
        if(reachedBufferLimit()) {
            flush();
        }
    }

    public void flush() {
        buffer.clear();
    }

    public void clear() {
        buffer.clear();
    }

    public Boolean isEmpty() {
        return buffer.isEmpty();
    }

    public void setBufferSizeLimit(Integer bufferSizeLimit) {
        this.bufferSizeLimit = bufferSizeLimit;
    }

    public Integer getBufferSize() {
        return buffer.size();
    }

    public Integer getBufferSizeLimit() {
        return bufferSizeLimit;
    }

    @TestVisible
    private Boolean reachedBufferLimit() {
        return bufferSizeLimit == null || bufferSizeLimit < 1  || getBufferSize() >= bufferSizeLimit;
    }

    //// Private

    @TestVisible
    private Integer bufferSizeLimit = 1;
    private List<narrate_LogEvent__e> buffer = new List<narrate_LogEvent__e>();
}
