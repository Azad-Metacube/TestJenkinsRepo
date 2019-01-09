public class NewStudentCustomController {
    public String studentName{get;set;}
    public String className{get;set;}
    private String classId;
    public NewStudentCustomController(ApexPages.StandardController controller) {
        classId=ApexPages.currentPage().getParameters().get('Id');
        if(classId != null){
            List<Class__c> tempClass = new List<Class__c>([Select c.Name From Class__c c where c.Id =: classId]);
            className = tempClass[0].Name;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select Class'));
        } 
    }
    public PageReference StudentRecordSaved(){
        Student__c tempStudent = new Student__c();
        if(studentName != null){
            List<String> name=studentName.split(' ');
            if(name.size() <= 2){
                if(name.size() ==2){
                    tempStudent.Last_Name__c = name[1];
                    tempStudent.First_Name__c = name[0];
                }
                else{
                    tempStudent.Last_Name__c = name[0];
                }                
            }
            else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Enter Name only'));
                return null;
            }
            tempStudent.Class__c = classId;
            try{   
                insert tempStudent;
                List<Student__c> tempStudent1 =[Select s.Id from Student__c s order by s.Name desc limit 1];
                return new PageReference('/'+tempStudent1[0].Id);  
            }
            catch(DMLException e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Invalid Name Entry'));
                return null;
            }
        }
        else{
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Enter Name'));
             return null;
        }
    }
}