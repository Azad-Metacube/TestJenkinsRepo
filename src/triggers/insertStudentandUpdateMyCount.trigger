trigger insertStudentandUpdateMyCount on Student__c (after insert, before insert) {
	
	List<String> classIds = new  List<String>();
	for(Student__c tempStudent : trigger.new){
 			classIds.add(tempStudent.Class__c);
 		}
 	
	List<Class__c> classList=[Select c.NumberOfStudents__c,c.MaxSize__c,c.MyCount__c From Class__c c where id in : classIds];
	
	if(trigger.isBefore)
	{			
 		for(Class__c tempClass: classList){
    		if(tempClass.NumberOfStudents__c == tempClass.MaxSize__c ){
            	Trigger.New[0].addError('Unable to process,class reached maxlimit');
    		}
        }
	}
	
	
	else if(trigger.isAfter)
	{
		List<Class__c> classes = new List<Class__c>();
   	    for(Class__c tempClass : classList){
			if(tempClass.MyCount__c == null)
				tempClass.MyCount__c=1;
				else
				tempClass.MyCount__c=tempClass.MyCount__c + 1;
				classes.add(tempClass);
			}		
		try{
			update classes;
		}
		catch(DMLException e){
			System.debug(' exception has occurred: ' + e.getMessage());
		}
	}
}