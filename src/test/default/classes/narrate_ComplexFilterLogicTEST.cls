@isTest
public class narrate_ComplexFilterLogicTEST {

    ////////////////////////////////////// BOOLEAN //////////////////////////////////////

    @isTest
    private static void Boolean_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["DoNotCall", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Contact(DoNotCall=null)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(DoNotCall=true)));
    }

    @isTest
    private static void Boolean_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["DoNotCall", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Contact(DoNotCall=true)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(DoNotCall=null)));
    }

    @isTest
    private static void Boolean_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["DoNotCall", "=", "true"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=true)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=false)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=null)));
    }

    @isTest
    private static void Boolean_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["DoNotCall", "!=", "true"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=false)));
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=null)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=true)));
    }


    ////////////////////////////////////// Integer //////////////////////////////////////

    @isTest
    private static void Integer_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["NumberOfEmployees", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
    }

    @isTest
    private static void Integer_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["NumberOfEmployees", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate( new Account(NumberOfEmployees=null)));
    }

    @isTest
    private static void Integer_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["NumberOfEmployees", "=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    private static void Integer_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["NumberOfEmployees", "!=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
    }

    @isTest
    private static void Integer_GreaterThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["NumberOfEmployees", ">", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    private static void Integer_LessThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["NumberOfEmployees", "<", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    @isTest
    private static void Integer_GreaterThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["NumberOfEmployees", ">=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
    }

    @isTest
    private static void Integer_LessThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["NumberOfEmployees", "<=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=3)));
        System.assertEquals(true, filterLogic.evaluate(new Account(NumberOfEmployees=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(NumberOfEmployees=9001)));
    }

    ////////////////////////////////////// Decimal //////////////////////////////////////

    @isTest
    private static void Decimal_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(AnnualRevenue=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(AnnualRevenue=42)));
    }

    @isTest
    private static void Decimal_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate( new Account(AnnualRevenue=null)));
    }

    @isTest
    private static void Decimal_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    @isTest
    private static void Decimal_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "!=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=42)));
    }

    @isTest
    private static void Decimal_GreaterThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", ">", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=3)));
    }

    @isTest
    private static void Decimal_LessThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "<", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=3)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    @isTest
    private static void Decimal_GreaterThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", ">=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=3)));
    }

    @isTest
    private static void Decimal_LessThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "<=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=3)));
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    ////////////////////////////////////// Date //////////////////////////////////////

    @isTest
    private static void Date_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Contact(Birthdate=null)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(Birthdate=testDateGMT())));
    }

    @isTest
    private static void Date_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate( new Contact(Birthdate=null)));
    }

    @isTest
    private static void Date_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "=", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    private static void Date_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "!=", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
    }

    @isTest
    private static void Date_GreaterThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", ">", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void Date_LessThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "<", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    private static void Date_GreaterThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", ">=", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void Date_LessThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "<=", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    private static void Date_IsToday() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS TODAY"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
    }

    @isTest
    private static void Date_IsYesterday() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS YESTERDAY"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    @isTest
    private static void Date_IsThisMonth() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS THIS MONTH"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addMonths(-1))));
    }

    @isTest
    private static void Date_IsThisYear() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS THIS YEAR"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addYears(1))));
    }

    @isTest
    private static void Date_IsFuture() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS FUTURE"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    @isTest
    private static void Date_IsPast() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS PAST"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    ////////////////////////////////////// Date //////////////////////////////////////

    @isTest
    private static void DateTime_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=null)));
        System.assertEquals(false, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
    }

    @isTest
    private static void DateTime_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=null)));
    }

    @isTest
    private static void DateTime_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "=", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void DateTime_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "!=", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
    }

    @isTest
    private static void DateTime_GreaterThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", ">", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void DateTime_LessThan() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "<", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
    }

    @isTest
    private static void DateTime_GreaterThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", ">=", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    private static void DateTime_LessThanOrEqual() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "<=", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
    }

    @isTest
    private static void DateTime_IsToday() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS TODAY"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addDays(-1))));
    }

    @isTest
    private static void DateTime_IsYesterday() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS YESTERDAY"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
    }

    @isTest
    private static void DateTime_IsThisMonth() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS THIS MONTH"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addMonths(-1))));
    }

    @isTest
    private static void DateTime_IsThisYear() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS THIS YEAR"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addYears(1))));
    }

    @isTest
    private static void DateTime_IsFuture() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS FUTURE"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(-1))));
    }

    @isTest
    private static void DateTime_IsPast() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS PAST"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(1))));
    }


    ////////////////////////////////////// STRING //////////////////////////////////////

    @isTest
    private static void String_IsNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(Name=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(Name='Farva')));
    }

    @isTest
    private static void String_IsNotNull() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name=null)));
    }

    @isTest
    private static void String_Equals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "=", "Shenanigans"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Farva')));
    }

    @isTest
    private static void String_NotEquals() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "!=", "Shenanigans"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    private static void String_Matches() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "MATCHES", "Shen.*"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    private static void String_DoesNotMatch() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "DOES NOT MATCH", "Shen.*"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    private static void String_Contains() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "CONTAINS", "hen"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    private static void String_DoesNotContain() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "DOES NOT CONTAIN", "hen"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    private static void String_StartsWith() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "STARTS WITH", "Shen"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    private static void String_EndsWith() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["Name", "ENDS WITH", "gans"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }


    @isTest
    private static void InvalidField() {
        narrate_ComplexFilterLogic filterLogic = new narrate_ComplexFilterLogic();
        filterLogic.setLogic('["FullName", "ENDS WITH", "Slartibartfast"]');
        try{
            filterLogic.evaluate(new Account(Name='Shenanigans'));
            System.assert(false, 'Expected invalid field to throw a parse exception.');
        }catch(narrate_InvalidFieldException error){
            // Expected
        }catch(Exception error){
            System.assert(false, 'Expected invalid field to throw a parse exception but received exception of type ' + error.getTypeName() + '.');
        }
    }


    @isTest
    private static void parseCloseParen(){
        String[] testExpression = new String[]{')'};
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(testExpression);
        testIter = complexFilterLogic.parseCloseParen(testIter);
        if(testIter.hasNext()){
            System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.next());
        }
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
        String[] testExpression = new String[]{'('};
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(testExpression);
        testIter = complexFilterLogic.parseOpenParen(testIter);
        if(testIter.hasNext()){
            System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.next());
        }
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
        String[] testExpression = new String[]{'AND'};
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(testExpression);
        complexFilterLogic.parseOperator(testIter);
        System.assertEquals(1, complexFilterLogic.operators.size(), 'Unexpected number of Operators in the ComplexFilterLogic.');
        System.assertEquals(narrate_ComplexFilterLogic.Operator.OP_AND, complexFilterLogic.operators.get(0), 'Unexpected value for Operator.');
        if(testIter.hasNext()){
            System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.next());
        }
        testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'OR'});
        complexFilterLogic.parseOperator(testIter);
        System.assertEquals(2, complexFilterLogic.operators.size(), 'Unexpected number of Operators in the ComplexFilterLogic.');
        System.assertEquals(narrate_ComplexFilterLogic.Operator.OP_OR, complexFilterLogic.operators.get(1), 'Unexpected value for Operator.');
        if(testIter.hasNext()){
            System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.next());
        }
        testIter = new narrate_ComplexFilterLogic.PeekIterator(new String[]{'XOR'});
        complexFilterLogic.parseOperator(testIter);
        System.assertEquals(3, complexFilterLogic.operators.size(), 'Unexpected number of Operators in the ComplexFilterLogic.');
        System.assertEquals(narrate_ComplexFilterLogic.Operator.OP_XOR, complexFilterLogic.operators.get(1), 'Unexpected value for Operator.');
        if(testIter.hasNext()){
            System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.next());
        }
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
    private static void parseSimpleExpressionWithComparatee(){
        String[] testExpression = new String[]{'Herp', '=', 'DERP'};
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(testExpression);
        testIter = complexFilterLogic.parseExpression(testIter);
        System.assertEquals(1, complexFilterLogic.filterLogics.size(), 'Unexpected number of FilterLogics in the ComplexFilterLogic.');
        narrate_SimpleFilterLogic resultNestedFilterLogic = (narrate_SimpleFilterLogic)complexFilterLogic.filterLogics.get(0);
        System.assertEquals('Herp', resultNestedFilterLogic.fieldName, 'Unexpected value for fieldName.');
        System.assertEquals('=', resultNestedFilterLogic.logic, 'Unexpected value for logic');
        System.assertEquals('DERP', resultNestedFilterLogic.whatToCompareTo, 'Unexpected value for whatToCompareTo');
        if(testIter.hasNext()){
            System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.next());
        }
    }
    @isTest
    private static void parseSimpleExpressionWithoutComparatee(){
        String[] testExpression = new String[]{'Herp', 'IS NULL'};
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(testExpression);
        testIter = complexFilterLogic.parseExpression(testIter);
        System.assertEquals(1, complexFilterLogic.filterLogics.size(), 'Unexpected number of FilterLogics in the ComplexFilterLogic.');
        narrate_SimpleFilterLogic resultNestedFilterLogic = (narrate_SimpleFilterLogic)complexFilterLogic.filterLogics.get(0);
        System.assertEquals('Herp', resultNestedFilterLogic.fieldName, 'Unexpected value for fieldName.');
        System.assertEquals('IS NULL', resultNestedFilterLogic.logic, 'Unexpected value for logic');
        System.assertEquals(null, resultNestedFilterLogic.whatToCompareTo, 'Unexpected value for whatToCompareTo');
        if(testIter.hasNext()){
            System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.next());
        }
    }
    @isTest
    private static void parseInvalidExpression(){
        String[] testExpression = new String[]{'Herp', 'IS NOT NULL', ')', 'NEXT TOKEN'};
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(testExpression);
        try{
            complexFilterLogic.parseOperator(testIter);
            System.assert(false, 'Expected invalid token to throw a parse exception.');
        }catch(narrate_FilterLogicParseException error){
            // Expected
        }catch(Exception error){
            System.assert(false, 'Expected invalid token to throw a parse exception but received exception of type ' + error.getTypeName() + '.');
        }
    }


    @isTest
    private static void parseExpressionWithOperator(){
        String[] testExpression = new String[]{'Herp', '>=', '1000', 'AND', 'Derp', 'IS NOT NULL'};
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(testExpression);
        try{
            complexFilterLogic.parseExpression(testIter);
            complexFilterLogic.parseOperator(testIter);
            complexFilterLogic.parseExpression(testIter);
            if(testIter.hasNext()){
                System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.next());
            }
        }catch(Exception error){
            System.debug(error.getStackTraceString());
            System.assert(false, 'Unknown Exception thrown: ' + error.getMessage());
        }
    }

    @isTest
    private static void parseExpressionWithNestedExpressionOperator(){
        String[] testExpression = new String[]{'Herp', '>=', '1000', 'AND', '(', 'Derp', 'IS NULL', 'OR', 'Derp', '=', '42', ')'};
        narrate_ComplexFilterLogic complexFilterLogic = new narrate_ComplexFilterLogic();
        narrate_ComplexFilterLogic.PeekIterator testIter = new narrate_ComplexFilterLogic.PeekIterator(testExpression);
        try{
            complexFilterLogic.parseExpression(testIter);
            complexFilterLogic.parseOperator(testIter);
            complexFilterLogic.parseNestedFilter(testIter);
            if(testIter.hasNext()){
                System.assert(false, 'Expected Iterator to reach end of input, instead found: ' + testIter.peek());
            }
        }catch(Exception error){
            System.debug(error.getStackTraceString());
            System.assert(false, 'Unknown Exception thrown: ' + error.getMessage());
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