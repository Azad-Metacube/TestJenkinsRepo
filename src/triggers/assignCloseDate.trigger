trigger assignCloseDate on Opportunity (before update) {
	for(Opportunity op : trigger.new){
		if(op.StageName == 'Closed Won' || op.StageName == 'Closed Lost'){
			op.CloseDate=system.today();
		}
	}
}