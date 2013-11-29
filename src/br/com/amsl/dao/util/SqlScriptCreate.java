package br.com.amsl.dao.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.amsl.properties.AppProperties;

public class SqlScriptCreate {

	public static void main(String[] args) {
		AppProperties.instanceOf().load();

		File dir = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar + "sql" + File.separatorChar);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		SqlScriptCreate sql = new SqlScriptCreate();
		try {
			List<String> tables = sql.getTables("fiftyclub");

			for (String table : tables) {
				List<CollumnDef> collDef = sql.getTable(table, "fiftyclub");
				List<String> indexCollDef = sql.getIndex(table, "fiftyclub");

				String select_script = "";
				String insert_or_update_script = "";
				String delete_script = "";

				String PROCEDURE_SELECT = "DELIMITER $$\n"
						+ "CREATE DEFINER=${DB_USER} PROCEDURE `fiftyclub`.`"
						+ table
						+ "_select`(${PARAMETERS})\nBEGIN\n\n${STATEMENT}\n\nEND";

				String SELECT = "SELECT ";
				String FROM = "\n  FROM " + table;
				String WHERE = "\n  WHERE ";
				String ORDER_BY = "\nORDER BY ";

				String PROCEDURE_INSERT_OR_UPDATE = "DELIMITER $$\n"
						+ "CREATE DEFINER=${DB_USER} PROCEDURE `fiftyclub`.`"
						+ table
						+ "_insert_or_update`(${PARAMETERS})\nBEGIN\n\n${STATEMENT}\n\nEND";

				String INSERT = "INSERT INTO " + table;
				String FIELDS = "";
				String VALUES = "";
				String ON_DUPLICATE_KEY_UPDATE = "ON DUPLICATE KEY UPDATE";
				String UPDATE_VALUES = "";

				String PROCEDURE_DELETE = "DELIMITER $$\n"
						+ "CREATE DEFINER=${DB_USER} PROCEDURE `fiftyclub`.`"
						+ table
						+ "_delete`(${PARAMETERS})\nBEGIN\n\n${STATEMENT}\n\nEND";

				String DELETE = "DELETE FROM " + table;

				String PARAMETERS_PROCEDURE = "";

				for (String coll : indexCollDef) {
					ORDER_BY += coll;
				}

				int i = 0;
				for (CollumnDef collumnDef : collDef) {

					if (i == 0) {
						PARAMETERS_PROCEDURE += "var_"
								+ collumnDef.getCollumnName() + " " + collumnDef.getCollumnType();
						
						if("varchar".equals(collumnDef.getCollumnType()))
							PARAMETERS_PROCEDURE += "(60)";
						
						FIELDS += collumnDef.getCollumnName();
						VALUES += "var_" + collumnDef.getCollumnName();
						UPDATE_VALUES += collumnDef.getCollumnName()
								+ " = var_" + collumnDef.getCollumnName();

						SELECT += collumnDef.getCollumnName();
						WHERE += "(" + collumnDef.getCollumnName() + " = var_"
								+ collumnDef.getCollumnName() + " OR var_"
								+ collumnDef.getCollumnName() + " IS NULL)";
					} else {
						PARAMETERS_PROCEDURE += ", var_"
								+ collumnDef.getCollumnName() + " " + collumnDef.getCollumnType();
						
						if("varchar".equals(collumnDef.getCollumnType()))
							PARAMETERS_PROCEDURE += "(60)";
						
						FIELDS += ", " + collumnDef.getCollumnName();
						VALUES += ", var_" + collumnDef.getCollumnName();
						UPDATE_VALUES += ",\n                        "
								+ collumnDef.getCollumnName() + " = var_"
								+ collumnDef.getCollumnName();

						SELECT += "," + collumnDef.getCollumnName();
						WHERE += "\n    AND (" + collumnDef.getCollumnName()
								+ " = var_" + collumnDef.getCollumnName()
								+ " OR var_" + collumnDef.getCollumnName()
								+ " IS NULL)";
					}
					i++;
				}

				select_script += SELECT + FROM + WHERE
						+ ("\nORDER BY ".equals(ORDER_BY) ? "" : ORDER_BY)
						+ ";";

				insert_or_update_script += INSERT + "(" + FIELDS + ")"
						+ "\n      VALUES(" + VALUES + ")\n"
						+ ON_DUPLICATE_KEY_UPDATE + " " + UPDATE_VALUES + ";";

				delete_script += DELETE + WHERE + ";";

				PROCEDURE_SELECT = PROCEDURE_SELECT
						.replace("${DB_USER}", "root@localhost")
						.replace("${PARAMETERS}", PARAMETERS_PROCEDURE)
						.replace("${STATEMENT}", select_script);

				FileOutputStream fosSelect = new FileOutputStream(dir.getPath()
						+ File.separatorChar + "select_" + table + ".sql");
				fosSelect.write(PROCEDURE_SELECT.getBytes());
				fosSelect.close();
				
				PROCEDURE_INSERT_OR_UPDATE = PROCEDURE_INSERT_OR_UPDATE
						.replace("${DB_USER}", "root@localhost")
						.replace("${PARAMETERS}", PARAMETERS_PROCEDURE)
						.replace("${STATEMENT}", insert_or_update_script);

				FileOutputStream fosInsertOrUpdate = new FileOutputStream(
						dir.getPath() + File.separatorChar
								+ "insert_or_update_" + table + ".sql");
				fosInsertOrUpdate.write(PROCEDURE_INSERT_OR_UPDATE.getBytes());
				fosInsertOrUpdate.close();

				PROCEDURE_DELETE = PROCEDURE_DELETE
						.replace("${DB_USER}", "root@localhost")
						.replace("${PARAMETERS}", PARAMETERS_PROCEDURE)
						.replace("${STATEMENT}", delete_script);
				
				FileOutputStream fosDelete = new FileOutputStream(dir.getPath()
						+ File.separatorChar + "delete" + table + ".sql");
				fosDelete.write(PROCEDURE_DELETE.getBytes());
				fosDelete.close();
			}

		} catch (ClassNotFoundException | SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	private Connection getConnection() throws ClassNotFoundException,
			SQLException {
		Class.forName(AppProperties.instanceOf().getProperty("DRIVER"));
		return DriverManager.getConnection(AppProperties.instanceOf()
				.getProperty("URL_JDBC"), AppProperties.instanceOf()
				.getProperty("USER_DB"), AppProperties.instanceOf()
				.getProperty("PASSWD_DB"));
	}

	private String read(String fileName) throws IOException {
		FileReader reader = new FileReader(fileName);
		String content = "";
		char[] buffer = new char[Integer.parseInt(AppProperties.instanceOf()
				.getProperty("BUFFER"))];
		while (reader.ready()) {
			reader.read(buffer);
			content += new String(buffer);
		}

		reader.close();

		return content;
	}

	private List<String> getIndex(String tableName, String schemaName)
			throws IOException, SQLException, ClassNotFoundException {

		List<String> list = new ArrayList<String>();

		String META_DATA_INDEX_DEF = read("sql" + File.separatorChar
				+ "INDEX_ORDER_NAME_SCHEMA.sql");
		Connection connection = getConnection();

		PreparedStatement ps = connection.prepareStatement(META_DATA_INDEX_DEF);
		ps.setString(1, schemaName);
		ps.setString(2, tableName);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			list.add(rs.getString(1));
		}

		rs.close();
		ps.close();
		connection.close();

		return list;
	}

	private List<CollumnDef> getTable(String tableName, String schemaName)
			throws ClassNotFoundException, SQLException, IOException {

		String META_DATA_PK_DEF = read("sql" + File.separatorChar
				+ "TABLE_COMUMNS_NAME_SCHEMA.sql");

		Connection connection = getConnection();
		List<CollumnDef> list = new ArrayList<CollumnDef>();
		PreparedStatement ps = connection.prepareStatement(META_DATA_PK_DEF);
		ps.setString(1, schemaName);
		ps.setString(2, tableName);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			CollumnDef cd = new CollumnDef();
			cd.setCollumnName(rs.getString(2));
			cd.setCollumnType(rs.getString(3));
			list.add(cd);
		}

		rs.close();
		ps.close();
		connection.close();

		return list;
	}

	private List<String> getTables(String schemaName)
			throws ClassNotFoundException, SQLException, IOException {

		String META_DATA_PK_DEF = "";
		META_DATA_PK_DEF += read("sql" + File.separatorChar
				+ "TABLE_NAME_SCHEMA.sql");

		Connection connection = getConnection();
		List<String> list = new ArrayList<String>();
		PreparedStatement ps = connection.prepareStatement(META_DATA_PK_DEF);
		ps.setString(1, schemaName);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			list.add(rs.getString(1));
		}

		rs.close();
		ps.close();
		connection.close();
		return list;
	}
}
