public class ClickNewStudentOpenClass {

    public ClickNewStudentOpenClass(ApexPages.StandardController controller) {

    }

	public PageReference callFunction(){
		String prefix=Schema.getGlobalDescribe().get('Class__c').getDescribe().getKeyPrefix();
		return new PageReference('/'+prefix+'/e');	
	}
}