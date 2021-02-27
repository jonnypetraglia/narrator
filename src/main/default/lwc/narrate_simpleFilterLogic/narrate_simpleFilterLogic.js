import { LightningElement, api } from 'lwc';

export default class narrate_SimpleFilterLogic extends LightningElement {
    @api field;
    @api logic;
    @api compareTo
    fieldType;
    valueType;
    valueStep;
    get fields(){
        return [
            {label: 'Class', value: 'Class__c', type: 'string'},
            {label: 'Level', value: 'Level__c', type: 'string'},
            {label: 'Line', value: 'Line__c', type: 'integer'},
            {label: 'Message', value: 'Message__c', type: 'string'},
            {label: 'Method', value: 'Method__c', type: 'string'},
            {label: 'Quiddity', value: 'Quiddity__c', type: 'string'},
            {label: 'Timestamp', value: 'Timestamp__c', type: 'datetime'},
            {label: 'User ID', value: 'User__c', type: 'lookup', object: 'User'}
        ];
    }

    get value(){
        let result = [this.field, this.logic];
        if(this.valueType){
            result.push(this.compareTo);
        }
        return result;
    }

    get logicOptions(){
        let options = ['IS NULL', 'IS NOT NULL', '=', '!='];
        switch(this.fieldType){
            case 'string':
                options = [...options, 'MATCHES', 'DOES NOT MATCH', 'CONTAINS', 'DOES NOT CONTAIN', 'STARTS WITH', 'ENDS WITH'];
                break;
            case 'integer':
            case 'decimal':
                options = [...options, '>', '>=', '<', '<='];
                break;
            case 'date':
            case 'datetime':
                options = [...options, '>', '>=', '<', '<=', 'IS TODAY', 'IS YESTERDAY', 'IS THIS MONTH', 'IS THIS YEAR', 'IS FUTURE', 'IS PAST'];
                break;
            case 'lookup':
                // TODO: Shenanigans
                break;
        }
        return options.map(option => {
            return {label: option, value: option};
        });
    }

    get needsTextInput(){ return this.valueType == 'text';}
    get needsDateInput(){ return this.valueType == 'date';}
    get needsDateTimeInput(){ return this.valueType == 'datetime';}

    handleChangeCompareTo(event){
        this.compareTo = event.detail.value;
    }

    handleChangeLogic(event){
        console.log('handleChangeLogic', event);
        switch(event.detail.value){
            case '=':
            case '!=':
                if(this.fieldType == 'string'){
                    this.valueType = 'text';
                }
                // Deliberate fallthrough
            case '>':
            case '<':
            case '>=':
            case '<=':
                if(this.fieldType == 'integer'){
                    this.valueType = 'number';
                    this.valueStep = 1;
                }else if(this.fieldType == 'decimal'){
                    this.valueType = 'number';
                    this.valueStep = 0.01;
                    // TODO: formatter can be decimal, percentage, or currency
                    this.valueFormat = 'decimal';
                }else if(this.fieldType == 'date'){
                    this.valueType = 'date';
                }else if(this.fieldType == 'datetime'){
                    this.valueType = 'datetime';
                }
                break;
            case 'MATCHES':
            case 'DOES NOT MATCH':
            case 'CONTAINS':
            case 'DOES NOT CONTAIN':
            case 'STARTS WITH':
            case 'ENDS WITH':
                this.valueType = 'text';
                break;
            case 'IS NULL':
            case 'IS NOT NULL':
            case 'IS TODAY':
            case 'IS YESTERDAY':
            case 'IS THIS MONTH':
            case 'IS THIS YEAR':
            case 'IS FUTURE':
            case 'IS PAST':
                // NOT NEEDED
                break;
        }
        this.logic = event.detail.value;
    }

    handleChangeField(event){
        this.fieldType = this.fields.reduce( (prev, curr) => {
            if(curr.value == event.detail.value){
                prev = curr.type;
            }
            return prev;
        }, null);
        this.valueType = null;
        this.field = event.detail.value;
        this.logic = null;
        this.compareTo = null;
    }

    debugValue(){
        console.log(this.value)
        alert(this.value)
    }
}