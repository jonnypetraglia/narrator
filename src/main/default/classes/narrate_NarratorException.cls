global class narrate_NarratorException extends Exception {
    private String context;
    private Exception cause;
    global narrate_NarratorException(Exception cause, String context) {
        this.context = context;
        this.cause = cause;
    }
    override global String getMessage(){
        return 'NARRATOR ERROR: ' + context + (cause!=null ? ('\n' + cause.getStackTraceString()) : '');
    }
}
