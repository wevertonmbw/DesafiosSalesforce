@IsTest
public class TestTriggerAccountHandler {
    @IsTest
    static void TestValidarAccountNumberValid(){
        Id parceiroRecordType = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
        
        List<Account> lstNewAccs = new List<Account>();
        
        Account acc = new Account();
        acc.RecordTypeId = parceiroRecordType;
        acc.Name = 'Teste Numero Valido';
        acc.AccountNumber = '28.302.219/0001-64'; // numero gerado a partir de 4devs.com.br
        lstNewAccs.add(acc);
        
        Boolean hasError = false;
        String errorMessage = null;
        try{
        	insert lstNewAccs;
            update lstNewAccs;
        }
        catch(Exception e){
            hasError = true;
            errorMessage = e.getMessage();
        }
        
        System.assert(!hasError, 'No error is expected');
        System.assert(errorMessage == null, 'Test Success - Valid data');
    }
    
    @IsTest
    static void TestValidarAccountNumberInvalid(){
        Id parceiroRecordType = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
        
        List<Account> lstNewAccs = new List<Account>();
        
        Account acc = new Account();
        acc.RecordTypeId = parceiroRecordType;
        acc.Name = 'Teste Numero Invalido';
        acc.AccountNumber = '2255533300001';
        lstNewAccs.add(acc);
        
        Boolean hasError = false;
        String errorMessage = null;
        try{
        	insert lstNewAccs;
        }
        catch(Exception e){
            hasError = true;
            errorMessage = e.getMessage();
        }
        
        System.assert(hasError, 'One error is expected');
        System.assert(errorMessage.contains('Número do cliente é inválido'), 'Test Success - Invalid data');
    }
    
    @IsTest
    static void TestTipoAccountParceiro(){
        Id parceiroRecordType = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
        
        List<Account> lstNewAccs = new List<Account>();
        
        Account acc = new Account();
        acc.RecordTypeId = parceiroRecordType;
        acc.Name = 'Teste Parceiro';
        acc.AccountNumber = '28.302.219/0001-64'; // numero gerado a partir de 4devs.com.br
        lstNewAccs.add(acc);
        
        insert lstNewAccs;
    }
    
    @IsTest
    static void TestTipoAccountConsumidorFinal(){
        Id consumidorFinalRecordType = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumidor_final').getRecordTypeId();
        
        List<Account> lstNewAccs = new List<Account>();
        
        Account acc = new Account();
        acc.RecordTypeId = consumidorFinalRecordType;
        acc.Name = 'Teste Consumidor Final';
        acc.AccountNumber = '255.604.450-02'; // numero gerado a partir de 4devs.com.br
        lstNewAccs.add(acc);
        
        insert lstNewAccs;
    }
}