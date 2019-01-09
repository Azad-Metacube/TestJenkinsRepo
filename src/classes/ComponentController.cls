public class ComponentController {
  
    public Integer flag{get;set;}
    public String cName{get;set;}
    Public Integer size{get{return 10;} set;}
    Public Integer noOfRecords{get; set;}
   
    public PageReference Sorting() {
        soqlQuery.toLowerCase();
        if(flag==0){
            flag=1;
            if(soqlQuery.contains('limit')){
                soqlQuery=soqlQuery.substringBefore('limit')+' order by '+cName+' asc nulls last limit'+soqlQuery.substringAfter('limit');
            }else{
                soqlQuery+=' order by '+cName+' asc nulls last';
            }
        }else{
            flag=0;
            if(soqlQuery.contains('limit')){
                soqlQuery=soqlQuery.substringBefore('limit')+' order by '+cName+' desc nulls last limit'+soqlQuery.substringAfter('limit');
            }else{
                soqlQuery+=' order by '+cName+' desc nulls last';
            }
        }
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(soqlQuery));
        setCon.setPageSize(size);
        noOfRecords = setCon.getResultSize();
        return null;
    }

    public String soqlQuery{
        get{
            return soqlQuery;
        }set;
    }
    
    public List<SObject> sList{
        get{
            sList= new List<SObject>();
            if(soqlQuery!=null){
                try{
                    ApexPages.getMessages().clear();
                    for(SObject a : (List<SObject>)setCon.getRecords()){
                        sList.add(a);
                    }
                }catch(Exception e){
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,e.getMessage()));  
                }
            }
            return sList;
        }set;
    }
  
    public List<String> columnName{
        get{
            try{
                ApexPages.getMessages().clear();
                columnName=new List<String>();
                List<String> colName;
                if(soqlQuery!=null){
                    String subSoql=soqlQuery.toLowerCase().substringBetween('select','from');
                    colName=subSoql.split(',');
                    for(String temp:colName){
                        if(temp.contains('.')){
                            temp=temp.substringAfter('.');
                        }
                        columnName.add(temp.trim().Capitalize()); 
                    }
                }
            }catch(Exception e){
             	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,e.getMessage()));  
            }
            return columnName;
        }set;
    }

    public ApexPages.StandardSetController setCon {
       get{           
           if(setCon == null){
               size = 10;
               flag=0;
               try{
                   ApexPages.getMessages().clear();
                   if(soqlQuery!=null){
                       setCon = new ApexPages.StandardSetController(Database.getQueryLocator(soqlQuery));
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