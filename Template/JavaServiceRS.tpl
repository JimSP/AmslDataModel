package ${PACKAGE_SERVICE_RS};

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.BeanParam;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;

import org.springframework.stereotype.Service;

import java.util.List;
import java.sql.SQLException;

import ${PACKAGE_MODEL}.${CLASS_MODEL};
import ${PACKAGE_DELEGATE}.IServiceDelegate;
import ${PACKAGE_DAO}.ICRUD;
import ${PACKAGE_EXCEPTION}.RulesException;
import ${PACKAGE_EXCEPTION}.ValidationException;

@Service("${CLASS_MODEL}ServiceRS")
@Path("${CLASS_MODEL}ServiceRS")
public class ${CLASS_MODEL}ServiceRS implements I${CLASS_MODEL}ServiceRS{

	private ICRUD<${CLASS_MODEL}> ${OBJECT_NAME}CrudDao;
	private IServiceDelegate<${CLASS_MODEL}> ${OBJECT_NAME}ServiceDelegate;

	public ICRUD<${CLASS_MODEL}> get${CLASS_MODEL}CrudDao(){
		return ${OBJECT_NAME}CrudDao;
	}

	public void set${CLASS_MODEL}CrudDao(ICRUD<${CLASS_MODEL}> ${OBJECT_NAME}CrudDao){
		this.${OBJECT_NAME}CrudDao = ${OBJECT_NAME}CrudDao;
	}

	public IServiceDelegate<${CLASS_MODEL}> get${CLASS_MODEL}ServiceDelegate(){
		return ${OBJECT_NAME}ServiceDelegate;
	}

	public void set${CLASS_MODEL}ServiceDelegate(IServiceDelegate<${CLASS_MODEL}> ${OBJECT_NAME}ServiceDelegate){
		this.${OBJECT_NAME}ServiceDelegate = ${OBJECT_NAME}ServiceDelegate;
	}

	@GET
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public List<${CLASS_MODEL}> listarTodos() 
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar();

		return ${OBJECT_NAME}CrudDao.listar();
	}

	@GET
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public ${CLASS_MODEL} listarPorPk(@PathParam("pk") Long pk)
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			pk = ${OBJECT_NAME}ServiceDelegate.validarEVerificar(pk);

		return ${OBJECT_NAME}CrudDao.listar(pk);
	}

	@GET
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public List<${CLASS_MODEL}> listarPorFiltro(@BeanParam ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException{

		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar(parameter);

		return ${OBJECT_NAME}CrudDao.listar(parameter);
	}

	@POST
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Long inserir(@BeanParam ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar(parameter);

		return ${OBJECT_NAME}CrudDao.inserir(parameter);
	}

	@POST
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public List<Long> inserirTodos(@BeanParam List<${CLASS_MODEL}> parameter)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			for (${CLASS_MODEL} model : parameter) {
				${OBJECT_NAME}ServiceDelegate.validarEVerificar(model);
			}

		return ${OBJECT_NAME}CrudDao.inserir(parameter);
	}

	@DELETE
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Integer excluirTodos()
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar();

		return ${OBJECT_NAME}CrudDao.excluir();
	}

	@DELETE
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Boolean excluirPorPk(@PathParam("pk") Long pk)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			pk = ${OBJECT_NAME}ServiceDelegate.validarEVerificar(pk);

		return ${OBJECT_NAME}CrudDao.excluir(pk);
	}

	@DELETE
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Integer excluirPorFiltro(@BeanParam ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar(parameter);

		return ${OBJECT_NAME}CrudDao.excluir(parameter);
	}

	@PUT
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Integer atualizarPorFiltro(@BeanParam ${CLASS_MODEL} filter, @BeanParam ${CLASS_MODEL} setter)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			${OBJECT_NAME}ServiceDelegate.validarEVerificar(filter, setter);

		return ${OBJECT_NAME}CrudDao.atualizar(filter, setter);
	}

	@PUT
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Boolean atualizarPorPk(@PathParam("pk") Long pk, @BeanParam ${CLASS_MODEL} setter)
		throws ValidationException, RulesException, SQLException{
		
		if(${OBJECT_NAME}ServiceDelegate != null)
			pk = ${OBJECT_NAME}ServiceDelegate.validarEVerificar(pk, setter);

		return ${OBJECT_NAME}CrudDao.atualizar(pk, setter);
	}
}