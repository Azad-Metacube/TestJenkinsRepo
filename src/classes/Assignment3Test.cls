/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Assignment3Test {

    static testMethod void myUnitTest1() {
       Class__c classobj=new Class__c(Name__c='X1',Name='X1');
       insert classobj;
       Student__c s1=new Student__c(First_Name__c='neha',Last_Name__c='agarwal',Class__c=classobj.Id);
       Student__c s2=new Student__c(First_Name__c='rishi',Last_Name__c='gupta',Class__c=classobj.Id);
       List<Student__c> sList=new List<Student__c>{s1,s2};
       insert sList;
       system.assertEquals(sList,Assignment3.getStudentsInClass(classobj.Name));
       system.assertEquals(sList,Assignment3.getStudentsInClass(classobj.Name));  
    }
    
    static testMethod void myUnitTest2() {
     Class__c classobj1=new Class__c(Name__c='X',Name='X');
     Class__c classobj2=new Class__c(Name__c='X1',Name='X1');
     insert classobj1;
     insert classobj2;
     Student__c s1=new Student__c(First_Name__c='nishi',Last_Name__c='agarwal',Class__c=classobj1.Id);
     Student__c s2=new Student__c(First_Name__c='neha',Last_Name__c='gupta',Class__c=classobj2.Id);
     Student__c s3=new Student__c(First_Name__c='niki',Last_Name__c='garg',Class__c=classobj2.Id);
     List<Student__c> sList=new List<Student__c>{s1,s2,s3};
     insert sList;
     Map<Class__c,List<Student__c>> studentMap=new Map<Class__c,List<Student__c>>();
     List<Class__c> className = new List<Class__c>([Select c.Name From Class__c c ]);
	 List<Student__c> student=new List<Student__c>();
	for(Class__c temp: className){
		String cName = temp.Name;
		student=[Select s.Name From Student__c s where s.Class__r.Name =:cName];
		studentMap.put(temp,student);
	}
     system.assertEquals(studentMap,Assignment3.studentsInClass());
    }
    
    static testMethod void myUnitTest3() {
    Account account1=new Account(Name='ucco');
    Account account2=new Account(Name='Axis');
    insert account1;
    insert account2;
    Contact contact1=new Contact(FirstName='shradha',LastName='bagria',AccountId=account1.Id);
    insert contact1;	
    
    Opportunity o1=new Opportunity(CloseDate=date.parse('12/01/2013'),Name='development1',StageName='Closed Won');
    Opportunity o2=new Opportunity(CloseDate=date.parse('12/01/2013'),BillToContact__c=contact1.Id,Name='development2',StageName='Closed Won');
    Opportunity o3=new Opportunity(CloseDate=date.parse('12/01/2013'),BillToContact__c=contact1.Id,Name='development3',StageName='Closed Won',Manager__c=account2.Id);
       List<Opportunity> oList=new List<Opportunity>{o1,o2,o3};
       insert oList;
       Assignment3.populateManager(oList);
       Opportunity op1=[Select BillToContact__c from Opportunity where 	Id=: o1.id];
       Opportunity op2=[Select Manager__c from Opportunity where Id=: o2.id];
       Opportunity op3=[Select Manager__c from Opportunity where Id=: o3.id];
       System.assert(op1.BillToContact__c==null);
       System.assertEquals(op2.Manager__c,account1.Id);
       System.assertEquals(op3.Manager__c,account2.Id);
       
    }
    
    static testMethod void myUnitTest4() {
    	System.assertEquals(6,Assignment3.getWorkingDays(date.parse('11/01/2013'),date.parse('11/10/2013')));
    	
    }
    
    static testMethod void myUnitTest5() {
    	List<Schema.SObjectType> objectList = Schema.getGlobalDescribe().values();
    	      System.assertEquals(objectList,Assignment3.getAllObjects());
    }
    
}