global class narrate_UnhandledException extends narrate_Exception {
    private String context;
    private Exception cause;
    global narrate_UnhandledException(Exception cause, String context) {
        this.context = context;
        this.cause = cause;
    }
    override global String getMessage(){
        return 'NARRATOR ERROR: ' + context + (cause!=null ? ('\n' + cause.getStackTraceString()) : '');
    }
}
