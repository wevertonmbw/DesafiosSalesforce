public class TriggerAccountHandler {
    
    public static void ValidarAccountNumber(){
        
        List<Account> accounts = Trigger.new;
        
        for(Account acc: accounts){
            if(acc.AccountNumber != null){
                if(!Utils.ValidaCPF(acc.AccountNumber) && !Utils.ValidaCNPJ(acc.AccountNumber)){
                    acc.AccountNumber.addError('Número do cliente é inválido');
                }
            }
        }
    }
    
    public static void TipoAccountParceiro(){
        
        List<Account> accounts = Trigger.new;
        
        List<Opportunity> lstNewOpps = new List<Opportunity>();
        
        Id parceiroRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
    
        for(Account acc: accounts){
            if(acc.RecordTypeId == parceiroRecordTypeId){
                Opportunity newOpp = new Opportunity();
                newOpp.AccountId = acc.Id;
                newOpp.Name = acc.Name + ' - opp Parceiro';
                newOpp.StageName = 'Qualification';
                newOpp.CloseDate = Date.today() + 30;
                lstNewOpps.add(newOpp);
            }
        }
        
        if(lstNewOpps.size() > 0) {
        	insert lstNewOpps;
        }
    }
    
    public static void TipoAccountConsumidorFinal(){
        
        List<Account> accounts = Trigger.new;
       
        List<Task> lstNewTasks = new List<Task>();
        
        Id consumidorFinalRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumidor_final').getRecordTypeId();

        for(Account acc: accounts){
            if(acc.RecordTypeId == consumidorFinalRecordTypeId){
                Task newTask = new Task();
                newTask.WhatId = acc.Id;
                newTask.Subject = 'Consumidor Final';
                newTask.Status = 'Not Started';
                newTask.Priority = 'Normal';
                lstNewTasks.add(newTask);
            }
        }
        
        if(lstNewTasks.size() > 0) {
        	insert lstNewTasks;
        }
    }
    
}