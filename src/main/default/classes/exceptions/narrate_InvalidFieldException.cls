global class narrate_InvalidFieldException extends narrate_Exception {
    private String fieldName, objectName;
    global narrate_InvalidFieldException(String fieldName, String objectName){
        this.fieldName = fieldName;
        this.objectName = objectName;
    }
    override global String getMessage(){
        return 'NARRATOR ERROR: Invalid field ' + fieldName + ' on SObject ' + objectName;
    }
}