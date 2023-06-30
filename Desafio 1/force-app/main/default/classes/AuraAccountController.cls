public class AuraAccountController {
    @AuraEnabled
    public static Account DadosDaConta(String recordId){
        Account acc = [SELECT Id, Name, Type, AccountNumber FROM Account WHERE Id =:recordId];
        return acc;
    }
    
    @AuraEnabled
    public static string Salvar(String recordId, String accountNumber, String name, String type){
        
        try{
            Account acc = [SELECT Id, Name, Type, AccountNumber FROM Account WHERE Id =:recordId];
            acc.Name = name;
            acc.AccountNumber = accountNumber;
            acc.Type = type;
            
            update acc;
            
            return 'success';
        }
        catch(Exception dmlEX){
            String error = dmlEx.getMessage();
            boolean erroPorValidacao = error.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION');
            if(erroPorValidacao == true)
            {
                String textoInicial = 'FIELD_CUSTOM_VALIDATION_EXCEPTION, ';
                textoInicial = error.substring(0, error.indexOf('FIELD_CUSTOM_VALIDATION_EXCEPTION, ') + textoInicial.length());
                String textoFinal1 = ': [';
                String textoFinal2 = ']';
                String valorEntreColchetes = textoFinal1 + error.substringBetween(textoFinal1, textoFinal2) + textoFinal2;
                
                Integer indiceInicio = error.indexOf(textoInicial) + textoInicial.length();
                Integer indiceFinal = error.indexOf(valorEntreColchetes, indiceInicio);
                
                String valorExtraido = error.substring(indiceInicio, indiceFinal);
                
                error = error.replace(textoInicial + valorExtraido + valorEntreColchetes, valorExtraido);
                
                return 'validation '+ error;
            }
            
            return 'error';
            
        }
    }
}