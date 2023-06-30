global class BatchContasInativas implements Database.Batchable<SObject>, Schedulable {
    String query;
    
    public BatchContasInativas() {
        query = 'SELECT Id, Inativa__c FROM Account WHERE Inativa__c = false';
    }
    
    public BatchContasInativas(String id) {
        query = 'SELECT Id, Inativa__c FROM Account WHERE Inativa__c = false AND Id = \''+id+'\'';
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(SchedulableContext SC) {
        BatchContasInativas bc = new BatchContasInativas();
        Database.executeBatch(bc, 1);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> lstAccounts) {
        
        System.debug(lstAccounts);
        Set<Id> idsAccs = new Set<Id>();
        Set<Id> idsAccsForNotBatch = new Set<Id>();
        
        for(Account acc : lstAccounts){
            idsAccs.add(acc.Id);
        }
        
        Date last120Days = Date.today() - 120;
        List<Opportunity> oppsWinsInLast120Days = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :idsAccs AND StageName = 'Closed Won' AND IsClosed = true AND CloseDate < :last120Days];
        for(Opportunity opp : oppsWinsInLast120Days){
            idsAccsForNotBatch.add(opp.AccountId);
        }
        
        List<Opportunity> oppsInNegotiation = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :idsAccs AND StageName = 'Negotiation/Review'];
        for(Opportunity opp : oppsInNegotiation){
            idsAccsForNotBatch.add(opp.AccountId);
        }
        
        Date last90Days = Date.today() - 90;
        List<Task> tasksInLast90Days = [SELECT Id, WhatId FROM Task WHERE WhatId IN :idsAccs AND CreatedDate < :last90Days];
        for(Task task : tasksInLast90Days){
            idsAccsForNotBatch.add(task.WhatId);
        }
        
        List<Account> finalLstAccounts = new List<Account>(); 
        
        for(Account acc : lstAccounts){
            System.debug(!idsAccsForNotBatch.contains(acc.Id));
            if(!idsAccsForNotBatch.contains(acc.Id)){
                finalLstAccounts.add(acc);
            }
        }
        
        for(Account acc : finalLstAccounts){
            acc.Inativa__c = true;
        }
        
        update finalLstAccounts;
        
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}