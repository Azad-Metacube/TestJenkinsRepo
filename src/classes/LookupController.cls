public with sharing class LookupController 
{

    public String getRunQuery() {
        return null;
    }

    public String query {get; set;}
    Public Integer size{get{return 10;} set;}
    Public Integer noOfRecords{get; set;}
    public List<Account> accounts {
        get{
            return setCon.getRecords();
        }set;}
    
    public LookupController(){
        query = ApexPages.currentPage().getParameters().get('accName');
        String str;
            if(query.startsWith('*') || query.startsWith('%')){
                str='%'+query.substring(1);
            }else if(query.endsWith('*') || query.endsWith('%')){
                Integer querylength=query.length();
                str=query.substring(0,querylength-1)+'%';
            }else{
                str='%'+query+'%';
            }   
            
            str = String.escapeSingleQuotes(str);
        String queryAccounts;
        queryAccounts = 'Select a.Id,a.Name,a.BillingState, a.BillingPostalCode,a.BillingStreet, a.BillingCity From Account a where a.Name like '+'\''+ str +'\'';
        setCon = new ApexPages.StandardSetController(Database.query(queryAccounts));
        setCon.setPageSize(size);
        noOfRecords = setCon.getResultSize();           
    }
    
    public PageReference runQuery(){
        String str;
            if(query.startsWith('*') || query.startsWith('%')){
                str='%'+query.substring(1);
            }else if(query.endsWith('*') || query.endsWith('%')){
                Integer querylength=query.length();
                str=query.substring(0,querylength-1)+'%';
            }else{
                str='%'+query+'%';
            }
        String queryAccounts;
        queryAccounts = 'Select a.Id,a.Name,a.BillingState, a.BillingPostalCode,a.BillingStreet, a.BillingCity From Account a where a.Name like '+'\''+ str +'\'';
        setCon = new ApexPages.StandardSetController(Database.query(queryAccounts));
        setCon.setPageSize(size);
        noOfRecords = setCon.getResultSize();
        return null;
    }   
    public ApexPages.StandardSetController setCon {
       get{           
           if(setCon == null){
               size = 10;
               try{
                   ApexPages.getMessages().clear();
                   if(accounts!=null){
                       setCon = new ApexPages.StandardSetController(accounts);
                   }
                   if(setCon!=null){
                       setCon.setPageSize(size);
                       noOfRecords = setCon.getResultSize();
                   }
               }catch(Exception e){
                   
               }
           }
           return setCon;
       }set;
   }
   public Boolean hasNext {
       get {
           return setCon.getHasNext();
       }
       set;
   }
   public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
   }
  
   public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
    
    public void first() {
        setCon.first();
    }
    
    public void last() {
        setCon.last();
    }
  
    public void previous() {
        setCon.previous();
    }
  
    public void next() {
        setCon.next();
    }
    
}