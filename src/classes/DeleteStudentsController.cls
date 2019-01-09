public class DeleteStudentsController {
    ApexPages.StandardSetController con;
    public DeleteStudentsController(ApexPages.StandardSetController controller) {
        this.con=controller;
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select atlest 1 record to delete'));
    }
    public PageReference cancel(){
        return new PageReference('/a00?fcf=00B90000005ihfK');
    }
    public PageReference Deleterecords(){
        List<Student__c> studentList=con.getSelected();
        try{
            delete studentList;
            return new PageReference('/a00?fcf=00B90000005ihfK');
        }
        catch(DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Error in deletion'));
            return null;     
        }  
    }
}