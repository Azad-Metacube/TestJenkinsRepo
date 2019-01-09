public class StudentDetailPdfController {
    public Student__c student{get;set;}
    private String sid;
    
    public StudentDetailPdfController(){
        try{
           sid = ApexPages.currentPage().getParameters().get('id');
           if(sid != null) {               
               List<Student__c> studentList = [Select s.Name, s.First_Name__c, s.Last_Name__c, s.Sex__c , s.Class__r.Name,s.DOB__c,s.Age__c,s.email__c From Student__c s where s.Id = : sid limit 1];  
               if(studentList.size() > 0) {
                   student = studentList[0];
                   //system.assert(false, student);
               } else {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No such record exists'));
               }
           } else {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid parameter passed'));
           }
        } catch(Exception e){   
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));           
        }        
    }
        
    public pageReference renderAsPdf(){                       
          PageReference PR = Page.Studentpdf;           
          Blob pdf = PR.getcontentasPDF();                                                        
          List <Attachment> Existingattachmt=[select a.Name,a.ParentID from Attachment a where a.ParentID=:student.Id];       
          Attachment attach=new Attachment();                                
          attach.Body=pdf;
          attach.Name='Student:..'+ student.Name+'--'+system.now()+'.pdf';
          attach.ParentID=student.Id;
          if(!(Existingattachmt.isEmpty())){
                  delete Existingattachmt;
          }
          try {
              insert(attach);                             
          }
          catch(System.DMLException e){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
              return null;
          }
          return new ApexPages.StandardController(student).view();
     }
}