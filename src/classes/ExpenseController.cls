public class ExpenseController {
    @AuraEnabled
    public static List<Expense__c> getExpenses() {
        return [SELECT id, name, amount__c, client__c,
                   reimbursed__c, createdDate FROM Expense__c];
    }
    
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        upsert expense;
        return expense;
    }
}