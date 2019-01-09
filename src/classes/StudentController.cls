public class StudentController{
    
    public string firstName{get;set;}
    public List<Student__c> getStudent(){
        List<Student__c> student = [Select s.email__c, s.Sex__c, s.Married__c, s.Last_Name__c, s.First_Name__c, s.Class__c From Student__c s where  s.First_Name__c='kavita'];
        return student ;
    
    }

}