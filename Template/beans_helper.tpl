package helper;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import exception.DaoException;

public class PrepareStatementCreate<T> extends PrepareStatementCuston<T> {

	private static final String LISTAR_TODOS = "SELECT ${TABLE}.${FIELDS} FROM ${SCHEMA}.${TABLE} ORDER BY ${ORDER}";
	private static final String LISTAR_PK = "SELECT ${TABLE}.${FIELDS} FROM ${SCHEMA}.${TABLE} WHERE ${TABLE}.${PK} = ?";
	private static final String LISTAR_FILTRO = "SELECT ${TABLE}.${FIELDS} FROM ${SCHEMA}.${TABLE}  WHERE ${FILTERS} ORDER BY ${ORDER}";

	private static final String INSERIR = "INSERT INTO ${SCHEMA}.${TABLE}(${FIELDS}) VALUES(${VALUES})";
	private static final String INSERIR_TODOS = "INSERT INTO ${SCHEMA}.${TABLE}(${FIELDS}) VALUES ${LIST}";

	private static final String EXCLUIR_TODOS = "DELETE FROM ${SCHEMA}.${TABLE}";
	private static final String EXCLUIR_PK = "DELETE FROM ${SCHEMA}.${TABLE} WHERE ${PK} = ?";
	private static final String EXCLUIR_FILTRO = "DELETE FROM ${SCHEMA}.${TABLE} WHERE ${FILTERS}";

	private static final String ATUALIZAR_PK = "UPDATE ${SCHEMA}.${TABLE} SET ${FIELDS} WHERE ${PK} = ?";
	private static final String ATUALIZAR_FILTRO = "UPDATE ${SCHEMA}.${TABLE} SET ${FIELDS} WHERE ${FILTERS}";

	private FilterGen getSQLFiltersSET(T model, Class<T> modelClass)
			throws NoSuchMethodException, SecurityException,
			IllegalAccessException, IllegalArgumentException,
			InvocationTargetException, SQLException {

		FilterGen fg = new FilterGen();

		String sqlFilters = "";
		Field[] fields = modelClass.getDeclaredFields();

		Object[] values = new Object[fields.length];

		boolean last = false;
		int i = 0;
		while (i < fields.length) {
			if (!"serialVersionUID".equals(fields[i].getName())) {
				String fieldName = fields[i].getName();
				Object value = modelClass.getMethod(
						"get" + getJavaName(fieldName), new Class[0]).invoke(
						model, new Object[0]);

				if (i == fields.length) {
					if (value != null) {
						sqlFilters += fieldName + " = ?";
						values[i] = value;
						last = true;
					}
				} else {
					if (value != null) {
						sqlFilters += fieldName + " = ?,";
						values[i] = value;
					}
				}
			}
			i++;

		}

		if (!last) {
			sqlFilters = sqlFilters.substring(0, sqlFilters.length() - 1);
		}

		fg.setSqlFilters(sqlFilters);
		fg.setValues(values);

		return fg;
	}

	private FilterGen getSqlValues(T model) throws IllegalAccessException,
			IllegalArgumentException, InvocationTargetException,
			NoSuchMethodException, SecurityException {
		String sqlFields = "";
		Field[] fields = model.getClass().getDeclaredFields();
		Object[] values = new Object[fields.length];
		boolean last = false;
		int i = 0;
		while (i < fields.length) {
			if (!"serialVersionUID".equals(fields[i].getName())) {
				Object value = model
						.getClass()
						.getMethod("get" + getJavaName(fields[i].getName()),
								new Class[0]).invoke(model, new Object[0]);

				if (i == fields.length) {
					if (value != null) {
						sqlFields += "?";
						values[i] = value;
						last = true;
					}
				} else {
					if (value != null) {
						sqlFields += "?,";
						values[i] = value;
					}
				}

			}
			i++;
		}

		if (!last) {
			sqlFields = sqlFields.substring(0, sqlFields.length() - 1);
		}

		FilterGen fg = new FilterGen();
		fg.setSqlFilters(sqlFields);
		fg.setValues(values);

		return fg;
	}

	private String getSQLFields(Class<T> model, T bean)
			throws IllegalAccessException, IllegalArgumentException,
			InvocationTargetException, NoSuchMethodException, SecurityException {
		String sqlFields = "";
		Field[] fields = model.getDeclaredFields();

		boolean last = false;
		int i = 0;
		while (i < fields.length) {
			if (!"serialVersionUID".equals(fields[i].getName())) {
				Object value = null;
				if (bean != null)
					value = model.getMethod(
							"get" + getJavaName(fields[i].getName()),
							new Class[0]).invoke(bean, new Object[0]);

				if (bean == null || value != null) {
					if (i == fields.length - 1) {
						sqlFields += fields[i].getName();
						last = true;
					} else
						sqlFields += fields[i].getName() + ",";
				}
			}
			i++;
		}

		if (!last) {
			sqlFields = sqlFields.substring(0, sqlFields.length() - 1);
		}

		return sqlFields;
	}

	private FilterGen getSQLFilters(T model, Class<T> modelClass)
			throws NoSuchMethodException, SecurityException,
			IllegalAccessException, IllegalArgumentException,
			InvocationTargetException, SQLException {

		FilterGen fg = new FilterGen();

		String sqlFilters = "";
		Field[] fields = modelClass.getDeclaredFields();

		Object[] values = new Object[fields.length];

		boolean last = false;
		int i = 0;
		while (i < fields.length) {
			if (!"serialVersionUID".equals(fields[i].getName())) {
				String fieldName = fields[i].getName();
				Object value = modelClass.getMethod(
						"get" + getJavaName(fieldName), new Class[0]).invoke(
						model, new Object[0]);

				if (i == fields.length) {
					if (value != null) {
						sqlFilters += fieldName + " = ?";
						values[i] = value;
						last = true;
					}
				} else {
					if (value != null) {
						sqlFilters += fieldName + " = ? AND ";
						values[i] = value;
					}
				}
			}
			i++;
		}

		if (!last) {
			sqlFilters = sqlFilters.substring(0, sqlFilters.length() - 4);
		}

		fg.setSqlFilters(sqlFilters);
		fg.setValues(values);

		return fg;
	}

	private String getJavaName(String tableName) {

		String javaName = "";

		String[] pattern = tableName.split("[_]");

		for (String field_crack : pattern) {
			javaName += field_crack.substring(0, 1).toUpperCase()
					+ field_crack.substring(1);
		}

		return javaName;
	}

	private String getPK(String dbSchema, Class<T> model, DataSource dataSource) {

		String META_DATA_PK_DEF = "";
		META_DATA_PK_DEF += "SELECT COLUMN_NAME";
		META_DATA_PK_DEF += "  FROM INFORMATION_SCHEMA.COLUMNS";
		META_DATA_PK_DEF += " WHERE TABLE_SCHEMA = ?";
		META_DATA_PK_DEF += "   AND TABLE_NAME = ?";
		META_DATA_PK_DEF += "   AND ORDINAL_POSITION = 1";
		System.out.println(META_DATA_PK_DEF);
		super.setDataSource(dataSource);
		return queryForObject(META_DATA_PK_DEF,
				new Object[] { dbSchema, model.getSimpleName() },
				new RowMapper<String>() {

					public String mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						String columnName = rs.getString("COLUMN_NAME");
						return columnName;
					}
				});
	}

	public PreparedStatement listar(String dbSchema, Class<T> model,
			DataSource dataSource) throws SQLException, IllegalAccessException,
			IllegalArgumentException, InvocationTargetException,
			NoSuchMethodException, SecurityException {
		String sqlFields = getSQLFields(model, null);
		String sql = LISTAR_TODOS.replace("${SCHEMA}", dbSchema)
				.replace("${FIELDS}", sqlFields)
				.replace("${TABLE}", model.getSimpleName())
				.replace("${ORDER}", sqlFields);
		System.out.println(sql);
		return dataSource.getConnection().prepareStatement(sql);
	}

	public PreparedStatement listar(String dbSchema, Class<T> model, Long pk,
			DataSource dataSource) throws SQLException, IllegalAccessException,
			IllegalArgumentException, InvocationTargetException,
			NoSuchMethodException, SecurityException {

		String sqlFields = getSQLFields(model, null);
		String sql = LISTAR_PK.replace("${SCHEMA}", dbSchema)
				.replace("${FIELDS}", sqlFields)
				.replace("${TABLE}", model.getSimpleName())
				.replace("${PK}", getPK(dbSchema, model, dataSource));
		System.out.println(sql);

		PreparedStatement ps = dataSource.getConnection().prepareStatement(sql);
		int i = 1;
		ps.setLong(i++, pk);

		return ps;

	}

	public PreparedStatement listar(String dbSchema, T parameter,
			DataSource dataSource) throws SQLException, NoSuchMethodException,
			SecurityException, IllegalAccessException,
			IllegalArgumentException, InvocationTargetException {

		String sqlFields = getSQLFields((Class<T>) parameter.getClass(),
				parameter);

		FilterGen fg = getSQLFilters(parameter, (Class<T>) parameter.getClass());

		String sql = LISTAR_FILTRO
				.replace("${SCHEMA}", dbSchema)
				.replace("${FIELDS}", sqlFields)
				.replace("${TABLE}",
						((Class<T>) parameter.getClass()).getSimpleName())
				.replace("${FILTERS}", fg.getSqlFilters())
				.replace("${ORDER}", sqlFields);

		System.out.println(sql);
		PreparedStatement ps = dataSource.getConnection().prepareStatement(sql);

		int i = 1;
		Object[] values = fg.getValues();
		for (Object value : values) {
			if (value != null)
				ps.setObject(i++, value);
		}

		return ps;
	}

	public PreparedStatement inserir(String dbSchema, T parameter,
			DataSource dataSource) throws NoSuchMethodException,
			SecurityException, IllegalAccessException,
			IllegalArgumentException, InvocationTargetException, SQLException {

		String sqlFields = getSQLFields((Class<T>) parameter.getClass(),
				parameter);
		FilterGen fg = getSqlValues(parameter);
		String sql = INSERIR
				.replace("${SCHEMA}", dbSchema)
				.replace("${FIELDS}", sqlFields)
				.replace("${TABLE}",
						((Class<T>) parameter.getClass()).getSimpleName())
				.replace("${VALUES}", fg.getSqlFilters());

		System.out.println(sql);
		PreparedStatement ps = dataSource.getConnection().prepareStatement(sql);

		int i = 1;
		Object[] values = fg.getValues();
		for (Object value : values) {
			ps.setObject(i++, value);
		}

		return ps;
	}

	public PreparedStatement excluir(String dbSchema, Class<T> model,
			DataSource dataSource) throws SQLException {

		String sql = EXCLUIR_TODOS.replace("${SCHEMA}", dbSchema).replace(
				"${TABLE}", model.getSimpleName());
		System.out.println(sql);
		return dataSource.getConnection().prepareStatement(sql);
	}

	public PreparedStatement excluir(String dbSchema, Class<T> model, Long pk,
			DataSource dataSource) throws SQLException {

		String sql = EXCLUIR_PK.replace("${SCHEMA}", dbSchema)
				.replace("${TABLE}", model.getSimpleName())
				.replace("${PK}", getPK(dbSchema, model, dataSource));
		System.out.println(sql);
		PreparedStatement ps = dataSource.getConnection().prepareStatement(sql);
		int i = 1;
		ps.setLong(i++, pk);

		return ps;
	}

	public PreparedStatement excluir(String dbSchema, T parameter,
			DataSource dataSource) throws NoSuchMethodException,
			SecurityException, IllegalAccessException,
			IllegalArgumentException, InvocationTargetException, SQLException {

		String sqlFields = getSQLFields((Class<T>) parameter.getClass(),
				parameter);

		FilterGen fg = getSQLFilters(parameter, (Class<T>) parameter.getClass());

		String sql = EXCLUIR_FILTRO
				.replace("${SCHEMA}", dbSchema)
				.replace("${TABLE}",
						((Class<T>) parameter.getClass()).getSimpleName())
				.replace("${FILTERS}", fg.getSqlFilters());

		System.out.println(sql);
		PreparedStatement ps = dataSource.getConnection().prepareStatement(sql);

		int i = 1;
		Object[] values = fg.getValues();
		for (Object value : values) {
			if (value != null)
				ps.setObject(i++, value);
		}

		return ps;
	}

	public PreparedStatement atualizar(String dbSchema, T setter, Long pk,
			DataSource dataSource) throws SQLException, NoSuchMethodException,
			SecurityException, IllegalAccessException,
			IllegalArgumentException, InvocationTargetException {

		FilterGen fg = getSQLFiltersSET(setter, (Class<T>) setter.getClass());
		String sql = ATUALIZAR_PK
				.replace("${SCHEMA}", dbSchema)
				.replace("${TABLE}", setter.getClass().getSimpleName())
				.replace("${FIELDS}", fg.getSqlFilters())
				.replace(
						"${PK}",
						getPK(dbSchema, (Class<T>) setter.getClass(),
								dataSource));
		System.out.println(sql);
		PreparedStatement ps = dataSource.getConnection().prepareStatement(sql);
		int i = 1;
		Object[] values = fg.getValues();
		for (Object value : values) {
			if (value != null)
				ps.setObject(i++, value);
		}

		ps.setLong(i++, pk);

		return ps;
	}

	public PreparedStatement atualizar(String dbSchema, T filter, T setter,
			DataSource dataSource) throws NoSuchMethodException,
			SecurityException, IllegalAccessException,
			IllegalArgumentException, InvocationTargetException, SQLException {

		FilterGen fgSet = getSQLFiltersSET(setter, (Class<T>) setter.getClass());
		FilterGen fgWhere = getSQLFilters(filter, (Class<T>) filter.getClass());

		String sql = ATUALIZAR_FILTRO.replace("${SCHEMA}", dbSchema)
				.replace("${TABLE}", setter.getClass().getSimpleName())
				.replace("${FIELDS}", fgSet.getSqlFilters())
				.replace("${FILTERS}", fgWhere.getSqlFilters());

		System.out.println(sql);
		PreparedStatement ps = dataSource.getConnection().prepareStatement(sql);
		int i = 1;
		Object[] valuesSet = fgSet.getValues();
		for (Object value : valuesSet) {
			if (value != null)
				ps.setObject(i++, value);
		}

		Object[] valuesWhere = fgWhere.getValues();
		for (Object value : valuesWhere) {
			if (value != null)
				ps.setObject(i++, value);
		}

		return ps;
	}
}