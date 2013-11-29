package ${PACKAGE_HELPER};

import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

public abstract class PrepareStatementCuston<T> {
	
	public abstract PreparedStatement listar(String dbSchema, Class<T> model,
			DataSource dataSource) throws SQLException;

	public abstract PreparedStatement listar(String dbSchema, Class<T> model, Long pk,
			DataSource dataSource) throws SQLException;

	public abstract PreparedStatement listar(String dbSchema, T parameter,
			DataSource dataSource) throws SQLException;

	public abstract PreparedStatement inserir(String dbSchema, T parameter,
			DataSource dataSource) throws SQLException;

	public abstract PreparedStatement excluir(String dbSchema, Class<T> model,
			DataSource dataSource) throws SQLException;

	public abstract PreparedStatement excluir(String dbSchema, Class<T> model, Long pk,
			DataSource dataSource) throws SQLException;

	public abstract PreparedStatement excluir(String dbSchema, T parameter,
			DataSource dataSource) throws SQLException;

	public abstract PreparedStatement atualizar(String dbSchema, T setter, Long pk,
			DataSource dataSource) throws SQLException;

	public abstract PreparedStatement atualizar(String dbSchema, T filter, T setter,
			DataSource dataSource) throws SQLException;
}
