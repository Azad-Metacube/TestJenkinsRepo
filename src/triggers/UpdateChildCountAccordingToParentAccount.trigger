trigger UpdateChildCountAccordingToParentAccount on Account (after insert, before delete ,before update, after update) {	
    /*Set<Id> parentIds = new Set<Id>();
    Set<Id> oldParentIds = new Set<Id>();
    set<ID> accountIds=new set<ID>();
   if(trigger.isInsert){
    	for(Id accId : trigger.newMap.keySet()) {
       	 	parentIds.add(trigger.newMap.get(accId).Parent_Account__r.Id);
   		 }
   		List<Account> parentAccountList = [Select ChildCount__c from Account where id in : parentIds];
        for(Account pAcc : parentAccountList ) {            
            pAcc.ChildCount__c = pAcc.ChildCount__c + 1;
        }
        try {
            update parentAccountList;
        } catch (DMLException e) {
            System.debug(' exception has occurred: ' + e.getMessage());
        }
    }*/
    
    if(trigger.isInsert){
    	List<Account> accountListAfterInsert = new List<Account>([Select a.Parent_Account__r.ChildCount__c, a.Parent_Account__r.Id From Account a where a.Id in :trigger.newMap.keySet()]);
   		List<Account> listToBeUpdated = new List<Account>();
        for(Account tempAcc : accountListAfterInsert ) {    
        	if(tempAcc.Parent_Account__r.Id != null){        
            	tempAcc.Parent_Account__r.ChildCount__c++;
            	listToBeUpdated.add(tempAcc.Parent_Account__r);
        	}
        }
        try {
            update listToBeUpdated;
        } catch (DMLException e) {
            System.debug(' exception has occurred: ' + e.getMessage());
        }
    }
    else if(trigger.isDelete){
    	List<Account> accountListBeforeDelete = new List<Account>([Select a.Parent_Account__r.ChildCount__c, a.Parent_Account__r.Id From Account a where a.Id in :trigger.oldMap.keySet()]);
   		List<Account> listToBeUpdated = new List<Account>();
        for(Account tempAcc : accountListBeforeDelete ) {    
        	if(tempAcc.Parent_Account__r.Id != null){        
            	tempAcc.Parent_Account__r.ChildCount__c--;
            	listToBeUpdated.add(tempAcc.Parent_Account__r);
        	}
        }
        try {
            update listToBeUpdated;
        } catch (DMLException e) {
            System.debug(' exception has occurred: ' + e.getMessage());
        }
    }
    else if(trigger.isUpdate){
    	if(trigger.isBefore){
    		List<Account> accountListBeforeUpdate = new List<Account>([Select a.Parent_Account__r.ChildCount__c, a.Parent_Account__r.Id From Account a where a.Id in :trigger.oldMap.keySet()]);
   			List<Account> listToBeUpdated = new List<Account>();
        	for(Account tempAcc : accountListBeforeUpdate ) {    
        		if(tempAcc.Parent_Account__r.Id != null){        
            		tempAcc.Parent_Account__r.ChildCount__c--;
            		listToBeUpdated.add(tempAcc.Parent_Account__r);
        		}
      	  }
      	  try {
            update listToBeUpdated;
      	  } catch (DMLException e) {
           	 System.debug(' exception has occurred: ' + e.getMessage());
        	}
    	} else if(trigger.isAfter){
    		List<Account> accountListAfterUpdate = new List<Account>([Select a.Parent_Account__r.ChildCount__c, a.Parent_Account__r.Id From Account a where a.Id in :trigger.newMap.keySet()]);
   			List<Account> listToBeUpdated = new List<Account>();
       	    for(Account tempAcc : accountListAfterUpdate ) {    
        	if(tempAcc.Parent_Account__r.Id != null){        
            	tempAcc.Parent_Account__r.ChildCount__c++;
            	listToBeUpdated.add(tempAcc.Parent_Account__r);
        	}
        }
        try {
            update listToBeUpdated;
        } catch (DMLException e) {
            System.debug(' exception has occurred: ' + e.getMessage());
        }
    	}	
    }
}