public without sharing class narrate_SimpleFilterLogic implements narrate_IFilterLogic {
    @testVisible
    private String fieldName, logic, whatToCompareTo;
    private static Map<String, Pattern> patternCache = new Map<String, Pattern>();

    public narrate_SimpleFilterLogic(){}

    public void setLogic(String filterLogic) {
        this.logic = filterLogic;
        String[] parsedFilterLogic = (String[])JSON.deserialize(logic, String[].class);
        this.fieldName = parsedFilterLogic[0];
        this.logic = parsedFilterLogic[1];
        if(parsedFilterLogic.size() > 2) {
            this.whatToCompareTo = parsedFilterLogic[2];
        }
    }

    public boolean evaluate(SObject compareTo) {
        boolean result = false;
        try {
            Object val = compareTo.isSet(fieldName) ? compareTo.get(fieldName) : null;
            if(!compareTo.isSet(fieldName) || compareTo.get(fieldName) == null || logic == 'IS NULL' || logic == 'IS NOT NULL') {
                result = evaluateShared(val, whatToCompareTo);
            } else {
                Map<String, Schema.SobjectField> objectFieldMap = compareTo.getSObjectType().getDescribe().fields.getMap();
                Schema.DisplayType fieldType = objectFieldMap.get(fieldName).getDescribe().getType();
                switch on fieldType {
                    when BOOLEAN {
                        result = evaluateBoolean((Boolean)val, whatToCompareTo == 'true');
                    }
                    when ID, REFERENCE {
                        result = evaluateId((Id)val, whatToCompareTo == null ? null : Id.valueOf(whatToCompareTo));
                    }
                    when LONG, INTEGER {
                        result = evaluateLong((Long)val, whatToCompareTo == null ? null : Long.valueOf(whatToCompareTo));
                    }
                    when CURRENCY, PERCENT {
                        result = evaluateDecimal((Decimal)val, whatToCompareTo == null ? null : Decimal.valueOf(whatToCompareTo));
                    }
                    when DOUBLE  {
                        result = evaluateDouble((Double)val, whatToCompareTo == null ? null : Double.valueOf(whatToCompareTo));
                    }
                    when DATE {
                        result = evaluateDate((Date)val, whatToCompareTo == null ? null : Date.valueOf(whatToCompareTo));
                    }
                    when DATETIME {
                        result = evaluateDateTime((DateTime)val, whatToCompareTo == null ? null : (DateTime)JSON.deserialize('"' + whatToCompareTo + '"', DateTime.class));
                    }
                    when STRING, EMAIL, ENCRYPTEDSTRING, MULTIPICKLIST, PHONE, TEXTAREA, URL, COMBOBOX, TIME {
                        result = evaluateString((String)val, (String)whatToCompareTo);
                    }
                    when else {
                        result = evaluateString(String.valueOf(val), String.valueOf(whatToCompareTo));
                    }
                    // Also: Address, Base64, DataCategoryGroupReference, 
                }
            }
        } catch(SObjectException e) {
            if(e.getMessage().startsWith('Invalid field: ')){
                throw new narrate_InvalidFieldException(fieldName, String.valueOf(compareTo?.getSObjectType()));
            }else{
                System.debug(LoggingLevel.ERROR, 'NARRATOR MSG - ' + e.getStackTraceString());
            }
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'NARRATOR MSG - ' + e.getStackTraceString());
        }
        return result;
    }

    private boolean evaluateBoolean(Boolean left, Boolean right) {
        return evaluateShared(left, right);
    }

    private boolean evaluateId(Id left, Id right) {
        return evaluateShared(left, right);
    }

    private boolean evaluateLong(Long left, Long right) {
        boolean result = evaluateShared(left, right);
        if(!result) {
            switch on logic {
                when '>' { result = left > right; }
                when '<' { result = left < right; }
                when '>=' { result = left >= right; }
                when '<=' { result = left <= right; }
            }
        }
        return result;
    }

    private boolean evaluateDecimal(Decimal left, Decimal right) {
        boolean result = evaluateShared(left, right);
        if(!result) {
            switch on logic {
                when '>' { result = left > right; }
                when '<' { result = left < right; }
                when '>=' { result = left >= right; }
                when '<=' { result = left <= right; }
            }
        }
        return result;
    }

    private boolean evaluateDouble(Double left, Double right) {
        boolean result = evaluateShared(left, right);
        if(!result) {
            switch on logic {
                when '>' { result = left > right; }
                when '<' { result = left < right; }
                when '>=' { result = left >= right; }
                when '<=' { result = left <= right; }
            }
        }
        return result;
    }

    private boolean evaluateDate(Date left, Date right) {
        boolean result = evaluateShared(left, right);
        if(!result) {
            switch on logic {
                when '>' { result = left > right; }
                when '<' { result = left < right; }
                when '>=' { result = left >= right; }
                when '<=' { result = left <= right; }
                when 'IS TODAY' { result = todayGMT() == left; }
                when 'IS YESTERDAY' { result = todayGMT().addDays(-1) == left; }
                when 'IS THIS MONTH' { result = todayGMT().month() == left.month(); }
                when 'IS THIS YEAR' { result = todayGMT().year() == left.year(); }
                when 'IS FUTURE' { result = todayGMT() < left; }
                when 'IS PAST' { result = todayGMT() > left; }
            }
        }
        return result;
    }

    private boolean evaluateDateTime(DateTime left, DateTime right) {
        boolean result = evaluateShared(left, right);
        Date leftDate = left.dateGmt();
        if(!result) {
            switch on logic {
                when '>' { result = left > right; }
                when '<' { result = left < right; }
                when '>=' { result = left >= right; }
                when '<=' { result = left <= right; }
                when 'IS TODAY' { result = todayGMT() == leftDate; }
                when 'IS YESTERDAY' { result = todayGMT().addDays(-1) == leftDate; }
                when 'IS THIS MONTH' { result = todayGMT().month() == leftDate.month(); }
                when 'IS THIS YEAR' { result = todayGMT().year() == leftDate.year(); }
                when 'IS FUTURE' { result = nowGMT() < left; }
                when 'IS PAST' { result = nowGMT() > left; }
            }
        }
        return result;
    }

    private boolean evaluateString(String left, String right) {
        boolean result = evaluateShared(left, right);
        if(!result) {
            switch on logic {
                when 'MATCHES' {
                    if(!patternCache.containsKey(logic)) {
                        patternCache.put(logic, Pattern.compile(right));
                    }
                    result = patternCache.get(logic).matcher(left).matches();
                }
                when 'DOES NOT MATCH' {
                    if(!patternCache.containsKey(logic)) {
                        patternCache.put(logic, Pattern.compile(right));
                    }
                    result = !patternCache.get(logic).matcher(left).matches();
                }
                when 'CONTAINS' { result = left.contains(right); }
                when 'DOES NOT CONTAIN' { result = !left.contains(right); }
                when 'STARTS WITH' { result = left.startsWith(right); }
                when 'ENDS WITH' {  result = left.endsWith(right); }
            }
        }
        return result;
    }

    private boolean evaluateShared(Object left, Object right) {
        boolean result = false;
        switch on logic {
            when 'IS NULL' {        result = left == null; }
            when 'IS NOT NULL' {    result = left != null; }
            when '=' {              result = left == right; }
            when '!=' {             result = left != right; }
        }
        return result;
    }

    private static DateTime nowGMT() {
        return DateTime.now();
    }
    private static Date todayGMT() {
        return nowGMT().dateGMT();
    }

    public Boolean equals(Object compareToObj) {
        if(compareToObj === this){
            return true;
        }
        if(!(compareToObj instanceof narrate_SimpleFilterLogic)){
            return false;
        }
        narrate_SimpleFilterLogic compareTo = (narrate_SimpleFilterLogic)compareToObj;
        return this.fieldName==compareTo.fieldName && this.logic==compareTo.logic && this.whatToCompareTo==compareTo.whatToCompareTo;
    }

    override public String toString(){
        String result = fieldName + ' ' + logic;
        if(whatToCompareTo!=null){
            result+= ' ' + whatToCompareTo;
        }
        return result;
    }

    public static Integer getNumberOfArgsForLogic(String logic){
        switch on logic {
            when 'IS NULL', 'IS NOT NULL', 'IS TODAY', 'IS YESTERDAY', 'IS THIS MONTH', 'IS THIS YEAR', 'IS FUTURE', 'IS PAST' {
                return 0;
            }
            when '=', '!=', '<', '>', '<=', '>=', 'MATCHES', 'DOES NOT MATCH', 'CONTAINS', 'DOES NOT CONTAIN', 'STARTS WITH', 'ENDS WITH' {
                return 1;
            }
            when else {
                return null; //TODO: Throw Exception;
            }
        }
    }
}
