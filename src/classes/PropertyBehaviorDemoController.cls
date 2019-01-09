public class PropertyBehaviorDemoController {

    public integer counter {get;set;}
    
    public PropertyBehaviorDemoController () {
        counter = 0;
    }
    public List<Account> getAccount() {
        
        system.debug('@@@@@@@called');
        counter = counter + 1 ;
        return [Select Name from Account Limit 1];
    }
    
    public List<Account> getAccount2() {
        
        system.debug('@@@@@@@called2');
        counter = counter + 1 ;
        return [Select Name from Account Limit 1];
    }
    
    public void cancel() {
    
    }
}