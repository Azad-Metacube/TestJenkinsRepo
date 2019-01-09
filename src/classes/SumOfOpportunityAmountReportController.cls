public class SumOfOpportunityAmountReportController {
    
    public Map<String,integer> amountPerAccount{set;get;}
    public List<String> accIds{get;set;}
    public Map<String,String> nameOfAccountById{get;set;}
    public Map<String,List<Opportunity>> nameOfOpportunitiesById{get;set;}
    public Map<String,Decimal> numberOfOpportunitiesById{get;set;}
    
    public SumOfOpportunityAmountReportController(){
        amountPerAccount = new Map<String,integer>();
        accIds = new List<String>();
        List<AggregateResult> aggResult = new List<AggregateResult>([Select Sum(Amount)TotalAmount,AccountId From Opportunity where AccountId !=null group by AccountId limit 10]);
        for(AggregateResult tempAggResult : aggResult){
            if(integer.valueOf(tempAggResult.get('TotalAmount')) != null)
                amountPerAccount.put(string.valueOf(tempAggResult.get('AccountId')),integer.valueOf(tempAggResult.get('TotalAmount')));
            else
                amountPerAccount.put(string.valueOf(tempAggResult.get('AccountId')),0);
            accIds.add(string.valueOf(tempAggResult.get('AccountId')));
        }
        //system.assert(false, accIds+'*****'+amountPerAccount);
        List<Account> acc = new List<Account>([select Id, Name, (select Id,Name,Amount from Opportunities) from Account]);
        nameOfAccountById = new Map<String,String>();
        nameOfOpportunitiesById = new Map<String,List<Opportunity>>();
        numberOfOpportunitiesById = new Map<String,Decimal>();
        for(Account tempAcc : acc){
            nameOfAccountById.put(tempAcc.Id, tempAcc.Name);
            nameOfOpportunitiesById.put(tempAcc.Id, tempAcc.Opportunities);
            numberOfOpportunitiesById.put(tempAcc.Id, tempAcc.Opportunities.size());
        } 
        
    }
}