@isTest
public class narrate_SimpleFilterLogicTEST {
    
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
    public static void Boolean_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'DoNotCall', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Contact(DoNotCall=null)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(DoNotCall=true)));
    }

    @isTest
    public static void Boolean_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'DoNotCall', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Contact(DoNotCall=true)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(DoNotCall=null)));
    }

    @isTest
    public static void Boolean_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'DoNotCall', EQUALS, 'true'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=true)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=false)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=null)));
    }

    @isTest
    public static void Boolean_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'DoNotCall', NOT_EQUALS, 'true'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=false)));
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=null)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=true)));
    }


    ////////////////////////////////////// Integer //////////////////////////////////////

    @isTest
    public static void Integer_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
    }

    @isTest
    public static void Integer_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
    }

    @isTest
    public static void Integer_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', EQUALS, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    public static void Integer_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', NOT_EQUALS, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
    }

    @isTest
    public static void Integer_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', GREATER_THAN, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    public static void Integer_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', LESS_THAN, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    public static void Integer_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', GREATER_THAN_OR_EQUAL, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    public static void Integer_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', LESS_THAN_OR_EQUAL, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    ////////////////////////////////////// Decimal //////////////////////////////////////

    @isTest
    public static void Decimal_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
    }

    @isTest
    public static void Decimal_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
    }

    @isTest
    public static void Decimal_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', EQUALS, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    public static void Decimal_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', NOT_EQUALS, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
    }

    @isTest
    public static void Decimal_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', GREATER_THAN, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    public static void Decimal_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', LESS_THAN, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    public static void Decimal_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', GREATER_THAN_OR_EQUAL, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    public static void Decimal_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'NumberOfEmployees', LESS_THAN_OR_EQUAL, '42'});
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    ////////////////////////////////////// Double //////////////////////////////////////

    @isTest
    public static void Double_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Amount', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Opportunity(Amount=null)));
        System.assertEquals(false, filterLogic.evaluate( new Opportunity(Amount=422.42)));
    }

    @isTest
    public static void Double_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Amount', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Opportunity(Amount=422.42)));
        System.assertEquals(false, filterLogic.evaluate( new Opportunity(Amount=null)));
    }

    @isTest
    public static void Double_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Amount', EQUALS, '422.42'});
        System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=422.42)));
        System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    }

    @isTest
    public static void Double_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Amount', NOT_EQUALS, '422.42'});
        System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
        System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=422.42)));
    }

    @isTest
    public static void Double_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Amount', GREATER_THAN, '422.42'});
        System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
        System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=3.00)));
    }

    @isTest
    public static void Double_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Amount', LESS_THAN, '422.42'});
        System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=3.00)));
        System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    }

    @isTest
    public static void Double_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Amount', GREATER_THAN_OR_EQUAL, '422.42'});
        System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
        System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=422.42)));
        System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=3.00)));
    }

    @isTest
    public static void Double_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Amount', LESS_THAN_OR_EQUAL, '422.42'});
        System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=3.00)));
        System.assertEquals(true, filterLogic.evaluate(new Opportunity(Amount=422.42)));
        System.assertEquals(false, filterLogic.evaluate(new Opportunity(Amount=9001.00)));
    }

    ////////////////////////////////////// Date //////////////////////////////////////

    @isTest
    public static void Date_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Contact(Birthdate=null)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(Birthdate=testDateGMT())));
    }

    @isTest
    public static void Date_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate( new Contact(Birthdate=null)));
    }

    @isTest
    public static void Date_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', EQUALS, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    public static void Date_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', NOT_EQUALS, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
    }

    @isTest
    public static void Date_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', GREATER_THAN, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void Date_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', LESS_THAN, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    public static void Date_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', GREATER_THAN_OR_EQUAL, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void Date_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', LESS_THAN_OR_EQUAL, '1952-03-11'});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    public static void Date_IsToday() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', IS_TODAY});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
    }

    @isTest
    public static void Date_IsYesterday() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', IS_YESTERDAY});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    @isTest
    public static void Date_IsThisMonth() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', IS_THIS_MONTH});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addMonths(-1))));
    }

    @isTest
    public static void Date_IsThisYear() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', IS_THIS_YEAR});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addYears(1))));
    }

    @isTest
    public static void Date_IsFuture() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', IS_FUTURE});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    @isTest
    public static void Date_IsPast() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Birthdate', IS_PAST});
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    ////////////////////////////////////// Date //////////////////////////////////////

    @isTest
    public static void DateTime_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new narrate_LogEntry__c(narrate_Timestamp__c=null)));
        System.assertEquals(false, filterLogic.evaluate( new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT())));
    }

    @isTest
    public static void DateTime_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate( new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate( new narrate_LogEntry__c(narrate_Timestamp__c=null)));
    }

    @isTest
    public static void DateTime_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', EQUALS, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void DateTime_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', NOT_EQUALS, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT())));
    }

    @isTest
    public static void DateTime_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', GREATER_THAN, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void DateTime_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', LESS_THAN, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(-42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(42))));
    }

    @isTest
    public static void DateTime_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', GREATER_THAN_OR_EQUAL, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void DateTime_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', LESS_THAN_OR_EQUAL, '1952-03-11T00:00:00Z'});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(-42))));
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=testDateGMT().addDays(42))));
    }

    @isTest
    public static void DateTime_IsToday() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', IS_TODAY});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=DateTime.now().dateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=DateTime.now().dateGMT().addDays(-1))));
    }

    @isTest
    public static void DateTime_IsYesterday() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', IS_YESTERDAY});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=DateTime.now().dateGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=DateTime.now().dateGMT())));
    }

    @isTest
    public static void DateTime_IsThisMonth() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', IS_THIS_MONTH});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=DateTime.now().dateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=DateTime.now().dateGMT().addMonths(-1))));
    }

    @isTest
    public static void DateTime_IsThisYear() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', IS_THIS_YEAR});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=nowGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=nowGMT().addYears(1))));
    }

    @isTest
    public static void DateTime_IsFuture() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', IS_FUTURE});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=nowGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=nowGMT().addDays(-1))));
    }

    @isTest
    public static void DateTime_IsPast() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'narrate_Timestamp__c', IS_PAST});
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=nowGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(narrate_Timestamp__c=nowGMT().addDays(1))));
    }


    ////////////////////////////////////// STRING //////////////////////////////////////

    @isTest
    public static void String_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', IS_NULL});
        System.assertEquals(true, filterLogic.evaluate( new Account(Name=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(Name='Farva')));
    }

    @isTest
    public static void String_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', IS_NOT_NULL});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name=null)));
    }

    @isTest
    public static void String_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', EQUALS, 'Shenanigans'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Farva')));
    }

    @isTest
    public static void String_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', NOT_EQUALS, 'Shenanigans'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    public static void String_Matches() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', MATCHES, 'Shen.*'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    public static void String_DoesNotMatch() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', DOES_NOT_MATCH, 'Shen.*'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    public static void String_Contains() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', CONTAINS, 'hen'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    public static void String_DoesNotContain() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', DOES_NOT_CONTAIN, 'hen'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    public static void String_StartsWith() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', STARTS_WITH, 'Shen'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    public static void String_EndsWith() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'Name', ENDS_WITH, 'gans'});
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }


    @isTest
    public static void InvalidField() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic(new String[] {'FullName', ENDS_WITH, 'Slartibartfast'});
        System.assertEquals(null, filterLogic.evaluate(new Account(Name='Shenanigans')));
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
