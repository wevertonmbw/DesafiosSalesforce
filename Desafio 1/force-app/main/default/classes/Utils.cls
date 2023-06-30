public class Utils {

    public static Boolean ValidaCPF(String cpf) {
        
        cpf = cpf.replaceAll('[^0-9]', '');
        if (cpf == null || cpf.length() != 11) {
            return false;
        }
        
        Integer digito1 = Integer.valueOf(cpf.substring(9, 10));
        Integer digito2 = Integer.valueOf(cpf.substring(10));
        
        Integer soma = 0;
        
        for (Integer i = 0; i < 9; i++) {
            Integer num = Integer.valueOf(cpf.substring(i, i + 1));
            soma += num * (10 - i);
        }
        
        Integer resto = Math.mod(soma, 11);
        Integer digitoVerificador1 = resto < 2 ? 0 : 11 - resto;
        
        soma = 0;
        
        for (Integer i = 0; i < 10; i++) {
            Integer num = Integer.valueOf(cpf.substring(i, i + 1));
            soma += num * (11 - i);
        }
        
        resto = Math.mod(soma, 11);
        Integer digitoVerificador2 = resto < 2 ? 0 : 11 - resto;
        
        return digitoVerificador2 == digito2 && digitoVerificador1 == digito1;
    }
    
    public static Boolean ValidaCNPJ(String cnpj) {
        
        cnpj = cnpj.replaceAll('[^0-9]', '');
        if (cnpj == null || cnpj.length() != 14) {
        	return false;
        }
        
        Integer digito1 = Integer.valueOf(cnpj.substring(12, 13));
        Integer digito2 = Integer.valueOf(cnpj.substring(13));
        
        Integer soma = 0;
        Integer peso = 2;
        
        for (Integer i = 11; i >= 0; i--) {
            Integer num = Integer.valueOf(cnpj.substring(i, i + 1));
            soma += num * peso;
            
            peso++;
            if (peso > 9) {
                peso = 2;
            }
        }
        
        Integer resto = Math.mod(soma, 11);
        Integer digitoVerificador1 = resto < 2 ? 0 : 11 - resto;
        
        soma = 0;
        peso = 2;
        
        for (Integer i = 12; i >= 0; i--) {
            Integer num = Integer.valueOf(cnpj.substring(i, i + 1));
            soma += num * peso;
            
            peso++;
            if (peso > 9) {
                peso = 2;
            }
        }
        
        resto = Math.mod(soma, 11);
        Integer digitoVerificador2 = resto < 2 ? 0 : 11 - resto;
        
        return digitoVerificador2 == digito2  && digitoVerificador1 == digito1;
    }
   
}