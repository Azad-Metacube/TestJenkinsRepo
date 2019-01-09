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
private class MassEmailAccountPageControllerTest {
	
    static testMethod void getContactListTest() {
    	ApexPages.StandardController controller;
        Account acc1 = new Account(Name = 'abc');
        Account acc2 = new Account(Name = 'efg');
        List<Account> accList = new List<Account>{acc1,acc2};
        insert accList;
        Contact con1 = new Contact(FirstName = 'amit',LastName = 'sharma',AccountId = accList[0].Id,email='kavita.beniwal@metagurukul.com');
        Contact con2 = new Contact(FirstName = 'ankita',LastName = 'gupta',AccountId = accList[1].Id);
        Contact con3 = new Contact(FirstName = 'anuj',LastName = 'goyal',AccountId = accList[0].Id,email='kavita.beniwal@metacube.com');
        List<Contact> contactList1 = new List<Contact>{con1,con2,con3};
        List<Contact> contactList2 = new List<Contact>{con1,con3};
        insert contactList1;
        MassEmailAccountPageController controllerObj = new MassEmailAccountPageController(controller);
        controllerObj.filterInput = accList[0].Name;
        controllerObj.getContactList();     
        List<Contact> tempcontactList = new List<Contact>();
        for(Integer i = 0 ; i< controllerObj.wrapperContactClassList.size() ; i++){
        	tempContactList.add(controllerObj.wrapperContactClassList[i].c);
        }
        List<Contact> contactList3 = new List<Contact>([Select c.LastName, c.FirstName, c.AccountId ,c.email From Contact c where c.Id in : tempContactList ]);
        System.assertEquals(contactList2,contactList3);
        
        controllerObj.wrapperContactClassList[0].isChecked=true;
        List<String> emailIdList = new List<String>();
        emailIdList.add(controllerObj.wrapperContactClassList[0].c.email);
        controllerObj.selectedContactId();
        System.assertEquals(emailIdList,controllerObj.contactEmailList);
        
        List<EmailTemplate> emailTemplateList1 = new List<EmailTemplate>([Select e.TemplateType, e.Id, e.Name, e.Description From EmailTemplate e where e.Name like '%wish%']);
        List<EmailTemplate> emailTemplateList2 = new List<EmailTemplate>();
        controllerObj.filterTemplateInput='wish';
        controllerObj.getTemplateList();
        for(Integer i = 0 ; i< controllerObj.wrapperTemplateClassList.size() ; i++){
        	emailTemplateList2.add(controllerObj.wrapperTemplateClassList[i].temp);
        }
        System.assertEquals(emailTemplateList1,emailTemplateList2);
        
        //Set up user
        controllerObj.selectedTemplateId = '00X90000000fdRE';
        controllerObj.selectedTemplate();
        System.assert(true,controllerObj.wrapperTemplateClassList[0].isChecked);
		controllerObj.massEmailName='Test';
		controllerObj.confirmationOption='Send Now';
		controllerObj.isBCCme=false;
		controllerObj.storeAnActivity=false;
		PageReference pg1=new PageReference('/apex/MassEmailComplete');
		PageReference pg2=controllerObj.scheduleIt();
		System.assert(true,pg1==pg2);
		controllerObj.scheduledOn='2014/12/03';
		controllerObj.confirmationOption='Schedule';
		PageReference pg3=new PageReference('/apex/MassEmailComplete');
		PageReference pg4=controllerObj.scheduleIt();
		System.assert(true,pg3==pg4);
		controllerObj.contactId ='0039000000lxm7c';
		PageReference pg5=new PageReference('/apex/teacherRecord?id='+controllerObj.contactId+'&sfdc.override=1');
		PageReference pg6=controllerObj.redirectContactDetail();
		System.assert(true,pg5==pg6);
		PageReference pg7=new PageReference('/apex/MassEmailAccountPage');
		PageReference pg8=controllerObj.redirectCancel();
		System.assert(true,pg7==pg8);
		PageReference pg9=new PageReference('/apex/MassEmailAccountPage');
		PageReference pg10=controllerObj.redirectpreviousPage();
		System.assert(true,pg9==pg10);
    }
}