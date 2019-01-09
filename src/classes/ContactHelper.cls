public with sharing class ContactHelper {
	
	public static void updateContactField(Id ContactID) {
		Contact contact= [Select c.Account.Id from Contact c where c.Id=:ContactID];
		Account account=[Select a.Id,a.ContactIDs__c from Account a where a.Id=:contact.Account.Id];
		List<Contact> ContactList = new List<Contact>([Select c.Name,c.Id From Contact c where c.Account.Id = :account.Id]);
		if(account.ContactIDs__c=='' || account.ContactIDs__c == null){
			
			for(Integer i=0 ; i<ContactList.size() ; i++){
		    	account.ContactIDs__c +=ContactList[i].Id + ',';
			}
		}
		else {
			String[] s = account.ContactIDs__c.split(',');
			for(Integer i=0 ; i<ContactList.size() ; i++){
				for(Integer j=0 ; j<s.size() ; j++){
					if(s[j].equals(ContactList[i].Id)){
					break;
					}
					if(j==s.size()-1){
						account.ContactIDs__c = account.ContactIDs__c +','+ ContactList[i].Id ;
					}
				}
			}
		}
		update account;
	}
}


/*ContactHelper.updateContactField('0039000000iiCpAAAU');*/