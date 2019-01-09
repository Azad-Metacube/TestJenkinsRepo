public class StudentDetailUsingComboController {
    public List<SelectOption> selectionList{get;set;}
    public String selectedStudent{get;set;}
    public StudentDetailUsingComboController(){
        List<Student__c> studentList=new List<Student__c>([Select s.Name From Student__c s]);
        selectionList =new List<SelectOption>();
        for(Student__c tempstudent:studentList){
            selectionList.add(new SelectOption(tempstudent.Name,tempstudent.Name));
        }    
    }
    public List<Student__c> getGetStudentDetail() {
         List<Student__c> studentDetail = new List<Student__c>([Select s.Name, s.Last_Name__c, s.First_Name__c From Student__c s where s.Name = : selectedStudent]);
         return studentDetail ;
    } 
}