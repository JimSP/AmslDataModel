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
import ${PACKAGE_VALIDATION}.${CLASS_MODEL}Validation;
import ${PACKAGE_RULES}.${CLASS_MODEL}Rules;
import ${PACKAGE_DAO}.${CLASS_MODEL}Dao;
import ${PACKAGE_EXCEPTION}.RulesException;
import ${PACKAGE_EXCEPTION}.ValidationException;

@Service("${CLASS_MODEL}ServiceRS")
@Path("${CLASS_MODEL}ServiceRS")
public interface I${CLASS_MODEL}ServiceRS{

	@GET
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public List<${CLASS_MODEL}> listarTodos() 
		throws ValidationException, RulesException, SQLException;

	@GET
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public ${CLASS_MODEL} listarPorPk(@PathParam("pk") Long pk)
		throws ValidationException, RulesException, SQLException;

	@GET
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public List<${CLASS_MODEL}> listarPorFiltro(@BeanParam ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException;

	@POST
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Long inserir(@BeanParam ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException;

	@POST
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public List<Long> inserirTodos(@BeanParam List<${CLASS_MODEL}> parameter)
		throws ValidationException, RulesException, SQLException;

	@DELETE
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Integer excluirTodos()
		throws ValidationException, RulesException, SQLException;

	@DELETE
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Boolean excluirPorPk(@PathParam("pk") Long pk)
		throws ValidationException, RulesException, SQLException;

	@DELETE
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Integer excluirPorFiltro(@BeanParam ${CLASS_MODEL} parameter)
		throws ValidationException, RulesException, SQLException;

	@PUT
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Integer atualizarPorFiltro(@BeanParam ${CLASS_MODEL} filter, @BeanParam ${CLASS_MODEL} setter)
		throws ValidationException, RulesException, SQLException;

	@PUT
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public Boolean atualizarPorPk(@BeanParam Long pk, @BeanParam ${CLASS_MODEL} setter)
		throws ValidationException, RulesException, SQLException;
}