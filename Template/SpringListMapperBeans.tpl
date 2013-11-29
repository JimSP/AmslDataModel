package ${PACKAGE};

import java.sql.ResultSet;
import java.sql.SQLException;
import ${PACKAGE_EXCEPTION}.DaoException;


import ${PACKAGE_MODEL}.${CLASS_MODEL};

public class ${CLASS_MODEL}ListMapper extends ListModelRowMapper<${CLASS_MODEL}> {

	private ${CLASS_MODEL}Mapper rowMapper;

	${BODY}

}