package ${PACKAGE_DELEGATE};

import ${PACKAGE_EXCEPTION}.RulesException;
import ${PACKAGE_EXCEPTION}.ValidationException;

public interface IServiceDelegate<T> {

	public void validarEVerificar() throws ValidationException, RulesException;

	public Long validarEVerificar(Long pk) throws ValidationException,
			RulesException;

	public void validarEVerificar(T parameter) throws ValidationException,
			RulesException;

	public Long validarEVerificar(Long pk, T setter)
			throws ValidationException, RulesException;

	public void validarEVerificar(T filter, T setter)
			throws ValidationException, RulesException;
}