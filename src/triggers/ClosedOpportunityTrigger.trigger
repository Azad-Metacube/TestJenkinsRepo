trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
    List<Task> tasksListToInsert = new List<Task>();
    for(Opportunity op : trigger.new) {
        
        if(op.StageName == 'Closed Won') {
            tasksListToInsert.add(new Task(subject = 'Follow Up Test Task' , WhatId = op.Id));
        }
    }
    
    if(tasksListToInsert.size() > 0) {
        insert tasksListToInsert;
    }
}