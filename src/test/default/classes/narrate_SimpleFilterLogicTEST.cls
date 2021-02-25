@isTest
public class narrate_SimpleFilterLogicTEST {

    ////////////////////////////////////// BOOLEAN //////////////////////////////////////

    @isTest
    public static void Boolean_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["DoNotCall", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Contact(DoNotCall=null)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(DoNotCall=true)));
    }

    @isTest
    public static void Boolean_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["DoNotCall", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Contact(DoNotCall=true)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(DoNotCall=null)));
    }

    @isTest
    public static void Boolean_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["DoNotCall", "=", "true"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=true)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=false)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=null)));
    }

    @isTest
    public static void Boolean_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["DoNotCall", "!=", "true"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=false)));
        System.assertEquals(true, filterLogic.evaluate(new Contact(DoNotCall=null)));
        System.assertEquals(false, filterLogic.evaluate(new Contact(DoNotCall=true)));
    }


    ////////////////////////////////////// Integer //////////////////////////////////////

    @isTest
    public static void Integer_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(AnnualRevenue=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(AnnualRevenue=42)));
    }

    @isTest
    public static void Integer_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate( new Account(AnnualRevenue=null)));
    }

    @isTest
    public static void Integer_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    @isTest
    public static void Integer_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "!=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=42)));
    }

    @isTest
    public static void Integer_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", ">", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=3)));
    }

    @isTest
    public static void Integer_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "<", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=3)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    @isTest
    public static void Integer_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", ">=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=3)));
    }

    @isTest
    public static void Integer_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "<=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=3)));
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    ////////////////////////////////////// Decimal //////////////////////////////////////

    @isTest
    public static void Decimal_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(AnnualRevenue=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(AnnualRevenue=42)));
    }

    @isTest
    public static void Decimal_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate( new Account(AnnualRevenue=null)));
    }

    @isTest
    public static void Decimal_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    @isTest
    public static void Decimal_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "!=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=42)));
    }

    @isTest
    public static void Decimal_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", ">", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=3)));
    }

    @isTest
    public static void Decimal_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "<", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=3)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    @isTest
    public static void Decimal_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", ">=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=3)));
    }

    @isTest
    public static void Decimal_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["AnnualRevenue", "<=", "42"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=3)));
        System.assertEquals(true, filterLogic.evaluate(new Account(AnnualRevenue=42)));
        System.assertEquals(false, filterLogic.evaluate(new Account(AnnualRevenue=9001)));
    }

    ////////////////////////////////////// Double //////////////////////////////////////

    // Not really needed I don't think...

    ////////////////////////////////////// Date //////////////////////////////////////

    @isTest
    public static void Date_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Contact(Birthdate=null)));
        System.assertEquals(false, filterLogic.evaluate( new Contact(Birthdate=testDateGMT())));
    }

    @isTest
    public static void Date_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate( new Contact(Birthdate=null)));
    }

    @isTest
    public static void Date_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "=", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    public static void Date_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "!=", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
    }

    @isTest
    public static void Date_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", ">", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void Date_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "<", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    public static void Date_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", ">=", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void Date_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "<=", "1952-03-11"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(-42))));
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=testDateGMT().addDays(42))));
    }

    @isTest
    public static void Date_IsToday() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS TODAY"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
    }

    @isTest
    public static void Date_IsYesterday() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS YESTERDAY"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    @isTest
    public static void Date_IsThisMonth() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS THIS MONTH"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addMonths(-1))));
    }

    @isTest
    public static void Date_IsThisYear() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS THIS YEAR"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addYears(1))));
    }

    @isTest
    public static void Date_IsFuture() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS FUTURE"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    @isTest
    public static void Date_IsPast() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Birthdate", "IS PAST"]');
        System.assertEquals(true, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new Contact(Birthdate=todayGMT())));
    }

    ////////////////////////////////////// Date //////////////////////////////////////

    @isTest
    public static void DateTime_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=null)));
        System.assertEquals(false, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
    }

    @isTest
    public static void DateTime_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate( new narrate_LogEntry__c(Timestamp__c=null)));
    }

    @isTest
    public static void DateTime_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "=", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void DateTime_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "!=", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
    }

    @isTest
    public static void DateTime_GreaterThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", ">", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void DateTime_LessThan() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "<", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
    }

    @isTest
    public static void DateTime_GreaterThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", ">=", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
    }

    @isTest
    public static void DateTime_LessThanOrEqual() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "<=", "1952-03-11T00:00:00Z"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(-42))));
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=testDateGMT().addDays(42))));
    }

    @isTest
    public static void DateTime_IsToday() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS TODAY"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addDays(-1))));
    }

    @isTest
    public static void DateTime_IsYesterday() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS YESTERDAY"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
    }

    @isTest
    public static void DateTime_IsThisMonth() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS THIS MONTH"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=DateTime.now().dateGMT().addMonths(-1))));
    }

    @isTest
    public static void DateTime_IsThisYear() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS THIS YEAR"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT())));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addYears(1))));
    }

    @isTest
    public static void DateTime_IsFuture() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS FUTURE"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(-1))));
    }

    @isTest
    public static void DateTime_IsPast() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Timestamp__c", "IS PAST"]');
        System.assertEquals(true, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(-1))));
        System.assertEquals(false, filterLogic.evaluate(new narrate_LogEntry__c(Timestamp__c=nowGMT().addDays(1))));
    }


    ////////////////////////////////////// STRING //////////////////////////////////////

    @isTest
    public static void String_IsNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "IS NULL"]');
        System.assertEquals(true, filterLogic.evaluate( new Account(Name=null)));
        System.assertEquals(false, filterLogic.evaluate( new Account(Name='Farva')));
    }

    @isTest
    public static void String_IsNotNull() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "IS NOT NULL"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name=null)));
    }

    @isTest
    public static void String_Equals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "=", "Shenanigans"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Farva')));
    }

    @isTest
    public static void String_NotEquals() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "!=", "Shenanigans"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    public static void String_Matches() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "MATCHES", "Shen.*"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    public static void String_DoesNotMatch() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "DOES NOT MATCH", "Shen.*"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    public static void String_Contains() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "CONTAINS", "hen"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    public static void String_DoesNotContain() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "DOES NOT CONTAIN", "hen"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Soda')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Shenanigans')));
    }

    @isTest
    public static void String_StartsWith() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "STARTS WITH", "Shen"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
    }

    @isTest
    public static void String_EndsWith() {
        narrate_SimpleFilterLogic filterLogic = new narrate_SimpleFilterLogic();
        filterLogic.setLogic('["Name", "ENDS WITH", "gans"]');
        System.assertEquals(true, filterLogic.evaluate(new Account(Name='Shenanigans')));
        System.assertEquals(false, filterLogic.evaluate(new Account(Name='Soda')));
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
