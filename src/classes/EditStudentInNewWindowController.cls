public class EditStudentInNewWindowController {
    Student__c student;
    public Integer flag{get;set;}
    public EditStudentInNewWindowController(ApexPages.StandardController controller) {
        student=(Student__c)controller.getRecord();
    }
    public void saveStudent(){
        try{
            update student;
            flag=0;
    
        }
        catch(DMLException e){
            flag=1;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Last Name is required field'));
        }
    }


}