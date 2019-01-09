public class TestController {
    public List<Test__c> testList;
    public String Name{get;set;}
    public Boolean flag{get;set;}
    public String selectedOption{get;set;}
    public List<SelectOption> getSelectOption {
        get{
            List<SelectOption> selectList =new List<SelectOption>();
            selectList.add(new SelectOption('--Select--','--Select--'));
             for(Test__c tempList : testList){
                selectList.add(new SelectOption(tempList.Choose__c,tempList.Choose__c)); 
             }
             return selectList;
        }
        set;
    }
    public TestController(){
        testList=new List<Test__c>([Select t.Choose__c From Test__c t]);
    }
    public PageReference callmethod(){
        if(selectedOption == 'No'){
            flag = true ;
            return null;
           }
        else {
            flag = false;
            return null;
           } 
       
    }                                
}