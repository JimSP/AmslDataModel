package ${PACKAGE_SERVICE};

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

import java.util.List;
import java.sql.SQLException;

import ${PACKAGE_DAO}.${CLASS_DAO}Dao;
${CONDITION_IMPORT}

@WebService(name = "${CLASS_DAO}ServiceWS", targetNamespace = "http://${CLASS_DAO}WS.spwservice.com.br/")
public class ${CLASS_DAO}ServiceWS{

	private ${CLASS_DAO}Dao ${OBJECT_NAME}Dao;

	@WebMethod(exclude=true)
	public ${CLASS_DAO}Dao get${CLASS_DAO}Dao(){
		return ${OBJECT_NAME}Dao;
	}

	@WebMethod(exclude=true)
	public void set${CLASS_DAO}Dao(${CLASS_DAO}Dao ${OBJECT_NAME}Dao){
		this.${OBJECT_NAME}Dao = ${OBJECT_NAME}Dao;
	}


	@WebMethod(operationName = "${METHOD_NAME}")
	public ${CURSOR} ${METHOD_NAME}(${SERVICE_PARAMETERS}) 
		throws SQLException{
		${CONDITION_CURSOR} ${OBJECT_NAME}Dao.${CONDITION_METHOD}(${PARAMETERS_DAO});
	}
}