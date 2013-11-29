package ${PACKAGE};

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import ${PACKAGE_MODEL}.${CLASS_MODEL};
import ${PACKAGE_RULES}.${CLASS_MODEL}AfterRules;
import ${PACKAGE_EXCEPTION}.RulesException;
import ${PACKAGE_EXCEPTION}.DaoException;


public class ${TABLE_NAME}Mapper implements RowMapper<${CLASS_MODEL}> {${INJECT_RULES}

${BODY}}