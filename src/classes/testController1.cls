public class testController1{

    public static void testMethod1() { 
        Account acc = [select Id from Account limit 1];
        Contact con = [select Id from Contact limit 1];
        Opportunity opp = [select Id from Opportunity  limit 1];
    }
}