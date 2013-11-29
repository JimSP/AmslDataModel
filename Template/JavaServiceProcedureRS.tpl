package ${PACKAGE_SERVICE};

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;

import org.springframework.stereotype.Service;

import java.util.List;
import java.sql.SQLException;

import ${PACKAGE_DAO}.${CLASS_DAO}Dao;
${CONDITION_IMPORT}

@Service("${CLASS_DAO}ServiceRS")
@Path("${CLASS_DAO}ServiceRS")
public class ${CLASS_DAO}ServiceRS{

	private ${CLASS_DAO}Dao ${OBJECT_NAME}Dao;

	public ${CLASS_DAO}Dao get${CLASS_DAO}Dao(){
		return ${OBJECT_NAME}Dao;
	}

	public void set${CLASS_DAO}Dao(${CLASS_DAO}Dao ${OBJECT_NAME}Dao){
		this.${OBJECT_NAME}Dao = ${OBJECT_NAME}Dao;
	}

	@GET
	@POST
	@Consumes({"application/json", "application/xml"})
	@Produces({"application/json", "application/xml"})
	public ${CURSOR} ${METHOD_NAME}(${SERVICE_PARAMETERS}) 
		throws SQLException{
		${CONDITION_CURSOR} ${OBJECT_NAME}Dao.${CONDITION_METHOD}(${PARAMETERS_DAO});
	}
}