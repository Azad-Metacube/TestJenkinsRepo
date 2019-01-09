public with sharing class Demo_MassEmailAccountPageController {
    
    public map<Account, List<WrapContact>> mapAccountContacts{get;set;} //declaration of map variable
    
    public Demo_MassEmailAccountPageController(){
        mapAccountContacts = new map<Account, List<WrapContact>>();   //instantiation of map variable
        List<Account> accountList = new List<Account>(); //declaration and instantiation of list variable
        accountList = [select Id, Name,(select LastName, Email, FirstName, Birthdate from Contacts) from Account]; // initialization of list variable
        List<WrapContact> contactList;  //declaration of contact list variable
        for(Account accrec : accountList){
        	if(mapAccountContacts.size() == 5){
        		break;
        	}
            contactList = new List<WrapContact>();
            for(Contact conrec : accrec.Contacts){ 
                contactList.add(new WrapContact(conrec));
            }
            if(contactList.size() > 5 && mapAccountContacts.size() < 5){
            	mapAccountContacts.put(accrec,contactList);
            }
        }
    }
    
    public pageReference updateFields(){
   	List<Contact> cList = new List<Contact>(); 
    	for(Account acct : mapAccountContacts.keySet()){
    		for(WrapContact wC : mapAccountContacts.get(acct)){
    			if(wc.selected == true){
    				cList.add(wC.conWrap);
    			}
    		}
    	}
    	update cList;
    	pageReference pR = new pageReference('/apex/Demo_MassEmailAccountPage');
    	pR.setredirect(true);
    	return pR;
   
    }
    public class WrapContact {
        public Contact conWrap {get; set;}
        public Boolean selected {get; set;}
 
        public WrapContact(Contact c) {
            conWrap = c;
            selected = false;
        }
    }
    
}