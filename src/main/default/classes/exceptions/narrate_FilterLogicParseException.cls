global class narrate_FilterLogicParseException extends narrate_Exception {
    private String logic, message;
    global narrate_FilterLogicParseException(String message, String logic){
        this.message = message;
        this.logic = logic;
    }
    override global String getMessage(){
        if(logic==null && message==null){
            return 'NARRATOR ERROR: Unable to parse logic';
        }
        if(logic==null){
            return 'NARRATOR ERROR: Unable to parse logic, ' + message;
        }
        return 'NARRATOR ERROR: Unable to parse logic "' + logic + '", ' + message;
    }
}