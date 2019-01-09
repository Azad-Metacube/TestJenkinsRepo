public class Pagination {
    public String filter3 { get; set; }

    public String filter2 { get; set; }

    public String filter1 { get; set; }
    
    public boolean flag=false;


    public ApexPages.StandardSetController con {
        get {
            if(con==null){
               con = new ApexPages.StandardSetController(Database.getQueryLocator([Select a.Name, a.Phone From Account a where a.BillingCity =:filter1 and a.BillingState =:filter2 and a.BillingCountry =:filter3 ]));
                // sets the number of records in each page set
                con.setPageSize(10); 
                
               // flag=false;
            }
            return con;
            
        }
        set;
    }
    
    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
 
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
 
    public void previous() {
        con.previous();
    }
 
    // returns the next page of records
    public void next() {
        con.next();
    }
    public List<Account> getRecord{
        get{
             getRecord = con.getRecords();
             flag=true;
             return getRecord;
        }
        private set;
    }
    
    public pagereference searchAccounts(){
        con = null;
        return null;
    }
    

}