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
private class ContactHelperTest {

    static testMethod void contactIdIsNull() {
    	
       Account account1=new Account(Name='ucco');
       insert account1;
       Contact contact1=new Contact(FirstName='shradha',LastName='bagria',AccountId=account1.Id);
       Contact contact2=new Contact(FirstName='neha',LastName='gupta',AccountId=account1.Id);
       Contact contact3=new Contact(FirstName='rishi',LastName='garg',AccountId=account1.Id);
       insert contact1;
       insert contact2; 
       insert contact3;  
       ContactHelper.updateContactField(contact1.Id);
       Account a1=[Select a.ContactIDs__c from Account a where a.Id=:contact1.Account.Id];
       String s=contact1.Name+','+contact2.Name+','+contact3.Name;
       System.assert(a1.ContactIDs__c==s); 
    }
    
    
    static testMethod void contactIdIsNotNull() {
       Account account1=new Account(Name='ucco');
       Account account2=new Account(Name='Axis',ContactIDs__c='abc');
       insert account1;
       insert account2;
       Contact contact1=new Contact(FirstName='shradha',LastName='bagria',AccountId=account1.Id);
       Contact contact2=new Contact(FirstName='neha',LastName='gupta',AccountId=account1.Id);
       insert contact1;
       insert contact2;
       ContactHelper.updateContactField(contact1.Id);
       Contact contact3=new Contact(FirstName='rishi',LastName='garg',AccountId=account1.Id); 
       insert contact3;  
       ContactHelper.updateContactField(contact3.Id);
       Account a1=[Select a.ContactIDs__c from Account a where a.Id=:contact1.Account.Id];
       String s=contact1.Name+','+contact2.Name+','+contact3.Name;
       System.assert(a1.ContactIDs__c==s); 
    }
    static testMethod void contactIdExist() {
       Account account1=new Account(Name='ucco');
       insert account1;
       Contact contact1=new Contact(FirstName='shradha',LastName='bagria',AccountId=account1.Id);
       Contact contact2=new Contact(FirstName='neha',LastName='gupta',AccountId=account1.Id);
       Contact contact3=new Contact(FirstName='rishi',LastName='garg',AccountId=account1.Id);  
       insert contact1;
       insert contact2;
       insert contact3; 
       ContactHelper.updateContactField(contact1.Id);     
       Account a1=[Select a.ContactIDs__c from Account a where a.Id=:contact1.Account.Id];
       String s=contact1.Name+','+contact2.Name+','+contact3.Name;
       ContactHelper.updateContactField(contact3.Id);
       System.assert(a1.ContactIDs__c==s); 
    }
    
    
}