trigger PopulateManagerOfLoan on Loan__c (before insert,before Update) {	 
	PopulateManagerOfLoanTriggerController.loanList=trigger.new;
	PopulateManagerOfLoanTriggerController.setManagerOfLoan();
}