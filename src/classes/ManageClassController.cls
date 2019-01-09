public class ManageClassController {

    public String Name{get;set;}
    public Decimal NumberOfStudent{get;set;}
    public Decimal MyCount{get;set;}
    public Decimal MaxSize{get;set;}
    public String DetailedDescription{get;set;}
    public String Contact{get;set;}
    public String Board{get;set;}
    public Decimal fee{get;set;}
    private List<Class__c> tempclass{get;set;}

    public String classId{get;set;}
    public boolean displayPopup {get; set;}
    public boolean isdelete;
    
    public ManageClassController (){
       
    }

    public PageReference editClass() {
        classId=apexpages.currentpage().getparameters().get('classId');
        tempclass=[Select c.fee__c, c.NumberOfStudents__c, c.Name__c, c.MyCount__c, c.MaxSize__c, c.DetailedDescription__c, c.Contact__c, c.Board__c From Class__c c where c.Id =: classId ];      
        Name = tempclass[0].Name__c;
        NumberOfStudent = tempclass[0].NumberOfStudents__c;
        MyCount = tempclass[0].MyCount__c;
        MaxSize = tempclass[0].MaxSize__c ;
        DetailedDescription = tempclass[0].DetailedDescription__c;
        Contact = tempclass[0].Contact__c;
        Board = tempclass[0].Board__c;
        fee = tempclass[0].fee__c;
     return  null;
    }
   
    public List<Class__c> getClassList(){
        List<Class__c> classList=[Select c.Name, c.Id From Class__c c limit 100];
        return classList;
    }
    
      public PageReference cancel() {
          classId=null;
          return null;
    }


    public PageReference save() {
        tempclass[0].Name__c=Name;
        tempclass[0].MyCount__c = MyCount;
        tempclass[0].MaxSize__c = MaxSize;
        tempclass[0].DetailedDescription__c = DetailedDescription;
        tempclass[0].fee__c =  fee;
        update tempclass;
        classId=null;
        return null;
        
    }
    
    public PageReference deleteClass() {
        displayPopup =false;
        List<Class__c> deleteClass = [Select c.Name From Class__c c where c.Id =: classId]; 
        delete deleteClass ;
        return null;
    }         
    public void showPopup() {        
        displayPopup = true;    
    }
    public void canceldeletion() {
        displayPopup =false;
    }


}