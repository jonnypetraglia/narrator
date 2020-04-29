global interface narrate_ICodeLocationSnapshot {
    void snap();
    void snap(Exception traceableException);
    String getClass();
    String getMethod();
    Integer getLine();
}
