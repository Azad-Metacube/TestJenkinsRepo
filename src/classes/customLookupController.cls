public class customLookupController {
    
    public List<String> names{get;set;}
    public string selectedContact{get;set;} 
    public List<Contact> contacts{get;set;}
    public Opportunity opp{get;set;}
   
    public List<SelectOption> teachers{
        get{
            List<SelectOption> options = new List<SelectOption>(); 
            for(Contact tempContact: contacts) {
                options.add(new SelectOption(tempContact.Id, tempContact.Name)); 
            }
            return options; 
        }
        set;
    }
    
    public customLookupController(){
        opp = [Select o.Manager__c, o.BillToContact__c, o.Amount From Opportunity o where o.Id = :ApexPages.currentPage().getParameters().get('Id')];
        contacts = [Select c.Name From Contact c where AccountId = :opp.Manager__c];
        
    } 
           
    
    public pageReference save(){
        opp.BillToContact__c = selectedContact;
        update opp;
        return new ApexPages.StandardController(opp).view();    
    }
    
    public pageReference cancel(){
        return new ApexPages.StandardController(opp).view();
    }
    
    public pageReference clear(){
       opp.BillToContact__c = null;
       update opp;
       return new ApexPages.StandardController(opp).view();
    }
    
}