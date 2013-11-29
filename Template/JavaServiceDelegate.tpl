package delegate;

import ${PACKAGE_RULES}.${CLASS_MODEL}Rules;
import ${PACKAGE_VALIDATION}.${CLASS_MODEL}Validation;
import ${PACKAGE_MODEL}.${CLASS_MODEL};
import ${PACKAGE_EXCEPTION}.RulesException;
import ${PACKAGE_EXCEPTION}.ValidationException;

public class ${CLASS_MODEL}ServiceDelegate implements IServiceDelegate<${CLASS_MODEL}> {
	
	private ${CLASS_MODEL}Validation ${OBJECT_NAME}Validation;
	private ${CLASS_MODEL}Rules ${OBJECT_NAME}Rules;

	public ${CLASS_MODEL}Validation get${CLASS_MODEL}Validation(){
		return ${OBJECT_NAME}Validation;
	}

	public void set${CLASS_MODEL}Validation(${CLASS_MODEL}Validation ${OBJECT_NAME}Validation){
		this.${OBJECT_NAME}Validation = ${OBJECT_NAME}Validation;
	}

	public ${CLASS_MODEL}Rules get${CLASS_MODEL}Rules(){
		return ${OBJECT_NAME}Rules;
	}

	public void set${CLASS_MODEL}Rules(${CLASS_MODEL}Rules ${OBJECT_NAME}Rules){
		this.${OBJECT_NAME}Rules = ${OBJECT_NAME}Rules;
	}

	public void validarEVerificar() throws ValidationException, RulesException {

		if (${OBJECT_NAME}Validation != null)
			${OBJECT_NAME}Validation.execute();

		if (${OBJECT_NAME}Rules != null)
			${OBJECT_NAME}Rules.execute();
	}

	public Long validarEVerificar(Long pk) throws ValidationException,
			RulesException {

		if (${OBJECT_NAME}Validation != null)
			${OBJECT_NAME}Validation.execute(pk);

		if (${OBJECT_NAME}Rules != null)
			pk = ${OBJECT_NAME}Rules.execute(pk);

		return pk;
	}

	public void validarEVerificar(${CLASS_MODEL} parameter)
			throws ValidationException, RulesException {

		if (${OBJECT_NAME}Validation != null)
			${OBJECT_NAME}Validation.execute(parameter);

		if (${OBJECT_NAME}Rules != null)
			${OBJECT_NAME}Rules.execute(parameter);
	}

	public Long validarEVerificar(Long pk, ${CLASS_MODEL} setter)
			throws ValidationException, RulesException {

		if (${OBJECT_NAME}Validation != null)
			${OBJECT_NAME}Validation.execute(pk, setter);

		if (${OBJECT_NAME}Rules != null)
			pk = ${OBJECT_NAME}Rules.execute(pk, setter);

		return pk;
	}

	public void validarEVerificar(${CLASS_MODEL} filter, ${CLASS_MODEL} setter)
			throws ValidationException, RulesException {

		if (${OBJECT_NAME}Validation != null)
			${OBJECT_NAME}Validation.execute(filter, setter);

		if (${OBJECT_NAME}Rules != null)
			${OBJECT_NAME}Rules.execute(filter, setter);
	}
}
