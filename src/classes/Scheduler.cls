global class Scheduler implements Schedulable{

	public static String CRON_EXP = '0 0 12 * * ?';
	
	global static String scheduleIt() {
		Scheduler sm = new Scheduler();
		return System.schedule('Monthly Reconciliation', CRON_EXP, sm);
	}
	

global void execute(SchedulableContext sc) {
  date d = system.today().addDays(-30);
  list<Opportunity> lastModifiedDate = new list<Opportunity>([Select o.LastModifiedDate From Opportunity o limit 2]);
      for(Opportunity lastDate: lastModifiedDate){
         if(lastDate.LastModifiedDate < d){
           sendEmail();
    }
  }
}
	
	public void sendEmail() {
    	String EMAIL_ADDRESS = 'kavita.beniwal@metagurukul.com';
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses( new String[] { EMAIL_ADDRESS });
        mail.setSubject('Message from SalesForce!');
        mail.setPlainTextBody('Hello Dear\nYour record has not been updated since 30 days.Please Check it.\nThanks,\nSystem Admin');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}