package ${PACKAGE_SERVICE_WS};

import java.sql.SQLException;
import java.util.List;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

import ${PACKAGE_MODEL}.${CLASS_MODEL};
import ${PACKAGE_EXCEPTION}.RulesException;
import ${PACKAGE_EXCEPTION}.ValidationException;

@WebService(name = "${CLASS_MODEL}ServiceWS", targetNamespace = "http://${CLASS_MODEL}WS.spwservice.com.br/")
public interface I${CLASS_MODEL}ServiceWS {

	@WebMethod(operationName = "listarTodos")
	public abstract List<${CLASS_MODEL}> listarTodos() throws ValidationException,
			RulesException, SQLException;

	@WebMethod(operationName = "listarPorPk")
	public abstract ${CLASS_MODEL} listarPorPk(@WebParam(name = "pk") Long pk)
			throws ValidationException, RulesException, SQLException;

	@WebMethod(operationName = "listarPorFiltro")
	public abstract List<${CLASS_MODEL}> listarPorFiltro(
			@WebParam(name = "parameter") ${CLASS_MODEL} parameter)
			throws ValidationException, RulesException, SQLException;

	@WebMethod(operationName = "inserir")
	public abstract Long inserir(
			@WebParam(name = "parameter") ${CLASS_MODEL} parameter)
			throws ValidationException, RulesException, SQLException;

	@WebMethod(operationName = "inserirTodos")
	public abstract List<Long> inserirTodos(
			@WebParam(name = "parameter") List<${CLASS_MODEL}> parameter)
			throws ValidationException, RulesException, SQLException;

	@WebMethod(operationName = "excluirTodos")
	public abstract Integer excluirTodos() throws ValidationException,
			RulesException, SQLException;

	@WebMethod(operationName = "excluirPorPk")
	public abstract Boolean excluirPorPk(@WebParam(name = "pk") Long pk)
			throws ValidationException, RulesException, SQLException;

	@WebMethod(operationName = "excluirPorFiltro")
	public abstract Integer excluirPorFiltro(
			@WebParam(name = "parameter") ${CLASS_MODEL} parameter)
			throws ValidationException, RulesException, SQLException;

	@WebMethod(operationName = "atualizarPorFiltro")
	public abstract Integer atualizarPorFiltro(
			@WebParam(name = "filter") ${CLASS_MODEL} filter,
			@WebParam(name = "setter") ${CLASS_MODEL} setter)
			throws ValidationException, RulesException, SQLException;

	@WebMethod(operationName = "atualizarPorPk")
	public abstract Boolean atualizarPorPk(@WebParam(name = "pk") Long pk,
			@WebParam(name = "setter") ${CLASS_MODEL} setter)
			throws ValidationException, RulesException, SQLException;

}