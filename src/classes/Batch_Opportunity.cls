global class Batch_Opportunity implements Database.Batchable <sObject> , Database.stateful {
   
    /****** Constructor ******/
    global Batch_Opportunity() {
    
    }

    //Method to get the data to be proceesed     
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([select Id, Name from Opportunity]);
    }
    
    //Method to execute the batch    
    global void execute(Database.BatchableContext BC, List<Opportunity> scope) {
        testController1.testMethod1();
        for(Opportunity opp : scope){
        
        }   
    }

    //Method to be called after the excute
    global void finish(Database.BatchableContext BC) { }
}