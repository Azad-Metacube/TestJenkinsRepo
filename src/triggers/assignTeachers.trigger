trigger assignTeachers on Contact (before insert, before update) {
	for(Contact tempTeacher: trigger.new){
		if(tempTeacher.Subjects__c=='Hindi'){
			tempTeacher.addError('Unable to process');
		}
	}
}