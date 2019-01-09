public with sharing class test_demo_MassEmailAccountPageController {
	
	Public Map<Account,List<Contact>> Map_Account_Contacts{get;set;}
	
	
	Public test_demo_MassEmailAccountPageController{
	
	
	
	}
	
 List<Account> List_Acct = new List<Account>;
 List_Acct = [select Name, (select LastName from Contacts) from Account];
    

    
}