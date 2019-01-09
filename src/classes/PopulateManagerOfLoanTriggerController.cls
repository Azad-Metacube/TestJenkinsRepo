public class PopulateManagerOfLoanTriggerController {
	public static List<Loan__c> loanList {get;set;}
	public static void setManagerOfLoan() {
		map<String,Id> cityManagerMap= new map<String,Id>();
		for(CityManager__c tempCityManager : [Select c.Name, c.Manager__c From CityManager__c c ]){
			cityManagerMap.put(tempCityManager.Name,tempCityManager.Manager__c);
		}
		for(Loan__c tempLoan :loanList){
			if(tempLoan.City__c != null){
				tempLoan.CityManager__c = cityManagerMap.get(tempLoan.City__c);
			}
		}
	}
}