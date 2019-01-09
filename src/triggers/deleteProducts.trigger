trigger deleteProducts on Opportunity (after update , before update) {

	
	if(trigger.isBefore){
		for(Opportunity op : trigger.new){
			if(op.StageName == 'Closed Won' || op.StageName == 'Closed Lost'){
				op.CloseDate=system.today();
			}
		}
	}
	else if(trigger.isAfter)
	{		
		Set<String> opportunityIds = new Set<String>();
		List<OpportunityLineItem> deleteOppLineItemList = new List<OpportunityLineItem>();
	
		for(Opportunity op : trigger.new){
		opportunityIds.add(op.Id);
		}
	
		List<OpportunityLineItem> oppList = [Select o.OpportunityId, o.Id From OpportunityLineItem o where o.OpportunityId in : opportunityIds ];
		for(OpportunityLineItem tempOpp : oppList){
			if(trigger.newMap.get(tempOpp.OpportunityId).Custom_Status__c == 'Reset'){
			    deleteOppLineItemList.add(tempOpp);
		    }
		}
	  
		try{
			delete deleteOppLineItemList;
		}
			
		catch(DMLException e){
			System.debug(' exception has occurred: ' + e.getMessage());
		}
	}
}