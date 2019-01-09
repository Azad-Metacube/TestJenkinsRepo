public class MyAccountDetail{
    public Account account{get;set;}
    public MyAccountDetail(){
        account = [Select a.Name, a.Id, a.BillingStreet, a.BillingPostalCode, a.BillingCity From Account a where a.Id = '0019000000nYKFo'];
        System.assert(false,account);
    }
}