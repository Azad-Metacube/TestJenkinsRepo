public  class Assignment3 {

public static List<Student__c> getStudentsInClass(String classId)
{
	List<Student__c> student=new List<Student__c>();
	student=[Select s.First_Name__c,s.Last_Name__c From Student__c s where s.Class__r.Name =:classId];
	return student;
}

/*
Assignment3.getStudentsInClass('X');
*/

	
public static Map<Class__c,List<Student__c>> studentsInClass()
{
	Map<Class__c,List<Student__c>> studentMap=new Map<Class__c,List<Student__c>>();
	List<Student__c> student=new List<Student__c>();
	List<Class__c> className = new List<Class__c>([Select c.Name From Class__c c ]);
	
	for(Class__c temp: className){
		String cName = temp.Name;
		student=[Select s.Name From Student__c s where s.Class__r.Name =:cName];
		studentMap.put(temp,student);
	}
	return studentMap;
}

/*Assignment3.studentsInClass()*/


public static Integer getWorkingDays(Date startDate, Date endDate) {
	Integer count=0;
	Integer noOfDays = startDate.daysBetween(endDate);
	Integer days=date.parse('01/07/1900').daysBetween(startDate);
	for(Integer i=0 ; i<noOfDays; i++){
		if((math.mod(days+i,7)!=0) && (math.mod(days+i,7)!=6)){
			count++;
		}
	}
	return count;
}
/*Assignment3.getWorkingDays(date.parse('11/01/2013'),date.parse('11/10/2013'));*/



public static List<Schema.SObjectType> getAllObjects(){
List<Schema.SObjectType> objectList = Schema.getGlobalDescribe().values();
return objectList;
}
/*Assignment3.getAllObjects();*/






public static void populateManager(List<Opportunity> opp){
	for(Opportunity temp:opp){
		if(temp.BillToContact__c != null && temp.Manager__c == null){
			Contact contact=[Select c.Account.Id from Contact c where c.Id =:temp.BillToContact__c];
			temp.Manager__c=contact.Account.Id;
		}
	update temp;
	}
}
/* 
List<Opportunity> o=new List<Opportunity>(Select o.BillToContact__c,o.Manager__c from Opportunity o )
Assignment3.populateManager(o);
*/


}