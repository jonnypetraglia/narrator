global class narrate_FilterLogicParseException extends narrate_Exception {
    private String logic, message;
    global narrate_FilterLogicParseException(String logic, String message){
        this.logic = logic;
        this.message = message;
    }
    override global String getMessage(){
        return 'NARRATOR ERROR: Unable to parse logic "' + logic + '", ' + message;
    }
}