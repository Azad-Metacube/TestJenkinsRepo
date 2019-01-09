trigger OrderStatus on Purchase_Order__c (before insert) {
	if(trigger.isBefore){
		for(Purchase_Order__c tempOrder : trigger.new){
			if(tempOrder.Status__c == 'Delivered'){
				Trigger.New[0].addError('Unable to process,Status can not be delivered before order');
			}
			
		}
	}
}