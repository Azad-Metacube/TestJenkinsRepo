public class AccountController {
    private Account acct;
     
    public AccountController(ApexPages.StandardController controller) {  
        this.acct = (Account)controller.getRecord();
    }
   
     public PageReference saveAccount() {   
        try{
             upsert acct;
             return new PageReference('/apex/AccountDetail?id='+acct.Id+'&sfdc.override=1');
        }
        catch(DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
            return null;
        }
    }
    
    public PageReference CancelAccount() {
        String accountId=ApexPages.currentPage().getParameters().get('AccountId');
        if(acct.Id != null)
            return new PageReference('/'+acct.Id);
        else if(accountId != null)
            return new PageReference('/'+accountId );
        else
            return new PageReference('/001/o');
    }
    
    public PageReference saveAndNew() {
        try{
            upsert acct;
            PageReference pg = new PageReference('/apex/CustomAccount?retURL=%2F001%2Fo&save_new=1&sfdc.override=1&AccountId='+acct.Id);
            pg.setRedirect(true);
            return pg;        }
        catch(DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
            return null;
        }
    }
}