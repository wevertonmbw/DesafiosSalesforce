trigger TriggerAccount on Account (before insert, after insert, before update) {

    if(Trigger.isBefore && Trigger.isInsert){
        TriggerAccountHandler.ValidarAccountNumber();
    }
    
    if(Trigger.isAfter && Trigger.isInsert){
        TriggerAccountHandler.TipoAccountParceiro();
        TriggerAccountHandler.TipoAccountConsumidorFinal();
    }  

    if(Trigger.isBefore && Trigger.isUpdate){
        TriggerAccountHandler.ValidarAccountNumber();
    }   
    
}