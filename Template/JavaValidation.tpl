package ${PACKAGE_VALIDATION};

import ${PACKAGE_FIELD}.ExecuteFieldBase;
import ${PACKAGE_MODEL}.${CLASS_MODEL};
import ${PACKAGE_EXCEPTION}.ValidationException;

public class ${CLASS_MODEL}Validation extends ExecuteFieldBase{

	public void execute() throws ValidationException {
		try {
			System.out.println("[" + System.currentTimeMillis() + "][begin]["
					+ this.getClass().getName() + "][" + "execute()" + "]");

			/************ADD SEU CÓDIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");
		} catch (Exception e) {
			throw new ValidationException("Chamada inválida.", e);
		}
	}

	public void execute(final Long pk) throws ValidationException {
		try {
			System.out.println("[" + System.currentTimeMillis() + "][begin]["
					+ this.getClass().getName() + "][" + "execute(Long)"
					+ "] pk=" + pk);

			/************ADD SEU CÓDIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");
		} catch (Exception e) {
			throw new ValidationException("Chamada inválida.", e);
		}
	}

	public void execute(final ${CLASS_MODEL} parameter) throws ValidationException {
		try {
			System.out.println("[" + System.currentTimeMillis() + "][begin]["
					+ this.getClass().getName() + "][" + "execute(${CLASS_MODEL})"
					+ "] parameter=" + parameter);

			super.execute(parameter);

			/************ADD SEU CÓDIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");

		} catch (Exception e) {
			throw new ValidationException("Chamada inválida.", e);
		}
	}

	public void execute(final Long pk, final ${CLASS_MODEL} setter)
			throws ValidationException {
		try {
			System.out.println("[" + System.currentTimeMillis() + "][begin]["
					+ this.getClass().getName() + "]["
					+ "execute(Long, ${CLASS_MODEL})" + "] pk=" + pk + ", setter="
					+ setter);

			super.execute(setter);

			/************ADD SEU CÓDIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");

		} catch (Exception e) {
			throw new ValidationException("Chamada inválida.", e);
		}
	}

	public void execute(final ${CLASS_MODEL} filter, final ${CLASS_MODEL} setter)
			throws ValidationException {
		try {
			System.out.println("[" + this.getClass().getName() + "]["
					+ "execute(${CLASS_MODEL}, ${CLASS_MODEL})" + "] filter=" + filter
					+ ", setter=" + setter);

			super.execute(filter);
			super.execute(setter);

			/************ADD SEU CÓDIGO AQUI************/
			
			/*******************************************/

			System.out.println("[" + System.currentTimeMillis() + "][end]");
		} catch (Exception e) {
			throw new ValidationException("Chamada inválida.", e);
		}
	}
}
