public class AccountHomeController {

    public List<Account> accounts{get;set;}
    public List<Account> accountViewList{get;set;}
    public boolean flag{get;set;}
    public String viewMode{get;set;}
    public String selectedMode{get;set;}
    public String accountId{get;set;}
    public boolean displayPopup {get; set;}
    public boolean view{get;set;}
    public boolean hasPrevious{get;set;}   
    public boolean hasNext{get;set;}  
    public List<SelectOption> selectMode{
        get{
             List<SelectOption> selectionMode= new List<SelectOption>();
             selectionMode.add(new SelectOption('1','Recently Created'));
             selectionMode.add(new SelectOption('2','Recently Modified'));
             selectionMode.add(new SelectOption('3','Recently Viewed'));
             return selectionMode; 
        }
        set;
    }
    
    public List<SelectOption> viewModeOptions{
        get{
             List<SelectOption> options = new List<SelectOption>();
             options.add(new SelectOption('1','All Accounts'));
             options.add(new SelectOption('2','My Accounts'));
             options.add(new SelectOption('3','New Last Week'));
             options.add(new SelectOption('4','New This Week'));
             options.add(new SelectOption('5','Platinum and Gold SLA Customers'));
             options.add(new SelectOption('6','Recently Viewed Accounts'));
             return options; 
        }
        set;
    }
    
    
    public AccountHomeController(ApexPages.StandardController controller) {
        flag=true;
        accounts=[Select a.Name,a.Id, a.BillingCity, a.Phone From Account a order by a.CreatedDate desc limit 25];
    }
    
    public void selectMode(){
        if(selectedMode == '1'){
            accounts=[Select a.Name, a.BillingCity, a.Phone From Account a order by a.CreatedDate desc limit 25];
        }
        else if(selectedMode == '2'){
            accounts=[Select a.Name,a.BillingCity,a.Phone From Account a order by a.LastModifiedDate desc limit 25];
        }
        else if(selectedMode == '3'){
            accounts=[Select a.Name, a.BillingCity, a.Phone From Account a order by a.LastViewedDate desc limit 25];
        }
    }
    
    public void viewAccount(){
        view=true;
        flag=false;
        if(viewMode=='1'){
            accountViewList=[Select a.Name, a.Site, a.BillingState,a.Phone,  a.Type, a.Owner.Alias From Account a limit 100];    
        }
        else if(viewMode=='2'){
            String currentId= UserInfo.getUserId();
            accountViewList= [Select a.Name,a.Id, a.Site, a.BillingState,a.Phone,  a.Type, a.Owner.Alias From Account a where a.CreatedById= :currentId limit 100];
        }
        else if(viewMode=='3'){
            accountViewList= [Select a.Name,a.Id, a.Site, a.BillingState,a.Phone,  a.Type, a.Owner.Alias From Account a where a.CreatedDate = LAST_WEEK ORDER BY CreatedDate DESC limit 100];     
        }
        else if(viewMode=='4'){
            accountViewList=[Select a.Name,a.Id, a.Site, a.BillingState,a.Phone,  a.Type, a.Owner.Alias From Account a where a.CreatedDate > LAST_WEEK ORDER BY CreatedDate DESC limit 100];
        }
        else if(viewMode=='5'){
        }
        else if(viewMode=='6'){
            accountViewList=[Select a.Name,a.Id, a.Site, a.BillingState,a.Phone,  a.Type, a.Owner.Alias From Account a order by a.LastViewedDate desc limit 100];
        }
    }
    
    
    public PageReference newViewLink(){
       accounts=[Select a.Name, a.BillingCity, a.Phone From Account a order by a.CreatedDate desc];
        return new PageReference ('https://ap1.salesforce.com/ui/list/FilterEditPage?ftype=a&retURL=%2F001&cancelURL=%2F001%2Fo');
   
    }

     public PageReference editViewLink(){
  
        return new PageReference ('https://ap1.salesforce.com/ui/list/FilterEditPage?id=00B90000006EdfI&retURL=%2F001&cancelURL=%2F001%2Fo');
   
    }
    
    public PageReference createNewAccount(){
        return new PageReference ('https://c.ap1.visual.force.com/apex/CustomAccount?retURL=%2F001%2Fo&save_new=1&sfdc.override=1');
    }
    
    public PageReference detailLink(){
       // system.assertEquals('false',accountId);
        return new PageReference ('https://ap1.salesforce.com/'+accountId);
    }
    
    public void showPopup() {        
        displayPopup = true;    
    }
    public void canceldeletion() {
        displayPopup =false;
    }
     public PageReference deleteClass() {
        displayPopup =false;
        List<Account> deleteAccount = [Select a.Name From Account a where a.Id =: accountId]; 
        try{
        delete deleteAccount ;
        }
        catch(DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
        }
        
        return null;
    }
   
}