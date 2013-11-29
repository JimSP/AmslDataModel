package ${PACKAGE_SERVICE_WS};

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

import java.util.List;
import java.sql.SQLException;

import ${PACKAGE_MODEL}.${CLASS_MODEL};
import ${PACKAGE_DELEGATE}.IServiceDelegate;
import ${PACKAGE_DAO}.ICRUD;
import ${PACKAGE_EXCEPTION}.RulesException;
import ${PACKAGE_EXCEPTION}.ValidationException;

@WebService(name = "${CLASS_MODEL}ServiceWS", targetNamespace = "http://${CLASS_MODEL}WS.spwservice.com.br/")
public class ${CLASS_MODEL}ServiceWS implements I${CLASS_MODEL}ServiceWS{

	private ICRUD<${CLASS_MODEL}> ${OBJECT_NAME}CrudDao;
	private IServiceDelegate<${CLASS_MODEL}> ${OBJECT_NAME}ServiceDelegate;

	@WebMethod(exclude=true)
	public ICRUD<${CLASS_MODEL}> get${CLASS_MODEL}CrudDao(){
		return ${OBJECT_NAME}CrudDao;
	}

	@WebMethod(exclude=true)
	public void set${CLASS_MODEL}CrudDao(ICRUD<${CLASS_MODEL}> ${OBJECT_NAME}CrudDao){
		this.${OBJECT_NAME}CrudDao = ${OBJECT_NAME}CrudDao;
	}

	@WebMethod(exclude=true)
	public IServiceDelegate<${CLASS_MODEL}> get${CLASS_MODEL}ServiceDelegate(){
		return ${OBJECT_NAME}ServiceDelegate;
	}

	@WebMethod(exclude=true)
	public void set${CLASS_MODEL}ServiceDelegate(IServiceDelegate<${CLASS_MODEL}> ${OBJECT_NAME}ServiceDelegate){
		this.${OBJECT_NAME}ServiceDelegate = ${OBJECT_NAME}ServiceDelegate;
	}

	@WebMethod(operationName = "listarTodos")
	public List<${CLASS_MODEL}> listarTodos() 
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar();

		return ${OBJECT_NAME}CrudDao.listar();
	}

	@WebMethod(operationName = "listarPorPk")
	public ${CLASS_MODEL} listarPorPk(@WebParam(name = "pk") Long pk)
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			pk = ${OBJECT_NAME}ServiceDelegate.validarEVerificar(pk);

		return ${OBJECT_NAME}CrudDao.listar(pk);
	}

	@WebMethod(operationName = "listarPorFiltro")
	public List<${CLASS_MODEL}> listarPorFiltro(@WebParam(name = "parameter") ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar(parameter);

		return ${OBJECT_NAME}CrudDao.listar(parameter);
	}

	@WebMethod(operationName = "inserir")
	public Long inserir(@WebParam(name = "parameter") ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar(parameter);

		return ${OBJECT_NAME}CrudDao.inserir(parameter);
	}

	@WebMethod(operationName = "inserirTodos")
	public List<Long> inserirTodos(@WebParam(name = "parameter") List<${CLASS_MODEL}> parameter)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			for (${CLASS_MODEL} model : parameter) {
				${OBJECT_NAME}ServiceDelegate.validarEVerificar(model);
			}

		return ${OBJECT_NAME}CrudDao.inserir(parameter);
	}

	@WebMethod(operationName = "excluirTodos")
	public Integer excluirTodos()
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar();

		return ${OBJECT_NAME}CrudDao.excluir();
	}

	@WebMethod(operationName = "excluirPorPk")
	public Boolean excluirPorPk(@WebParam(name = "pk") Long pk)
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			pk = ${OBJECT_NAME}ServiceDelegate.validarEVerificar(pk);

		return ${OBJECT_NAME}CrudDao.excluir(pk);
	}

	@WebMethod(operationName = "excluirPorFiltro")
	public Integer excluirPorFiltro(@WebParam(name = "parameter") ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar(parameter);

		return ${OBJECT_NAME}CrudDao.excluir(parameter);
	}

	@WebMethod(operationName = "atualizarPorFiltro")
	public Integer atualizarPorFiltro(@WebParam(name = "filter") ${CLASS_MODEL} filter, @WebParam(name = "setter") ${CLASS_MODEL} setter)
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar(filter, setter);

		return ${OBJECT_NAME}CrudDao.atualizar(filter, setter);
	}

	@WebMethod(operationName = "atualizarPorPk")
	public Boolean atualizarPorPk(@WebParam(name = "pk") Long pk, @WebParam(name = "setter") ${CLASS_MODEL} setter)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			pk = ${OBJECT_NAME}ServiceDelegate.validarEVerificar(pk, setter);

		return ${OBJECT_NAME}CrudDao.atualizar(pk, setter);
	}
}