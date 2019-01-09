public class StudentDetailController {
    public List<Student__c> studentList{get;set;}
    public StudentDetailController(ApexPages.StandardController controller) {
         String studentId=ApexPages.currentPage().getParameters().get('Id');
         studentList = new List<Student__c>([Select s.First_Name__c, s.Last_Name__c,s.Class__r.Name,s.Name From Student__c s where s.Id =: studentId]);
    }

}