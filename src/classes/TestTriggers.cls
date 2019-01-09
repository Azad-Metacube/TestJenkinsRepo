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
private class TestTriggers {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
         Class__c classobj=new Class__c(Name__c='X1',Name='X1',MyCount__c=2);
         insert classobj;
         Student__c testStudent1 = new Student__c(Last_Name__c='bagaria',Class__c=classobj.Id);
         Student__c testStudent2 = new Student__c(Last_Name__c='gupta',Class__c=classobj.Id);
         Student__c testStudent3 = new Student__c(Last_Name__c='agarwal',Class__c=classobj.Id);
         insert testStudent1;
         insert testStudent2;
         try{
         	insert testStudent3;
         }
         catch(DMLException e){
        	
        }
        
        Opportunity op = new Opportunity(Name='op11',CloseDate=Date.Parse('12/12/2014'),StageName='Qualification',Custom_Status__c='New');
        insert op;
        op.StageName = 'Closed Won';
        try{
        	update op;
        }
        catch(DMLException e){
        	
        }
        Opportunity op1 = new Opportunity(Name='op11',CloseDate=Date.Parse('12/12/2014'),StageName='Qualification',Custom_Status__c='Reset');
     //   op.Custom_Status__c='Reset';
        try{
        	update op1;
        }
        catch(DMLException e){
        	
        }
        try{
        	delete classobj;
        }
        catch(DMLException e){
        	
        }
        Contact teacher = new Contact(LastName = 'sharma',Subjects__c = 'hindi');
        try{
       	 insert teacher;
        }
        catch(DMLException e){
        	
        }
    }
}