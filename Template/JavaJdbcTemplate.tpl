package ${PACKAGE_DAO};

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.support.GeneratedKeyHolder;

import ${PACKAGE_MAPPER}.${CLASS_MODEL}Mapper;
import ${PACKAGE_MODEL}.${CLASS_MODEL};
import ${PACKAGE_HELPER}.PrepareStatementCuston;

import ${PACKAGE_EXCEPTION}.DaoException;

public class ${CLASS_MODEL}Dao extends JdbcTemplate implements ICRUD<${CLASS_MODEL}> {

	private String dbSchema;
	private ${CLASS_MODEL}Mapper mapper;
	private PrepareStatementCuston<${CLASS_MODEL}> psc;

	public ${CLASS_MODEL}Mapper get${CLASS_MODEL}Mapper(){
		return mapper;
	}

	public void set${CLASS_MODEL}Mapper(${CLASS_MODEL}Mapper mapper){
		this.mapper = mapper;
	}

	public PrepareStatementCuston<${CLASS_MODEL}> getPsc(){
		return psc;
	}

	public void setPsc(PrepareStatementCuston<${CLASS_MODEL}> psc){
		this.psc = psc;
	}

	public ${CLASS_MODEL}Dao(DataSource dataSource) {
		super(dataSource);
		this.dbSchema = "amsl";
	}

	public List<${CLASS_MODEL}> listar() {

		return query(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(
					Connection connection) throws SQLException {

				try {
					return psc.listar(dbSchema, ${CLASS_MODEL}.class, ${CLASS_MODEL}Dao.this.getDataSource());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					throw new DaoException(e);
				} catch (SecurityException e) {
					e.printStackTrace();
					throw new DaoException(e);
				}
			}
		}, mapper);
	}

	public ${CLASS_MODEL} listar(final Long pk) {

		return query(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(
					Connection connection) throws SQLException {

				try {
					return psc.listar(dbSchema, ${CLASS_MODEL}.class, pk, ${CLASS_MODEL}Dao.this.getDataSource());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					throw new DaoException(e);
				} catch (SecurityException e) {
					e.printStackTrace();
					throw new DaoException(e);
				}
			}
		}, new ResultSetExtractor<${CLASS_MODEL}>() {

			public ${CLASS_MODEL} extractData(ResultSet rs) throws SQLException,
					DataAccessException {

				return mapper.mapRow(rs, 1);
			}
		});
	}

	public List<${CLASS_MODEL}> listar(final ${CLASS_MODEL} parameter) {

		return query(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(
					Connection connection) throws SQLException {

				try {
					return psc.listar(dbSchema, parameter, ${CLASS_MODEL}Dao.this.getDataSource());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					throw new DaoException(e);
				} catch (SecurityException e) {
					e.printStackTrace();
					throw new DaoException(e);
				}
			}
		}, new ${CLASS_MODEL}Mapper());
	}

	public Long inserir(final ${CLASS_MODEL} parameter) {

		GeneratedKeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(
					Connection connection) throws SQLException {

				try {
					return psc.inserir(dbSchema, parameter, ${CLASS_MODEL}Dao.this.getDataSource());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					throw new DaoException(e);
				} catch (SecurityException e) {
					e.printStackTrace();
					throw new DaoException(e);
				}
			}
		}, generatedKeyHolder);
		return generatedKeyHolder.getKey().longValue();
	}

	public List<Long> inserir(final List<${CLASS_MODEL}> parameter) {
		
		final List<Long> list = new ArrayList<Long>();
		for (${CLASS_MODEL} model : parameter) {
			list.add(inserir(model));
		}
		return list;
	}

	public Integer excluir() {

		return update(new PreparedStatementCreator() {
			
			public PreparedStatement createPreparedStatement(Connection connection)
					throws SQLException {

				return psc.excluir(dbSchema, ${CLASS_MODEL}.class, ${CLASS_MODEL}Dao.this.getDataSource());
			}
		});
	}

	public Boolean excluir(final Long pk) {

		int rowCount = update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection)
					throws SQLException {

				return psc.excluir(dbSchema, ${CLASS_MODEL}.class, pk, ${CLASS_MODEL}Dao.this.getDataSource());
			}
		});
		
		return rowCount > 0;
	}

	public Integer excluir(final ${CLASS_MODEL} parameter) {
		int rowCount = update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection)
					throws SQLException {

				try {
					return psc.excluir(dbSchema, parameter, ${CLASS_MODEL}Dao.this.getDataSource());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					throw new DaoException(e);
				} catch (SecurityException e) {
					e.printStackTrace();
					throw new DaoException(e);
				}
			}
		});
		
		return rowCount;
	}

	public Boolean atualizar(final Long pk, final ${CLASS_MODEL} setter) {
		int rowCount = update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection)
					throws SQLException {

				try {
					return psc.atualizar(dbSchema, setter, pk, ${CLASS_MODEL}Dao.this.getDataSource());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					throw new DaoException(e);
				} catch (SecurityException e) {
					e.printStackTrace();
					throw new DaoException(e);
				}
			}
		});
		
		return rowCount > 0;
	}

	public Integer atualizar(final ${CLASS_MODEL} filter, final ${CLASS_MODEL} setter) {
		int rowCount = update(new PreparedStatementCreator() {

			public PreparedStatement createPreparedStatement(Connection connection)
					throws SQLException {

				try {
					return psc.atualizar(dbSchema, setter, filter, ${CLASS_MODEL}Dao.this.getDataSource());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					throw new DaoException(e);
				} catch (SecurityException e) {
					e.printStackTrace();
					throw new DaoException(e);
				}
			}
		});
		
		return rowCount;
	}
}