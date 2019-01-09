public class MassEmailTemplatePageController {
    public String filterInput{get;set;}
    public String TemplateId{get;set;}
    public String selectedTemplateId{get;set;}
    public String selectedTemplate{get;set;}
    public List<WrapperTemplateClass> wrapperTemplateClassList{get;set;}
    
    public MassEmailTemplatePageController(ApexPages.StandardController controller) {
        wrapperTemplateClassList=new List<WrapperTemplateClass>();
        for(EmailTemplate temptemplate:[Select e.TemplateType, e.Name, e.Description From EmailTemplate e]){
                    wrapperTemplateClassList.add(new WrapperTemplateClass(temptemplate));
                }  
    }
    
    
    public void getTemplateList(){
        wrapperTemplateClassList.clear();
        for(EmailTemplate temptemplate:[Select e.TemplateType, e.Name, e.Description From EmailTemplate e where e.Name =: filterInput]){
                    wrapperTemplateClassList.add(new WrapperTemplateClass(temptemplate));
                }
    }
    
    public class WrapperTemplateClass{
        public EmailTemplate temp{get;set;}
        public Boolean isChecked{get;set;}
        public WrapperTemplateClass(EmailTemplate temp){
            this.temp=temp;
        }
        
    }         

}