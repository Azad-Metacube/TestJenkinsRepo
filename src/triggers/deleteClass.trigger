trigger deleteClass on Class__c (before delete) { 
  
    Set<String> classIds = new Set<String>();
    for (Class__c c: Trigger.Old) {
        classIds.add(c.Id);
    }  
       
    List<Class__c> classList = [Select c.Id, (Select s.Id From Students__r s where s.Sex__c ='female') 
    From Class__c c where id in: classIds];   
    
    for (Class__c c :classList) {
        if (c.Students__r.size() > 0) {
            Trigger.Old[0].addError('Unable to delete');
        }
    }
}