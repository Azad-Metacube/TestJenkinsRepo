global class MassEmailAccountPageController implements Schedulable{
	public static String CRON_EXP = '0 0 12 * * ?';
    public String filterInput{get;set;}
    public String filterTemplateInput{get;set;}
    public String selectedTemplateId{get;set;}
    public String contactId{get;set;}
    public String massEmailName{get;set;}
    public String scheduledOn{get;set;}
    public String confirmationOption{get;set;}
    public Boolean isBCCme{get;set;}
    public Boolean storeAnActivity{get;set;}
    public Boolean headerCheck{get;set;}
    public List<String> contactEmailList;
    public String userEmailAddress;
    public String accountId{get;set;}
    public List<WrapperContactClass> wrapperContactClassList{get;set;}
    public List<WrapperTemplateClass> wrapperTemplateClassList{get;set;}
    
    public List<SelectOption> confirm{
        get{
            List<SelectOption> options = new List<SelectOption>(); 
                options.add(new SelectOption('Send Now','Send Now'));
                options.add(new SelectOption('Schedule','Schedule On'));  
            return options; 
        }
        set;
    }
    
    public MassEmailAccountPageController(ApexPages.StandardController controller) {
        contactEmailList=new List<String>();
        wrapperContactClassList=new List<WrapperContactClass>();
        wrapperTemplateClassList=new List<WrapperTemplateClass>();
        userEmailAddress = UserInfo.getUserEmail();     
    }
    
     public MassEmailAccountPageController() {
        contactEmailList=new List<String>();
        wrapperContactClassList=new List<WrapperContactClass>();
        wrapperTemplateClassList=new List<WrapperTemplateClass>();
        userEmailAddress = UserInfo.getUserEmail();     
    }
    
    public PageReference selectedContactId(){
        for(WrapperContactClass tempContact:wrapperContactClassList){
            if(tempContact.isChecked){
                if(tempContact.c.Email !=null){
                    contactEmailList.add(tempContact.c.Email);
                    
                }
            }
        }
        if(contactEmailList.size() == 0){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please select a contact having email Id'));
               return null; 
            }
        if(filterTemplateInput == null){    
	        wrapperTemplateClassList.clear();    
	        for(EmailTemplate temptemplate:[Select e.TemplateType, e.Name, e.Description From EmailTemplate e]){
	            wrapperTemplateClassList.add(new WrapperTemplateClass(temptemplate));
	        }
        }           
        return new PageReference('/apex/MassEmailTemplatePage');   
    }
    
    public void getContactList(){
    	headerCheck=false;
    	if(wrapperContactClassList.size() > 0){
    		wrapperContactClassList.clear();
    	}
		if(filterInput != ''){
    		getAccountId(filterInput);
    		populatedwrapperContactClassList();
    	}else{
    		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please select an Account '));
    	}    
    }
    
    private void getAccountId(String accountName){
    	List<Account> accountList=[Select a.Id,a.Name,a.BillingState, a.BillingPostalCode,a.BillingStreet, a.BillingCity From Account a where a.Name =:accountName];
    		if(accountList.size() == 0){
    			accountId = null;
    			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Such account exists'));
    		}else if(accountList.size() > 1){
    			accountId = null;
    			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Multiple Accounts exist'));
    		}else{
    			accountId =accountList[0].Id;
    		}
    }
    
    private void populatedwrapperContactClassList(){
    	if(accountId != null){
	        for(Contact tempContact:[Select c.Phone, c.Id,c.name,c.FirstName,c.LastName, c.Fax, c.Email, c.Account.Name From Contact c where c.Account.Id =:accountId ]){
	        	wrapperContactClassList.add(new WrapperContactClass(tempContact));
            }		                
	        if(wrapperContactClassList.size() == 0){
	        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'This account has no any associated contact'));
	        }
        }
    }
    
    public void saveEmailIds(){
    	for(WrapperContactClass tempcontList :wrapperContactClassList){
    		try{
    			upsert tempcontList.c ;
    		}catch(DMLException e){
    			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
    		}
    	}
    }
    
    public void getTemplateList(){
        wrapperTemplateClassList.clear();
        if(filterTemplateInput != '' && filterTemplateInput !=null){
        	String str;
			if(filterTemplateInput.startsWith('*') || filterTemplateInput.startsWith('%')){
				str=filterTemplateInput.substring(1)+'%';
			}else if(filterTemplateInput.endsWith('*') || filterTemplateInput.endsWith('%')){
				Integer filterTemplateInputlength=filterTemplateInput.length();
				str='%'+filterTemplateInput.substring(0,filterTemplateInputlength-1);
			}else{
				str='%'+filterTemplateInput+'%';
			}
            for(EmailTemplate temptemplate:[Select e.TemplateType, e.Id, e.Name, e.Description From EmailTemplate e where e.Name like : str]){
                wrapperTemplateClassList.add(new WrapperTemplateClass(temptemplate));
            }
            if(wrapperTemplateClassList.size() ==0){
            	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No such Email Template exists'));
            }
        }else{
            for(EmailTemplate temptemplate:[Select e.TemplateType, e.Id, e.Name, e.Description From EmailTemplate e]){
                wrapperTemplateClassList.add(new WrapperTemplateClass(temptemplate));
            }
        }    
    }
    
    public PageReference redirectContactDetail(){
        PageReference pg = new PageReference('/apex/teacherRecord?id='+contactId+'&sfdc.override=1');
        pg.setRedirect(true);
        return pg;
    }
    public class WrapperContactClass{
        public Contact c{get;set;}
        public Boolean isChecked{get;set;}
        
        public WrapperContactClass(Contact c){
            this.c=c;
            isChecked=false;
        }  
    }
    
    public class WrapperTemplateClass{
        public EmailTemplate temp{get;set;}
        public Boolean isChecked{get;set;}
        public String name;
        public String Id;
        
        public WrapperTemplateClass(EmailTemplate temp){
            this.temp=temp;
            isChecked=false;
            this.Id=temp.Id;
            this.name=temp.Name;
        }
        public PageReference previewLink(){
        	return new PageReference('/'+Id+'?setupid='+name);
        }
    }
    
    public PageReference redirectCancel(){
        wrapperContactClassList.clear();
        contactEmailList.clear();
        filterInput=null;
        filterTemplateInput=null;
        selectedTemplateId=null;
        massEmailName='';
        return new PageReference('/apex/MassEmailAccountPage');
    }
    
    public PageReference redirectpreviousPage(){   
        return new PageReference('/apex/MassEmailAccountPage');
    }
    
    public PageReference redirectpreviousTemplatePage(){
    	return new PageReference('/apex/MassEmailTemplatePage');
    }  
    
    public PageReference selectedTemplate(){
    	if(selectedTemplateId == ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please Select a Template'));
            return null;
        }
        for(WrapperTemplateClass tempTemplate:wrapperTemplateClassList){
            if(tempTemplate.temp.Id == selectedTemplateId){
                tempTemplate.isChecked=true;
            }
        }
        return new PageReference('/apex/MassEmailConfirmationPage');
    } 
    
    global PageReference scheduleIt() {
    	if(massEmailName == ''){
  	    	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please Enter Mass Email name'));
  	    	return null;
  	    }
    	if(confirmationOption == null){
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please Select Delivery Option'));
			return null;
    	}else if(confirmationOption == 'Send Now'){
  	    	sendEmail();
        }else{
  	    	if(scheduledOn != null){
  	    		Scheduler sm = new Scheduler();
		    	System.schedule(massEmailName, CRON_EXP, sm);	
       		}else{
       			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please Select Schedule Date'));	
       			return null;
       		}
        }
		return new PageReference('/apex/MassEmailComplete');
	}
    
    global void execute(SchedulableContext sc) {
    	Date scheduledDate=date.parse(scheduledOn);
    	if(system.today() == scheduledDate){
    		sendEmail();
    	}
	}

    public void sendEmail(){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setReplyTo('kavita.bkbiet@gmail.com');
        String[] bccEmail = new String[]{userEmailAddress};    
        if(isBCCme){
        	email.setBccAddresses(bccEmail);
        	email.setBccSender(true);
        } 
        email.setTargetObjectId(wrapperContactClassList[0].c.Id);
        email.setToAddresses(contactEmailList);
        email.setTemplateId(selectedTemplateId);
        if(!storeAnActivity){
        	email.setSaveAsActivity(false);
        }
        else{
        	try{
        		email.setSaveAsActivity(true);
        	}catch(Exception e){
        		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Error,Cannot save as activity'));
        	}	
        } 
        email.setSenderDisplayName(massEmailName);
        Messaging.SendEmailResult [] res = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});     
       // system.assert(false,res+'***'+email+'****'+contactIds);
    }      
}