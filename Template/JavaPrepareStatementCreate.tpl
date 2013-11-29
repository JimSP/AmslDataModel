package ${PACKAGE};

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import ${PACKAGE_EXCEPTION}.DaoException;

import org.springframework.jdbc.core.PreparedStatementCreator;

import ${PACKAGE_MODEL}.${CLASS_MODEL};

public class ${CLASS_MODEL}PrepareStatement implements PreparedStatementCreator {

	private String sql;
	private ${CLASS_MODEL} ${OBJECT_NAME};

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public ${CLASS_MODEL}  get${CLASS_MODEL}() {
		return ${OBJECT_NAME};
	}

	public void set${CLASS_MODEL} (${CLASS_MODEL}  ${OBJECT_NAME}) {
		this.${OBJECT_NAME} = ${OBJECT_NAME};
	}

	public PreparedStatement createPreparedStatement(Connection connection)
			throws SQLException {

		PreparedStatement prepareStatement = connection.prepareStatement(sql);

		int i = 1;
${SETTER_PREPARE_STATEMENT}

		return prepareStatement;
	}
}
