@isTest
public class narrate_ComplexFilterLogicTEST {
    
        private static String IS_NULL = 'IS NULL',
                            IS_NOT_NULL = 'IS NOT NULL',
                            EQUALS = '=',
                            NOT_EQUALS = '!=',
                            GREATER_THAN = '>',
                            LESS_THAN = '<',
                            GREATER_THAN_OR_EQUAL = '>=',
                            LESS_THAN_OR_EQUAL = '<=',
                            IS_TODAY = 'IS TODAY',
                            IS_YESTERDAY = 'IS YESTERDAY',
                            IS_THIS_MONTH = 'IS THIS MONTH',
                            IS_THIS_YEAR = 'IS THIS YEAR',
                            IS_PAST = 'IS PAST',
                            IS_FUTURE = 'IS FUTURE',
                            MATCHES = 'MATCHES',
                            DOES_NOT_MATCH = 'DOES NOT MATCH',
                            CONTAINS = 'CONTAINS',
                            DOES_NOT_CONTAIN = 'DOES NOT CONTAIN',
                            STARTS_WITH = 'STARTS WITH',
                            ENDS_WITH = 'ENDS WITH';

    ////////////////////////////////////// BOOLEAN //////////////////////////////////////

    @isTest
    private static void Boolean_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'DoNotCall', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Contact(DoNotCall=null)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(DoNotCall=true)));
    }

    @isTest
    private static void Boolean_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'DoNotCall', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Contact(DoNotCall=true)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(DoNotCall=null)));
    }

    @isTest
    private static void Boolean_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'DoNotCall', EQUALS, 'true'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=true)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=false)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=null)));
    }

    @isTest
    private static void Boolean_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'DoNotCall', NOT_EQUALS, 'true'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=false)));
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=null)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=true)));
    }


    ////////////////////////////////////// Integer //////////////////////////////////////

    @isTest
    private static void Integer_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
    }

    @isTest
    private static void Integer_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
    }

    @isTest
    private static void Integer_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', EQUALS, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    private static void Integer_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', NOT_EQUALS, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
    }

    @isTest
    private static void Integer_GreaterThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', GREATER_THAN, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    private static void Integer_LessThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', LESS_THAN, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    private static void Integer_GreaterThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', GREATER_THAN_OR_EQUAL, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    private static void Integer_LessThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', LESS_THAN_OR_EQUAL, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    ////////////////////////////////////// Decimal //////////////////////////////////////

    @isTest
    private static void Decimal_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
    }

    @isTest
    private static void Decimal_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
    }

    @isTest
    private static void Decimal_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', EQUALS, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    private static void Decimal_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', NOT_EQUALS, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
    }

    @isTest
    private static void Decimal_GreaterThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', GREATER_THAN, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    private static void Decimal_LessThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', LESS_THAN, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    private static void Decimal_GreaterThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', GREATER_THAN_OR_EQUAL, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    private static void Decimal_LessThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'NumberOfEmployees', LESS_THAN_OR_EQUAL, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    ////////////////////////////////////// Double //////////////////////////////////////

    // @isTest
    // private static void Double_IsNull() {
    //     narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
    //     filterLogic.setLogic(new String[] {'Amount', IS_NULL});
    //     System.assertEquals(true, filterLogic.evaluate( new Opportunity(Amount=null)));
    //     System.assertEquals(false, filterLogic.evaluate( new Opportunity(Amount=422.42)));
    // }

    // @isTest
    // private static void Double_IsNotNull() {
    //     narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
    //     filterLogic.setLogic(new String[] {'Amount', IS_NOT_NULL});
    //     System.assertEquals(true, filterLogic.evaluate( new Opportunity(Amount=422.000000000042)));
    //     System.assertEquals(false, filterLogic.evaluate( new Opportunity(Amount=null)));
    // }

    // @isTest
    // private static void Double_Equals() {
    //     narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
    //     filterLogic.setLogic(new String[] {'Amount', EQUALS, '422.000000000042'});
    //     System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=422.000000000042)));
    //     System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    // }

    // @isTest
    // private static void Double_NotEquals() {
    //     narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
    //     filterLogic.setLogic(new String[] {'Amount', NOT_EQUALS, '422.000000000042'});
    //     System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    //     System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=422.000000000042)));
    // }

    // @isTest
    // private static void Double_GreaterThan() {
    //     narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
    //     filterLogic.setLogic(new String[] {'Amount', GREATER_THAN, '422.000000000042'});
    //     System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    //     System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=3.00)));
    // }

    // @isTest
    // private static void Double_LessThan() {
    //     narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
    //     filterLogic.setLogic(new String[] {'Amount', LESS_THAN, '422.000000000042'});
    //     System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=3.00)));
    //     System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    // }

    // @isTest
    // private static void Double_GreaterThanOrEqual() {
    //     narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
    //     filterLogic.setLogic(new String[] {'Amount', GREATER_THAN_OR_EQUAL, '422.000000000042'});
    //     System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    //     System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=422.000000000042)));
    //     System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=3.00)));
    // }

    // @isTest
    // private static void Double_LessThanOrEqual() {
    //     narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
    //     filterLogic.setLogic(new String[] {'Amount', LESS_THAN_OR_EQUAL, '422.000000000042'});
    //     System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=3.00)));
    //     System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=422.000000000042)));
    //     System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    // }

    ////////////////////////////////////// Date //////////////////////////////////////

    @isTest
    private static void Date_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Contact(Birthdate=null)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(Birthdate=testDateGMT())));
    }

    @isTest
    private static void Date_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate( new Contact(Birthdate=null)));
    }

    @isTest
    private static void Date_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', EQUALS, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    private static void Date_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', NOT_EQUALS, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
    }

    @isTest
    private static void Date_GreaterThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', GREATER_THAN, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void Date_LessThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', LESS_THAN, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    private static void Date_GreaterThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', GREATER_THAN_OR_EQUAL, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void Date_LessThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', LESS_THAN_OR_EQUAL, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    private static void Date_IsToday() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', IS_TODAY});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
    }

    @isTest
    private static void Date_IsYesterday() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', IS_YESTERDAY});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    @isTest
    private static void Date_IsThisMonth() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', IS_THIS_MONTH});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addMonths(-1))));
    }

    @isTest
    private static void Date_IsThisYear() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', IS_THIS_YEAR});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addYears(1))));
    }

    @isTest
    private static void Date_IsFuture() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', IS_FUTURE});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    @isTest
    private static void Date_IsPast() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Birthdate', IS_PAST});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    ////////////////////////////////////// Date //////////////////////////////////////

    @isTest
    private static void DateTime_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=null)));
        System.assertEquals(false, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
    }

    @isTest
    private static void DateTime_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=null)));
    }

    @isTest
    private static void DateTime_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', EQUALS, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void DateTime_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', NOT_EQUALS, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
    }

    @isTest
    private static void DateTime_GreaterThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', GREATER_THAN, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void DateTime_LessThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', LESS_THAN, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
    }

    @isTest
    private static void DateTime_GreaterThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', GREATER_THAN_OR_EQUAL, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void DateTime_LessThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', LESS_THAN_OR_EQUAL, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
    }

    @isTest
    private static void DateTime_IsToday() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', IS_TODAY});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addDays(-1))));
    }

    @isTest
    private static void DateTime_IsYesterday() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', IS_YESTERDAY});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
    }

    @isTest
    private static void DateTime_IsThisMonth() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', IS_THIS_MONTH});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addMonths(-1))));
    }

    @isTest
    private static void DateTime_IsThisYear() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', IS_THIS_YEAR});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addYears(1))));
    }

    @isTest
    private static void DateTime_IsFuture() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', IS_FUTURE});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(-1))));
    }

    @isTest
    private static void DateTime_IsPast() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Timestamp__c', IS_PAST});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(1))));
    }


    ////////////////////////////////////// STRING //////////////////////////////////////

    @isTest
    private static void String_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(Name=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(Name='Farva')));
    }

    @isTest
    private static void String_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name=null)));
    }

    @isTest
    private static void String_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', EQUALS, 'Shenanigans'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Farva')));
    }

    @isTest
    private static void String_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', NOT_EQUALS, 'Shenanigans'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    private static void String_Matches() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', MATCHES, 'Shen.*'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    private static void String_DoesNotMatch() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', DOES_NOT_MATCH, 'Shen.*'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    private static void String_Contains() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', CONTAINS, 'hen'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    private static void String_DoesNotContain() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', DOES_NOT_CONTAIN, 'hen'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    private static void String_StartsWith() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', STARTS_WITH, 'Shen'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    private static void String_EndsWith() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'Name', ENDS_WITH, 'gans'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }


    @isTest
    private static void InvalidField() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic(new String[] {'FullName', ENDS_WITH, 'Slartibartfast'});
        try{
            filterLogic.evaluate(new Account(Name='Shenanigans'));
            System.assert(false, 'Expected invalid field to throw a parse exception.');
        }catch(narrate_FilterLogicParseException error){
            // Expected
        }catch(Exception error){
            System.assert(false, 'Expected invalid field to throw a parse exception but received exception of type ' + error.getTypeName() + '.');
        }
    }


    @isTest
    private static void parseCloseParen(){
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{')', 'NEXT TOKEN'});
        testIter = complexFilterLogic.parseCloseParen(testIter);
        System.assertEquals('NEXT TOKEN', testIter.next(), 'Expected parseCloseParen to advance the iterator.');
        try{
            testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'MWAHAHAHA'});
            complexFilterLogic.parseCloseParen(testIter);
            System.assert(false, 'Expected invalid token to throw a parse exception.');
        }catch(narrate_FilterLogicParseException error){
            // Expected
        }catch(Exception error){
            System.assert(false, 'Expected invalid token to throw a parse exception but received exception of type ' + error.getTypeName() + '.');
        }
    }
    @isTest
    private static void parseOpenParen(){
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'(', 'NEXT TOKEN'});
        testIter = complexFilterLogic.parseOpenParen(testIter);
        System.assertEquals('NEXT TOKEN', testIter.next(), 'Expected parseOpenParen to advance the iterator.');
        try{
            testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'NARF'});
            complexFilterLogic.parseOpenParen(testIter);
            System.assert(false, 'Expected invalid token to throw a parse exception.');
        }catch(narrate_FilterLogicParseException error){
            // Expected
        }catch(Exception error){
            System.assert(false, 'Expected invalid token to throw a parse exception but received exception of type ' + error.getTypeName() + '.');
        }
    }
    @isTest
    private static void parseOperator(){
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'AND', 'NEXT TOKEN'});
        complexFilterLogic.parseOperator(testIter);
        System.assertEquals(1, complexFilterLogic.operators.size(), 'Unexpected number of Operators in the ComplexFilterLogic.');
        System.assertEquals(narrate_ComplexFilterLogic.Operator.OP_AND, complexFilterLogic.operators.get(0), 'Unexpected value for Operator.');
        System.assertEquals('NEXT TOKEN', testIter.next(), 'Expected parseOperator to advance the iterator.');
        testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'OR', 'NEXT TOKEN'});
        complexFilterLogic.parseOperator(testIter);
        System.assertEquals(2, complexFilterLogic.operators.size(), 'Unexpected number of Operators in the ComplexFilterLogic.');
        System.assertEquals(narrate_ComplexFilterLogic.Operator.OP_OR, complexFilterLogic.operators.get(1), 'Unexpected value for Operator.');
        System.assertEquals('NEXT TOKEN', testIter.next(), 'Expected parseOperator to advance the iterator.');
        try{
            testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'YARP'});
            complexFilterLogic.parseOperator(testIter);
            System.assert(false, 'Expected invalid token to throw a parse exception.');
        }catch(narrate_FilterLogicParseException error){
            // Expected
        }catch(Exception error){
            System.assert(false, 'Expected invalid token to throw a parse exception but received exception of type ' + error.getTypeName() + '.');
        }
    }
    @isTest
    private static void parseExpressionWithComparatee(){
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'Herp', '=', 'DERP', 'NEXT TOKEN'});
        testIter = complexFilterLogic.parseExpression(testIter);
        System.assertEquals(1, complexFilterLogic.filterLogics.size(), 'Unexpected number of FilterLogics in the ComplexFilterLogic.');
        narrate_SimpleFilterLogic resultNestedFilterLogic = (narrate_SimpleFilterLogic)complexFilterLogic.filterLogics.get(0);
        System.assertEquals('Herp', resultNestedFilterLogic.fieldName, 'Unexpected value for fieldName.');
        System.assertEquals('=', resultNestedFilterLogic.logic, 'Unexpected value for logic');
        System.assertEquals('DERP', resultNestedFilterLogic.whatToCompareTo, 'Unexpected value for whatToCompareTo');
        System.assertEquals('NEXT TOKEN', testIter.next(), 'Expected parseOperator to advance the iterator.');
    }
    @isTest
    private static void parseExpressionWithoutComparatee(){
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'Herp', 'IS NULL', 'NEXT TOKEN'});
        testIter = complexFilterLogic.parseExpression(testIter);
        System.assertEquals(1, complexFilterLogic.filterLogics.size(), 'Unexpected number of FilterLogics in the ComplexFilterLogic.');
        narrate_SimpleFilterLogic resultNestedFilterLogic = (narrate_SimpleFilterLogic)complexFilterLogic.filterLogics.get(0);
        System.assertEquals('Herp', resultNestedFilterLogic.fieldName, 'Unexpected value for fieldName.');
        System.assertEquals('IS NULL', resultNestedFilterLogic.logic, 'Unexpected value for logic');
        System.assertEquals(null, resultNestedFilterLogic.whatToCompareTo, 'Unexpected value for whatToCompareTo');
        System.assertEquals('NEXT TOKEN', testIter.next(), 'Expected parseOperator to advance the iterator.');
    }
    @isTest
    private static void parseInvalidExpression(){
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'Herp', 'IS NOT NULL', ')', 'NEXT TOKEN'});
        try{
            complexFilterLogic.parseOperator(testIter);
            System.assert(false, 'Expected invalid token to throw a parse exception.');
        }catch(narrate_FilterLogicParseException error){
            // Expected
        }catch(Exception error){
            System.assert(false, 'Expected invalid token to throw a parse exception but received exception of type ' + error.getTypeName() + '.');
        }
    }

    private static DateTime nowGMT() {
        return DateTime.now();
    }
    private static Date todayGMT() {
        return nowGMT().dateGMT();
    }
    private static Date testDateGMT() {
        return DateTime.newInstance(1952, 3, 11, 0, 0, 0).dateGMT();
    }
}