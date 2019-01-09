trigger OpportunityStatusChanged on Opportunity (after update) {
	List<Opportunity> opp=new List<Opportunity>([Select o.Owner.Name,o.Owner.Email,o.OwnerId,o.Custom_Status__c From Opportunity o where o.Id =: trigger.new[0].Id]);
		if(opp[0].Custom_Status__c != trigger.old[0].Custom_Status__c){
			EmailTemplate eTemp = [select id,name from EmailTemplate where name ='OpportunityStatusTemplate' and isActive = true Limit 1];
			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
			email.setReplyTo('kavita.beniwal@metagurukul.com'); 	
			email.setSaveAsActivity(false);	
			email.setTemplateId(eTemp.Id);
		    email.setTargetObjectId(opp[0].OwnerId); 	
			email.setToAddresses(new String[]{opp[0].Owner.Email}); 	
			Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email}); 
		}
}