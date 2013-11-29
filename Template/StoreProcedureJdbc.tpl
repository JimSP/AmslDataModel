package ${PACKAGE_NAME};

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;

import java.util.List;

import ${PACKAGE_MAPPER}.${ROW}Mapper;
import ${PACKAGE_MODEL}.${ROW};

public class Call${SP_NAME}Dao extends JdbcTemplate{


	private static final String SQL = "call ${SP_CALLABLE};";
	private ${ROW}Mapper mapper;

	public ${ROW}Mapper getMapper() {
		return mapper;
	}

	public void setMapper(${ROW}Mapper mapper) {
		this.mapper = mapper;
	}

	public Call${SP_NAME}Dao(DataSource dataSource){
		super(dataSource);
	}
	
	${CONDITION_METHOD}
}