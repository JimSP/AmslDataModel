package ${PACKAGE_RULES};

import ${PACKAGE_MODEL}.${CLASS_MODEL};
import ${PACKAGE_EXCEPTION}.RulesException;

public class ${CLASS_MODEL}Rules{

	public void execute() throws RulesException{
		try{
		System.out.println("[" + System.currentTimeMillis() + "][begin][" + this.getClass().getName() + "][" + "execute()" + "]");
		/************ADD SEU CÓDIGO AQUI************/
		
		/*******************************************/

		System.out.println("[" + System.currentTimeMillis() + "][end]");
		} catch(Exception e){
			throw new RulesException("Regra não cumprida.", e);
		}
	}

	public Long execute(Long pk) throws RulesException{
		try{
		System.out.println("[" + System.currentTimeMillis() + "][begin][" + this.getClass().getName() + "][" + "execute(Long)" + "] pk=" + pk);
		/************ADD SEU CÓDIGO AQUI************/
		
		/*******************************************/

		System.out.println("[" + System.currentTimeMillis() + "][end]");
		return pk;
		} catch(Exception e){
			throw new RulesException("Regra não cumprida.", e);
		}
	}

	public void execute(${CLASS_MODEL} parameter) throws RulesException{
		try{
			System.out.println("[" + System.currentTimeMillis() + "][begin][" + this.getClass().getName() + "][" + "execute(${CLASS_MODEL})" + "] parameter=" + parameter);
			/************ADD SEU CÓDIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");
		} catch(Exception e){
			throw new RulesException("Regra não cumprida.", e);
		}
	}

	public Long execute(Long pk, ${CLASS_MODEL} setter) throws RulesException{
		try{
			System.out.println("[" + System.currentTimeMillis() + "][begin][" + this.getClass().getName() + "][" + "execute(Long, ${CLASS_MODEL})" + "] pk=" + pk + ", setter=" + setter);
			/************ADD SEU CÓDIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");
			return pk;
		} catch(Exception e){
			throw new RulesException("Regra não cumprida.", e);
		}
	}

	public void execute(${CLASS_MODEL} filter, ${CLASS_MODEL} setter) throws RulesException{
		try{
			System.out.println("[" + System.currentTimeMillis() + "][begin][" + this.getClass().getName() + "][" + "execute(${CLASS_MODEL}, ${CLASS_MODEL})" + "] filter=" + filter + ", setter=" + setter);
			/************ADD SEU CÓDIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");
		} catch(Exception e){
			throw new RulesException("Regra não cumprida.", e);
		}
	}
}