public class AccountsPortalController {

    public List<AccountsWrapper> accList{get;set;}
    public List<Contact> relatedContactList{get;set;} 

    public AccountsPortalController() {
    
        try {
            accList = new List<AccountsWrapper>();
            relatedContactList = new List<Contact>();
            
            List<Account> accountList = [Select Name from Account Limit 10];
            
            AccountsWrapper accWrp;
            for(Account acc : accountList) { 
                accWrp = new AccountsWrapper(acc);
                accList.add(accWrp);
            }
        } catch(Exception e) {
            System.debug('Exception has occured' + e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Some error occured'));
        } 
        
    }
    
    public class AccountsWrapper {
    
        public Account a{get;set;} 
        public Boolean isChecked{get;set;}
        
        public AccountsWrapper(Account a) {
            this.a = a;
            isChecked = false;
        }
        
    }
    
    public void populateContactList() {
    
        try {
            Set<ID> accountIds = new Set<ID>();
            
            for(AccountsWrapper acc : accList) {
                if(acc.isChecked) {
                   accountIds.add(acc.a.Id); 
                }
            }
            
            relatedContactList = [Select Name from Contact where AccountId in : accountIds];
        } catch(Exception e) {
            System.debug('Exception has occured' + e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Some error occured'));

        }

    }
    


}