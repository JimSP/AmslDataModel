package ${PACKAGE};

import model.${CLASS_NAME};
import ${EXCEPTION_PACKAGE}.RulesException;

public class ${CLASS_NAME}AfterRules{

	public void execute(${CLASS_NAME} result) throws RulesException{
		try{
			System.out.println("[" + System.currentTimeMillis() + "][begin][" + this.getClass().getName() + "][" + "execute(${CLASS_NAME})" + "] result=" + result);

			/************ADD SEU C�DIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");
		} catch(Exception e){
			throw new RulesException("Resultado n�o cumpre � regra", e);
		}
	}
}