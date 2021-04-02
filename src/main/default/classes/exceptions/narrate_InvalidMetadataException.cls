@testVisible
global class InvalidMetadataException extends Exception{
    override global String getMessage(){
        return 'NARRATOR ERROR: Invalid metadata value: ' + super.getMessage();
    }
}