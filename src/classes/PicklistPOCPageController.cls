public class PicklistPOCPageController {
    public boolean flag1{get;set;}
    public boolean isRequired{get;set;}
    public String selectedValue{get;set;}
    public PicklistPOCPageController(ApexPages.StandardController controller) {
        flag1=true;
        isRequired=false;
    }
    public void getChoice(){
        if(selectedValue == 'Yes'){
            isRequired=true;
            flag1=true;
        }else if(selectedValue == 'No') {
            flag1=false;
            isRequired=false;
        }else{
            flag1=true;
            isRequired=false;
        }   
    }
}