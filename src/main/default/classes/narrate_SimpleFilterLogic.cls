public without sharing class narrate_SimpleFilterLogic implements narrate_IFilterLogic {
    private String fieldName, logic, whatToCompareTo;
    private static Map<String, Pattern> patternCache = new Map<String, Pattern>();

    public narrate_SimpleFilterLogic(String[] filterLogic) {
        fieldName = filterLogic[0];
        logic = filterLogic[1];
        if(filterLogic.size() > 2) {
            whatToCompareTo = filterLogic[2];
        }
    }

    public void setWhatToCompareTo(String whatToCompareTo) {
        this.whatToCompareTo = whatToCompareTo;
    }

    public void setLogic(String logic) {
        this.logic = logic;
    }

    public boolean evaluate(SObject compareTo) {
        
        boolean result = false;
        try {
            System.debug('bro evaluate ' + fieldName + ' is of ' + compareTo.getSObjectType());
            System.debug('bro isSet ' + compareTo.isSet(fieldName));
            if(compareTo.isSet(fieldName)) {
                Object val = compareTo.get(fieldName);
                System.debug('bro val ' + val);
                if(val == null || logic == 'IS NULL' || logic == 'IS NOT NULL') {
                    result = evaluateShared(val, whatToCompareTo);
                } else {
                    Map<String, Schema.SobjectField> objectFieldMap = compareTo.getSObjectType().getDescribe().fields.getMap();
                    Schema.DisplayType fieldType = objectFieldMap.get(fieldName).getDescribe().getType();
                    switch on fieldType {
                        when BOOLEAN {
                            result = evaluateField((Boolean)val, whatToCompareTo == 'true');
                        }
                        when ID, REFERENCE {
                            result = evaluateField((Id)val, whatToCompareTo == null ? null : Id.valueOf(whatToCompareTo));
                        }
                        when LONG, INTEGER {
                            result = evaluateField((Long)val, whatToCompareTo == null ? null : Long.valueOf(whatToCompareTo));
                        }
                        when DOUBLE, CURRENCY, PERCENT {
                            result = evaluateField((Double)val, whatToCompareTo == null ? null : Double.valueOf(whatToCompareTo));
                        }
                        when DATE {
                            result = evaluateField((Date)val, whatToCompareTo == null ? null : Date.valueOf(whatToCompareTo));
                        }
                        when DATETIME {
                            result = evaluateField((DateTime)val, whatToCompareTo == null ? null : (DateTime)JSON.deserialize('"' + whatToCompareTo + '"', DateTime.class));
                        }
                        when STRING, EMAIL, ENCRYPTEDSTRING, MULTIPICKLIST, PHONE, TEXTAREA, URL, COMBOBOX, TIME {
                            result = evaluateField((String)val, (String)whatToCompareTo);
                        }
                        when else {
                            result = evaluateField(String.valueOf(val), String.valueOf(whatToCompareTo));
                        }
                        // Also: Address, Base64, DataCategoryGroupReference, 
                    }
                }
            }
        } catch(Exception e) {
            result = null;
        }
        return result;
    }

    private boolean evaluateField(Boolean left, Boolean right) {
        return evaluateShared(left, right);
    }

    private boolean evaluateField(Id left, Id right) {
        return evaluateShared(left, right);
    }

    private boolean evaluateField(Long left, Long right) {
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

    private boolean evaluateField(Double left, Double right) {
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

    private boolean evaluateField(Date left, Date right) {
        boolean result = evaluateShared(left, right);
        if(!result) {
            switch on logic {
                when '>' { result = left > right; }
                when '<' { result = left < right; }
                when '>=' { result = left >= right; }
                when '<=' { result = left <= right; }
                // TODO: All this date (& datetime)stuff
                when 'IS TODAY' { result = Date.today() == left; }
                when 'IS YESTERDAY' { result = Date.today().addDays(-1) == left; }
                when 'IS THIS MONTH' { result = Date.today().month() == left.month(); }
                when 'IS THIS YEAR' { result = Date.today().year() == left.year(); }
                when 'IS FUTURE' { result = Date.today() < left; }
                when 'IS PAST' { result = Date.today() > left; }
            }
        }
        return result;
    }

    private boolean evaluateField(DateTime left, DateTime right) {
        boolean result = evaluateShared(left, right);
        if(!result) {
            Date leftDate = Date.newinstance(left.year(), left.month(), left.day());
            switch on logic {
                when '>' { result = left > right; }
                when '<' { result = left < right; }
                when '>=' { result = left >= right; }
                when '<=' { result = left <= right; }
                when 'IS TODAY' { result = Date.today() == leftDate; }
                when 'IS YESTERDAY' { result = Date.today().addDays(-1) == leftDate; }
                when 'IS THIS MONTH' { result = Date.today().month() == leftDate.month(); }
                when 'IS THIS YEAR' { result = Date.today().year() == leftDate.year(); }
                when 'IS FUTURE' { result = DateTime.now() < left; }
                when 'IS PAST' { result = DateTime.now() > left; }
            }
        }
        return result;
    }

    private boolean evaluateField(String left, String right) {
        boolean result = evaluateShared(left, right);
        System.debug('bro evaluate field ' + result);
        if(!result) {
            System.debug('bro string logic ' + left + ' ' + logic + ' ' + right);
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
        System.debug('bro evaluate field again ' + result);
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
}