public class AccountDetailController {

    public Account account{get;set;}
    public String createdBy{get;set;}
    public String modifiedBy{get;set;}
    public List<Contact> contactList{get;set;}
    public List<Opportunity> oList{get;set;}
    private String ID;
    public String contactId{get;set;}
    public String opportunityId{get;set;}
    
    public AccountDetailController(ApexPages.StandardController controller) {
        ID=ApexPages.currentPage().getParameters().get('Id');
        if(ID!=null){
            List<Account> accountList = [Select a.ParentId , a.LastModifiedBy.Name, a.LastModifiedById, a.CreatedById , a.Website, a.UpsellOpportunity__c, a.Type, a.TickerSymbol, a.Site, a.Sic, a.ShippingStreet, a.ShippingState, a.ShippingPostalCode, a.ShippingCountry, a.ShippingCity, a.SLA__c, a.SLASerialNumber__c, a.SLAExpirationDate__c, a.Rating, a.Phone, a.Ownership, a.Owner.Name,a.OwnerId ,  a.NumberofLocations__c, a.NumberOfEmployees, a.Name, a.LastModifiedDate, a.Industry, a.Fax, a.Description, a.CustomerPriority__c, a.CreatedBy.Name, a.CreatedDate, a.ContactIDs__c, a.BillingStreet, a.BillingState, a.BillingPostalCode, a.BillingCountry, a.BillingCity, a.AnnualRevenue, a.Active__c, a.AccountNumber From Account a where Id =:ID ];
            if(accountList.size() > 0) {
                account = accountList[0];
            contactList=[Select c.Title, c.Phone, c.Name, c.Email, c.Id From Contact c where AccountId =: ID ];
            oList=[Select o.StageName, o.Name, o.CloseDate, o.Amount From Opportunity o where o.AccountId =: ID ];
            }
        }    
    }
    
    public PageReference editAccount(){
        return new PageReference ('/apex/CustomAccount?retURL=%2F'+ID+'AAI&scontrolCaching=1&sfdc.override=1&id='+ID);
    }
    
    public PageReference deleteAccount(){
         try{
             delete account;
         } 
         catch(DMLException e){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
         }
         return new PageReference ('/001/o'); 
    }
    
    public PageReference contactLink(){
        return new PageReference('/apex/teacherRecord?id='+contactId+'&sfdc.override=1');     
    }
    
    public PageReference newContact(){
        return new PageReference('/setup/ui/recordtypeselect.jsp?ent=Contact&retURL=%2F'+ID+'&save_new_url=%2F003%2Fe%3FretURL%3D%252F'+ID+'%26accid%3D'+ID);     
    }
    
    public PageReference editContactLink(){
        return new PageReference('/'+contactId+'/e?retURL=%2F'+ID);     
    }
    
    public PageReference deleteContact(){
        Contact tempContact=[select c.Name from Contact c where c.Id =: contactId];
        try{
            delete tempContact;
        }
        catch(DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
        }
        return new PageReference('/'+ID);  
    }
    
    public PageReference creatorProfileLink(){
        return new PageReference('/_ui/core/userprofile/UserProfilePage?u='+account.CreatedById +'&tab=sfdc.ProfilePlatformFeed'); 
    }
    
    public PageReference modifierProfileLink(){
        return new PageReference('/_ui/core/userprofile/UserProfilePage?u='+account.LastModifiedById +'&tab=sfdc.ProfilePlatformFeed'); 
    }
    
    public PageReference newOpportunity(){
        return new PageReference('/006/e?retURL=%2F'+ID+'&accid='+ID);     
    }
    
    public PageReference editOpportunityLink(){
        return new PageReference('/'+opportunityId+'/e?retURL=%2F'+ID);     
    }
    
    public PageReference deleteOpportunity(){
        Opportunity tempOpportunity=[select o.Name from Opportunity o where o.Id =: opportunityId];
        try{
            delete tempOpportunity;
        }
        catch(DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
        }
        return new PageReference('/'+ID);  
    }
    
    public PageReference opportunityLink(){
        return new PageReference('/'+opportunityId);     
    }
    
}