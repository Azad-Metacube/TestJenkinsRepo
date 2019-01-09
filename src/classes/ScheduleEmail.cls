global class ScheduleEmail implements Schedulable{

	public static String CRON_EXP = '0 0 12 * * ?';
	
	global static String scheduleIt() {
		Scheduler sm = new Scheduler();
		return System.schedule('Monthly Reconciliationss', CRON_EXP, sm);
	}

	global void execute(SchedulableContext sc) {
		list<Opportunity> lastModifiedDates = new list<Opportunity>([Select o.LastModifiedDate From Opportunity o limit 2]);
		// Date dateBefore30Days = date.today()-30;
		Date dateBefore30Days = date.parse('01/09/2014')-30;
		for(Opportunity lastModified: lastModifiedDates){
			if(dateBefore30Days >= lastModified.LastModifiedDate){
				sendEmail();
			}
		}
	}
	
	public void sendEmail() {
    	String EMAIL_ADDRESS = 'kavita.bkbiet@gmail.com';
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses( new String[] { EMAIL_ADDRESS });
        mail.setSubject('Message from SalesForce!');
        mail.setPlainTextBody('Hello Dear\nYour record has not been updated since 30 days.Please Check it.\nThanks,\nSystem Admin');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}