package br.com.amsl.dao.util;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.amsl.properties.AppProperties;

public class DBReverseEnginer {

	public static void main(String[] args) {
		gerarCRUD();
	}

	public static void gerarCRUD() {
		try {
			AppProperties.instanceOf().load();

			DBReverseEnginer mu = new DBReverseEnginer();
			List<String> tables = mu.getTables(AppProperties.instanceOf().getProperty("SCHEMA_DB"));
			List<String> procedures = mu.getProcedures(AppProperties.instanceOf().getProperty("SCHEMA_DB"));

			mu.createSrcDirctoryFromMavem();
			
			String mavenConfig = mu.createMaven();
			mu.writeResource(mavenConfig, "pom.xml");
			
			String projectConfig = mu.createProject();
			mu.writeResource(projectConfig, ".project");
			
			String classpath = mu.createClassPath();
			mu.writeResource(classpath, ".classpath");
			
			String exceptionExecuteField = mu.createException(
					"ExecuteFieldException", "exception");
			mu.write(exceptionExecuteField, "ExecuteFieldException",
					"exception");

			String executeFieldAnnotation = mu
					.createExecuteFieldAnnotation("field");
			mu.write(executeFieldAnnotation, "ExecuteField", "field");

			String executeFieldBase = mu.createExecuteFieldBase("field",
					"exception");
			mu.write(executeFieldBase, "ExecuteFieldBase", "field");

			String iTargetClassValidationField = mu
					.createTargetClassValidationFieldInterface("field");
			mu.write(iTargetClassValidationField,
					"ITargetClassValidationField", "field");

			String regularExpressionValidadeField = mu
					.createRegularExpressionValidationField("field");
			mu.write(regularExpressionValidadeField,
					"RegularExpressionValidadeField", "field");

			String noValidationClassTarget = mu
					.createNoValidationClassTarget("field");
			mu.write(noValidationClassTarget, "NoValidationClassTarget",
					"field");

			String abstractMapperList = mu
					.createSpringListMapperAbstractBean("mapper");
			mu.write(abstractMapperList, "ListModelRowMapper", "mapper");

			String interfaceCRUD = mu.createCRUDInterface("dao", "model");
			mu.write(interfaceCRUD, "ICRUD", "dao");

			String prepareStatementCuston = mu
					.createCRUDPrepareStatementCuston("helper");
			mu.write(prepareStatementCuston, "PrepareStatementCuston", "helper");

			String prepareStatementCreator = mu
					.createCRUDPrepareStatement("helper");
			mu.write(prepareStatementCreator, "PrepareStatementCreate",
					"helper");

			String filterGen = mu.createFilterGen("helper");
			mu.write(filterGen, "FilterGen", "helper");

			String validationException = mu.createException(
					"ValidationException", "exception");
			mu.write(validationException, "ValidationException", "exception");

			String rulesException = mu.createException("RulesException",
					"exception");
			mu.write(rulesException, "RulesException", "exception");

			String exceptionDao = mu.createDaoException("exception");
			mu.write(exceptionDao, "DaoException",
					"exception");

			String delegateDao = mu.createDelegateService("delegate", "exception");
			mu.write(delegateDao, "IServiceDelegate",
					"delegate");

			String WebXml = mu.createWebXml(AppProperties.instanceOf().getProperty("FINAL_NAME"));
			mu.writeResource(WebXml, "Web.xml");

			String appContext = mu.createApplicationContex(procedures, tables,
					"helper", "dao", "validation", "rules", "service");
			mu.writeSpringResource(appContext, "applicationContext.xml");

			for (String procedure : procedures) {
				List<ParameterDef> pdList = mu.getParameters(AppProperties.instanceOf().getProperty("SCHEMA_DB"), procedure);
				String sp = mu.createJdbcDaoExecuteProcedure(AppProperties.instanceOf().getProperty("SCHEMA_DB"), "model",
						procedure, pdList, "dao", "mapper", "statement");

				mu.write(sp, "Call" + mu.getJavaName(procedure) + "Dao", "dao");

				String cxfServiceBeanWS = mu.createServiceProcedureWS(
						procedure, "servicews", "model", "validation", "rules",
						"dao", "exception", pdList);
				mu.write(cxfServiceBeanWS, "Call" + mu.getJavaName(procedure) + "ServiceWS",
						"servicews");

				String cxfServiceBeanRS = mu.createServiceProcedureRS(
						procedure, "servicers", "model", "validation", "rules",
						"dao", "exception", pdList);
				mu.write(cxfServiceBeanRS, "Call" + mu.getJavaName(procedure) + "ServiceRS",
						"servicers");
			}

			for (String table : tables) {
				List<CollumnDef> lcd = mu.getTable(table, AppProperties.instanceOf().getProperty("SCHEMA_DB"));

				String javaBean = mu.createModelBeans(lcd, table, "model",
						"field");
				mu.write(javaBean, table, "model");

				String springPrepareStatementBean = mu
						.createSpringPrepareStatement(lcd, table, "statement",
								"model", "exception");

				mu.write(springPrepareStatementBean, table + "PrepareStatement",
						"statement");

				String springMapperBean = mu.createSpringMapperBeans(lcd,
						table, "mapper", "model", "rules", "exception");
				mu.write(springMapperBean, table + "Mapper", "mapper");

				String springListMapperBean = mu.createSpringListMapperBeans(
						lcd, table, "mapper", "model", "exception");
				mu.write(springListMapperBean, table + "ListMapper", "mapper");

				String springDaoBean = mu.createJdbcTemplate(lcd, table, "dao",
						"model", "mapper", "dao", "helper", "exception");
				mu.write(springDaoBean, table + "Dao", "dao");

				String validationBean = mu.createValidation(table,
						"validation", "model", "exception", "field");
				mu.write(validationBean, table + "Validation", "validation");

				String rulesBean = mu.createRules(table, "rules", "model",
						"exception");
				mu.write(rulesBean, table + "Rules", "rules");

				String afterRules = mu.createAfterRules(table, "rules",
						"exception");
				mu.write(afterRules, table + "AfterRules", "rules");
				
				String delegateService = mu.createDelegateService(table, "delegate", "model", "validation", "rules", "exception");
				mu.write(delegateService, table + "ServiceDelegate", "delegate");

				String cxfIServiceRS = mu.createIServiceRS(table, "service",
						"model", "validation", "rules", "dao", "exception");
				mu.write(cxfIServiceRS, "I" + mu.getJavaName(table)
						+ "ServiceRS", "servicers");

				String cxfServiceBeanRS = mu.createServiceRS(table,
						"service", "model", "validation", "rules", "dao",
						"exception", "delegate");
				mu.write(cxfServiceBeanRS, table + "ServiceRS", "servicers");

				String cxfIServiceWS = mu.createIServiceWS(table, "service",
						"model", "validation", "rules", "dao", "exception");
				mu.write(cxfIServiceWS, "I" + mu.getJavaName(table)
						+ "ServiceWS", "servicews");

				String cxfServiceBeanWS = mu.createServiceWS(table,
						"service", "model", "validation", "rules", "dao",
						"exception", "delegate");
				mu.write(cxfServiceBeanWS, table + "ServiceWS", "servicews");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String createClassPath() throws IOException {
		String PROJECT = readTemplate("classpath.tpl");
		
		return PROJECT.replace("${GROUP_ID}", AppProperties.instanceOf().getProperty("GROUP_ID"))
				.replace("${ARTEFACT_ID}", AppProperties.instanceOf().getProperty("ARTEFACT_ID"))
				.replace("${PACKAGING}", AppProperties.instanceOf().getProperty("PACKAGING"))
				.replace("${VERSION}", AppProperties.instanceOf().getProperty("VERSION"))
				.replace("${NAME}", AppProperties.instanceOf().getProperty("NAME"));
	}

	private String createProject() throws IOException {
		String PROJECT = readTemplate("project.tpl");
		
		return PROJECT.replace("${GROUP_ID}", AppProperties.instanceOf().getProperty("GROUP_ID"))
				.replace("${ARTEFACT_ID}", AppProperties.instanceOf().getProperty("ARTEFACT_ID"))
				.replace("${PACKAGING}", AppProperties.instanceOf().getProperty("PACKAGING"))
				.replace("${VERSION}", AppProperties.instanceOf().getProperty("VERSION"))
				.replace("${NAME}", AppProperties.instanceOf().getProperty("NAME"));
	}

	private String createMaven() throws IOException {
		
		String POM = readTemplate("maven.tpl");
		
		return POM.replace("${GROUP_ID}", AppProperties.instanceOf().getProperty("GROUP_ID"))
				.replace("${ARTEFACT_ID}", AppProperties.instanceOf().getProperty("ARTEFACT_ID"))
				.replace("${PACKAGING}", AppProperties.instanceOf().getProperty("PACKAGING"))
				.replace("${VERSION}", AppProperties.instanceOf().getProperty("VERSION"))
				.replace("${NAME}", AppProperties.instanceOf().getProperty("NAME"));
	}

	private String createDelegateService(String tableName, String delegatePackage,
			String modelPackage, String validationPackage, String rulesPackage, String exceptionPackage) throws IOException {

		String CLASS = readTemplate("JavaServiceDelegate.tpl");

		return CLASS
				.replace("${PACKAGE_EXCEPTION}", exceptionPackage)
				.replace("${PACKAGE_DELEGATE}", delegatePackage)
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${PACKAGE_VALIDATION}", validationPackage)
				.replace("${PACKAGE_RULES}", rulesPackage)
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName));
	}

	private String createDelegateService(String packageDelegate, String packageException) throws IOException {

		String CLASS = readTemplate("IServiceDelegate.tpl");

		return CLASS
				.replace("${PACKAGE_EXCEPTION}", packageException)
				.replace("${PACKAGE_DELEGATE}", packageDelegate);
	}

	private String createSpringPrepareStatement(List<CollumnDef> lcd,
			String tableName, String packageName, String packageModel, String packageException)
			throws IOException {

		String prepareStatementCreate = readTemplate("JavaPrepareStatementCreate.tpl");
		String javaPrepareStatementCreate_setter = readTemplate("JavaPrepareStatementCreate_setter.tpl");

		String settersAux = "";
		for (CollumnDef collumnDef : lcd) {
			settersAux += javaPrepareStatementCreate_setter
					.replace("${SETTER_TYPE}", fieldsParaDe(collumnDef.getCollumnType()))
					.replace("${OBJECT_NAME}", getObjectJavaName(tableName))
					.replace("${PROPERTY_NAME}", collumnDef.getPropertName());
		}

		return prepareStatementCreate.replace("${PACKAGE}", packageName)
				.replace("${PACKAGE_MODEL}", packageModel)
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName))
				.replace("${SETTER_PREPARE_STATEMENT}", settersAux)
				.replace("${PACKAGE_EXCEPTION}", packageException);
	}

	private List<String> getProcedures(String schemaName) throws IOException,
			ClassNotFoundException, SQLException {
		String META_DATA_PK_DEF = "";
		META_DATA_PK_DEF += read(AppProperties.instanceOf().getProperty("DB_TARGET") + File.separatorChar
				+ "PROCEDURES_NAME_SCHEMA.sql");

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

	private List<ParameterDef> getParameters(String schemaName,
			String procedureName) throws IOException, ClassNotFoundException,
			SQLException {
		String META_DATA_PR_DEF = "";
		META_DATA_PR_DEF += read(AppProperties.instanceOf().getProperty("DB_TARGET") + File.separatorChar
				+ "PARAMETERS_NAME_SCHEMA.sql");

		Connection connection = getConnection();
		PreparedStatement ps = connection.prepareStatement(META_DATA_PR_DEF);
		ps.setString(1, schemaName);
		ps.setString(2, procedureName);

		ResultSet rs = ps.executeQuery();

		List<ParameterDef> pdList = new ArrayList<ParameterDef>();
		while (rs.next()) {
			ParameterDef pd = new ParameterDef();
			pd.setSpecificName(rs.getString(1));
			pd.setOrdinalPosition(rs.getInt(2));
			pd.setParameterMode(rs.getString(3));
			pd.setParameterName(rs.getString(4));
			pd.setDbDataType(rs.getString(5));
			pdList.add(pd);
		}

		rs.close();
		ps.close();
		connection.close();
		return pdList;
	}

	private DBReverseEnginer() {
		super();
	}

	private String createApplicationContex(List<String> procedures,
			List<String> tables, String packageHelper, String packageDao,
			String packageValidation, String packageRules, String packageService)
			throws IOException {

		String OBJECT_NAME_HELPER_TEMPLATE = readTemplate("beans_psc.tpl");
		String OBJECT_NAME_DAO_TEMPLATE = readTemplate("beans_dao.tpl");
		String OBJECT_NAME_VALIDATION_TEMPLATE = readTemplate("beans_validation.tpl");
		String OBJECT_NAME_RULES_TEMPLATE = readTemplate("beans_rules.tpl");
		String OBJECT_NAME_AFTER_RULES_TEMPLATE = readTemplate("beans_afterRules.tpl");
		String OBJECT_SERVICE_TEMPLATE = readTemplate("beans_service.tpl");
		String OBJECT_NAME_SERVICE_TEMPLATE = readTemplate("beans_jaxwsEndpoint.tpl");
		String APPCONTEXT = readTemplate("applicationContext.tpl");

		String buffer = "";

		String OBJECT_NAME_HELPER = OBJECT_NAME_HELPER_TEMPLATE.replace(
				"${PACKAGE_HELPER}", packageHelper);
		buffer += OBJECT_NAME_HELPER
				+ AppProperties.instanceOf().getProperty("END_LINE");

		for (String procedure : procedures) {
			String className = "Call" + procedure;
			String objectName = "call" + procedure;

			String OBJECT_NAME_DAO = OBJECT_NAME_DAO_TEMPLATE.replace(
					"${OBJECT_NAME}", objectName);
			OBJECT_NAME_DAO = OBJECT_NAME_DAO.replace("${PACKAGE_DAO}",
					packageDao);
			OBJECT_NAME_DAO = OBJECT_NAME_DAO.replace("${CLASS_MODEL}",
					className);

			String OBJECT_SERVICE = OBJECT_SERVICE_TEMPLATE.replace(
					"${OBJECT_NAME}", objectName);
			OBJECT_SERVICE = OBJECT_SERVICE.replace("${PACKAGE_SERVICE_WS}",
					packageService + "ws");
			OBJECT_SERVICE = OBJECT_SERVICE.replace("${PACKAGE_SERVICE_RS}",
					packageService + "rs");
			OBJECT_SERVICE = OBJECT_SERVICE
					.replace("${CLASS_MODEL}", className);
			String OBJECT_NAME_SERVICE = OBJECT_NAME_SERVICE_TEMPLATE.replace(
					"${OBJECT_NAME}", objectName);
			OBJECT_NAME_SERVICE = OBJECT_NAME_SERVICE.replace(
					"${PACKAGE_SERVICE_WS}", packageService + "ws");
			OBJECT_NAME_SERVICE = OBJECT_NAME_SERVICE.replace(
					"${PACKAGE_SERVICE_RS}", packageService + "rs");
			OBJECT_NAME_SERVICE = OBJECT_NAME_SERVICE.replace("${CLASS_MODEL}",
					className);

			buffer += OBJECT_NAME_DAO
					+ AppProperties.instanceOf().getProperty("END_LINE")
					+ OBJECT_SERVICE
					+ AppProperties.instanceOf().getProperty("END_LINE")
					+ OBJECT_NAME_SERVICE
					+ AppProperties.instanceOf().getProperty("END_LINE");
		}

		for (String tableName : tables) {
			String className = getJavaName(tableName);
			String objectName = getObjectJavaName(tableName);

			String OBJECT_NAME_DAO = OBJECT_NAME_DAO_TEMPLATE.replace(
					"${OBJECT_NAME}", objectName);
			OBJECT_NAME_DAO = OBJECT_NAME_DAO.replace("${PACKAGE_DAO}",
					packageDao);
			OBJECT_NAME_DAO = OBJECT_NAME_DAO.replace("${CLASS_MODEL}",
					className);

			String OBJECT_NAME_VALIDATION = OBJECT_NAME_VALIDATION_TEMPLATE
					.replace("${OBJECT_NAME}", objectName);
			OBJECT_NAME_VALIDATION = OBJECT_NAME_VALIDATION.replace(
					"${PACKAGE_VALIDATION}", packageValidation);
			OBJECT_NAME_VALIDATION = OBJECT_NAME_VALIDATION.replace(
					"${CLASS_MODEL}", className);

			String OBJECT_NAME_RULES = OBJECT_NAME_RULES_TEMPLATE.replace(
					"${OBJECT_NAME}", objectName);
			OBJECT_NAME_RULES = OBJECT_NAME_RULES.replace("${PACKAGE_RULES}",
					packageRules);
			OBJECT_NAME_RULES = OBJECT_NAME_RULES.replace("${CLASS_MODEL}",
					className);

			String OBJECT_NAME_AFTER_RULES = OBJECT_NAME_AFTER_RULES_TEMPLATE
					.replace("${OBJECT_NAME}", objectName);
			OBJECT_NAME_AFTER_RULES = OBJECT_NAME_AFTER_RULES.replace(
					"${PACKAGE_RULES}", packageRules);
			OBJECT_NAME_AFTER_RULES = OBJECT_NAME_AFTER_RULES.replace(
					"${CLASS_MODEL}", className);

			String OBJECT_SERVICE = OBJECT_SERVICE_TEMPLATE.replace(
					"${OBJECT_NAME}", objectName);
			OBJECT_SERVICE = OBJECT_SERVICE.replace("${PACKAGE_SERVICE_WS}",
					packageService + "ws");
			OBJECT_SERVICE = OBJECT_SERVICE.replace("${PACKAGE_SERVICE_RS}",
					packageService + "rs");
			OBJECT_SERVICE = OBJECT_SERVICE
					.replace("${CLASS_MODEL}", className);

			String OBJECT_NAME_SERVICE = OBJECT_NAME_SERVICE_TEMPLATE.replace(
					"${OBJECT_NAME}", objectName);
			OBJECT_NAME_SERVICE = OBJECT_NAME_SERVICE.replace(
					"${PACKAGE_SERVICE_WS}", packageService + "ws");
			OBJECT_SERVICE = OBJECT_SERVICE.replace("${PACKAGE_SERVICE_RS}",
					packageService + "rs");
			OBJECT_NAME_SERVICE = OBJECT_NAME_SERVICE.replace("${CLASS_MODEL}",
					className);

			buffer += OBJECT_NAME_DAO
					+ AppProperties.instanceOf().getProperty("END_LINE")
					+ OBJECT_NAME_VALIDATION
					+ AppProperties.instanceOf().getProperty("END_LINE")
					+ OBJECT_NAME_RULES
					+ AppProperties.instanceOf().getProperty("END_LINE")
					+ OBJECT_NAME_AFTER_RULES
					+ AppProperties.instanceOf().getProperty("END_LINE")
					+ OBJECT_SERVICE
					+ AppProperties.instanceOf().getProperty("END_LINE")
					+ OBJECT_NAME_SERVICE
					+ AppProperties.instanceOf().getProperty("END_LINE");
		}

		return APPCONTEXT.replace("${BEANS_DEF}", buffer);
	}

	private String createWebXml(String projectName) throws IOException {

		String WEBXML = readTemplate("webxml.tpl");

		return WEBXML.replace("${DISPLAY_NAME}", projectName);
	}

	private String createException(String className, String packageName)
			throws IOException {

		String CLASS = readTemplate("JavaException.tpl");

		return CLASS
				.replace("${CLASS_NAME}", className)
				.replace("${PACKAGE}", packageName)
				.replace("${SERIAL_VERION_ID}",
						String.valueOf(System.currentTimeMillis()));
	}
	
	private String createDaoException(String packageName)
			throws IOException {

		String CLASS = readTemplate("JavaDaoException.tpl");

		return CLASS
				.replace("${PACKAGE_EXCEPTION}", packageName)
				.replace("${SERIAL_VERION_ID}",
						String.valueOf(System.currentTimeMillis()));
	}

	private String createJdbcDaoExecuteProcedure(String schemaName,
			String packageModel, String procedureName,
			List<ParameterDef> pdList, String packageName, String packageMapper, String packageStatement)
			throws IOException {
		
		boolean methodCondition = "int".equals(AppProperties.instanceOf().getProperty(procedureName)) || 
				"void".equals(AppProperties.instanceOf().getProperty(procedureName));
		
		String method = readTemplate(methodCondition ? "JavaUpdateMethodDao.tpl" : "JavaQueryMethodDao.tpl");
		String template = readTemplate("StoreProcedureJdbc.tpl");
		writeTemplate(template, "StoreProcedureJdbc.tpl");

		template = template
				.replace("${CONDITION_METHOD}", method)
				.replace("${PACKAGE_STATEMENT}", packageStatement)
				.replace("${PACKAGE_MODEL}", packageModel)
				.replace("${PACKAGE_NAME}", packageName)
				.replace("${PACKAGE_MAPPER}", packageMapper)
				.replace("${SP_NAME}", getJavaName(procedureName))
				.replace("${CURSOR}",
						AppProperties.instanceOf().getProperty(procedureName))
				.replace(
						"${ROW}",
						AppProperties.instanceOf().getProperty(
								procedureName + "Row"))
				.replace("${SP_CALLABLE}",
						schemaName + "." + procedureName + "($SP_PARAMETERS)");

		String parametersDao = "";
		String parametersProcedure = "";
		String setters = "";
		int i = 0;
		for (ParameterDef pd : pdList) {

			if (i < pdList.size() - 1) {
				parametersDao += "final " + collumnDePara(pd.getDbDataType())
						+ " " + pd.getParameterName() + ",";
				parametersProcedure += "?,";
				setters += "prepareStatement.set${SETTER_TYPE}(i++, "
						+ pd.getParameterName() + ");"
						+ AppProperties.instanceOf().getProperty("END_LINE");

			} else {
				parametersDao += "final " + collumnDePara(pd.getDbDataType())
						+ " " + pd.getParameterName();
				parametersProcedure += "?";
				setters += "prepareStatement.set${SETTER_TYPE}(i++, "
						+ pd.getParameterName() + ");";
			}

			setters = setters.replace("${SETTER_TYPE}",
					fieldsParaDe(pd.getDbDataType()));

			i++;
		}

		return template
				.replace("$SP_PARAMETERS", parametersProcedure)
				.replace("${DAO_PARAMETERS}", parametersDao)
				.replace("${SP_SETTER_PARAMETERS}", setters)
				.replace(
						"${CONDIDION_CURSOR}",
						"void".equals(AppProperties.instanceOf().getProperty(
								procedureName)) ? "" : "return");
	}

	private String createExecuteFieldAnnotation(String packageName)
			throws IOException {
		String template = readTemplate("AnnotationExdecuteField.tpl");

		writeTemplate(template, "AnnotationExdecuteField.tpl");
		return template.replace("${PACKAGE_NAME}", packageName);
	}

	private String createExecuteFieldBase(String packageName,
			String packageException) throws IOException {
		String template = readTemplate("JavaExecuteField.tpl");

		writeTemplate(template, "JavaExecuteField.tpl");
		return template.replace("${PACKAGE_NAME}", packageName).replace(
				"${PACKAGE_EXCEPTION}", packageException);

	}

	private String createTargetClassValidationFieldInterface(String packageName)
			throws IOException {
		String template = readTemplate("javaTargetClassValidationInterface.tpl");

		writeTemplate(template, "JavaTargetClassValidationInterface.tpl");
		return template.replace("${PACKAGE_NAME}", packageName);
	}

	private String createRegularExpressionValidationField(String packageName)
			throws IOException {
		String template = readTemplate("JavaRegularExpressionValidateField.tpl");

		writeTemplate(template, "JavaRegularExpressionValidateField.tpl");
		return template.replace("${PACKAGE_NAME}", packageName);
	}

	private String createNoValidationClassTarget(String packageName)
			throws IOException {
		String template = readTemplate("JavaNoValidationClassTarget.tpl");

		writeTemplate(template, "JavaNoValidationClassTarget.tpl");
		return template.replace("${PACKAGE_NAME}", packageName);
	}

	private String createValidation(String tableName, String validationPackage,
			String modelPackage, String exceptionPackage, String fieldPackage)
			throws IOException {

		String CLASS = readTemplate("JavaValidation.tpl");

		return CLASS.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${PACKAGE_EXCEPTION}", exceptionPackage)
				.replace("${PACKAGE_VALIDATION}", validationPackage)
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${PACKAGE_FIELD}", fieldPackage);
	}

	private String createRules(String tableName, String rulesPackage,
			String modelPackage, String exceptionPackage) throws IOException {

		String CLASS = readTemplate("JavaRules.tpl");

		return CLASS.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${PACKAGE_RULES}", rulesPackage)
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${PACKAGE_EXCEPTION}", exceptionPackage);
	}

	private String createAfterRules(String tableName, String packageName,
			String exceptionPackage) throws IOException {

		String CLASS = readTemplate("JavaAfterRules.tpl");
		writeTemplate(CLASS, "JavaAfterRules.tpl");

		return CLASS.replace("${CLASS_NAME}", getJavaName(tableName))
				.replace("${PACKAGE}", packageName)
				.replace("${EXCEPTION_PACKAGE}", exceptionPackage);
	}

	private String createIServiceRS(String tableName, String servicePackage,
			String modelPackage, String validationPackage, String rulesPackage,
			String daoPackage, String exceptionPackage) throws IOException {
		String INTERFACE = readTemplate("JavaServiceInterfaceRS.tpl");
		writeTemplate(INTERFACE, "JavaServiceInterfaceRS.tpl");
		return INTERFACE.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${PACKAGE_SERVICE_WS}", servicePackage + "ws")
				.replace("${PACKAGE_SERVICE_RS}", servicePackage + "rs")
				.replace("${PACKAGE_RULES}", rulesPackage)
				.replace("${PACKAGE_VALIDATION}", validationPackage)
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${PACKAGE_DAO}", daoPackage)
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName))
				.replace("${PACKAGE_EXCEPTION}", exceptionPackage);
	}

	private String createIServiceWS(String tableName, String servicePackage,
			String modelPackage, String validationPackage, String rulesPackage,
			String daoPackage, String exceptionPackage) throws IOException {
		String INTERFACE = readTemplate("JavaServiceInterfaceWS.tpl");
		writeTemplate(INTERFACE, "JavaServiceInterfaceWS.tpl");
		return INTERFACE.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${PACKAGE_SERVICE_WS}", servicePackage + "ws")
				.replace("${PACKAGE_SERVICE_RS}", servicePackage + "rs")
				.replace("${PACKAGE_RULES}", rulesPackage)
				.replace("${PACKAGE_VALIDATION}", validationPackage)
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${PACKAGE_DAO}", daoPackage)
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName))
				.replace("${PACKAGE_EXCEPTION}", exceptionPackage);
	}

	private String createServiceRS(String tableName, String servicePackage,
			String modelPackage, String validationPackage, String rulesPackage,
			String daoPackage, String exceptionPackage, String delegateService) throws IOException {

		String CLASS = readTemplate("JavaServiceRS.tpl");

		writeTemplate(CLASS, "JavaServiceRS.tpl");

		return CLASS.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${PACKAGE_SERVICE_WS}", servicePackage + "ws")
				.replace("${PACKAGE_SERVICE_RS}", servicePackage + "rs")
				.replace("${PACKAGE_RULES}", rulesPackage)
				.replace("${PACKAGE_VALIDATION}", validationPackage)
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${PACKAGE_DELEGATE}", delegateService)
				.replace("${PACKAGE_DAO}", daoPackage)
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName))
				.replace("${PACKAGE_EXCEPTION}", exceptionPackage);
	}

	private String createServiceWS(String tableName, String servicePackage,
			String modelPackage, String validationPackage, String rulesPackage,
			String daoPackage, String exceptionPackage, String delegateService) throws IOException {

		String CLASS = readTemplate("JavaServiceWS.tpl");

		writeTemplate(CLASS, "JavaServiceWS.tpl");

		return CLASS.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${PACKAGE_SERVICE_WS}", servicePackage + "ws")
				.replace("${PACKAGE_SERVICE_RS}", servicePackage + "rs")
				.replace("${PACKAGE_RULES}", rulesPackage)
				.replace("${PACKAGE_VALIDATION}", validationPackage)
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${PACKAGE_DELEGATE}", delegateService)
				.replace("${PACKAGE_DAO}", daoPackage)
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName))
				.replace("${PACKAGE_EXCEPTION}", exceptionPackage);
	}

	private String createServiceProcedureRS(String procedureName,
			String servicePackage, String modelPackage,
			String validationPackage, String rulesPackage, String daoPackage,
			String exceptionPackage, List<ParameterDef> pdList)
			throws IOException {

		String CLASS = readTemplate("JavaServiceProcedureRS.tpl");
		writeTemplate(CLASS, "JavaServiceProcedureRS.tpl");

		String parameterHandle = "";
		String parametersDao = "";

		int i = 0;
		for (ParameterDef pd : pdList) {

			if (i < pdList.size() - 1) {
				parameterHandle += "@PathParam(\"" + pd.getParameterName()
						+ "\") " + collumnDePara(pd.getDbDataType()) + " "
						+ pd.getParameterName() + ",";
				parametersDao += pd.getParameterName() + ",";

			} else {
				parameterHandle += "@PathParam(\"" + pd.getParameterName()
						+ "\") " + collumnDePara(pd.getDbDataType()) + " "
						+ pd.getParameterName();
				parametersDao += pd.getParameterName();
			}

			i++;
		}

		CLASS = CLASS.replace("${PARAMETERS_DAO}", parametersDao).replace(
				"${SERVICE_PARAMETERS}", parameterHandle);

		boolean returnCondition = "int".equals(AppProperties.instanceOf().getProperty(procedureName)) || 
				"void".equals(AppProperties.instanceOf().getProperty(procedureName));
		
		return CLASS
				.replace("${CONDITION_IMPORT}", returnCondition ? "" : "import " +  AppProperties.instanceOf().getProperty(procedureName + "_import") + ";\n")
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${CLASS_DAO}", "Call" + getJavaName(procedureName))
				.replace("${PACKAGE_SERVICE}", servicePackage)
				.replace("${PACKAGE_DAO}", daoPackage)
				.replace("${OBJECT_NAME}",
						getObjectJavaName("Call" + getJavaName(procedureName)))
				.replace("${CURSOR}",
						AppProperties.instanceOf().getProperty(procedureName))
				.replace(
						"${ROW}",
						AppProperties.instanceOf().getProperty(
								procedureName + "Row"))
				.replace("${METHOD_NAME}", "Call")
				.replace(
						"${CONDITION_CURSOR}",
						"void".equals(AppProperties.instanceOf().getProperty(
								procedureName)) ? "" : "return")
				.replace("${CONDITION_METHOD}", returnCondition  ? "update" : "query");
	}

	private String createServiceProcedureWS(String procedureName,
			String servicePackage, String modelPackage,
			String validationPackage, String rulesPackage, String daoPackage,
			String exceptionPackage, List<ParameterDef> pdList)
			throws IOException {

		String CLASS = readTemplate("JavaServiceProcedureWS.tpl");
		writeTemplate(CLASS, "JavaServiceProcedureWS.tpl");

		String parameterHandle = "";
		String parametersDao = "";

		int i = 0;
		for (ParameterDef pd : pdList) {

			if (i < pdList.size() - 1) {
				parameterHandle += "@WebParam(name = \""
						+ pd.getParameterName() + "\") "
						+ collumnDePara(pd.getDbDataType()) + " "
						+ pd.getParameterName() + ",";
				parametersDao += pd.getParameterName() + ",";

			} else {
				parameterHandle += "@WebParam(name = \""
						+ pd.getParameterName() + "\") "
						+ collumnDePara(pd.getDbDataType()) + " "
						+ pd.getParameterName();
				parametersDao += pd.getParameterName();
			}

			i++;
		}

		CLASS = CLASS.replace("${PARAMETERS_DAO}", parametersDao).replace(
				"${SERVICE_PARAMETERS}", parameterHandle);
		
		boolean returnCondition = "int".equals(AppProperties.instanceOf().getProperty(procedureName)) || 
				"void".equals(AppProperties.instanceOf().getProperty(procedureName));

		return CLASS
				.replace("${CONDITION_IMPORT}", returnCondition ? "" : "import " +  AppProperties.instanceOf().getProperty(procedureName + "_import") + ";\n")
				.replace("${PACKAGE_MODEL}", modelPackage)
				.replace("${CLASS_DAO}", "Call" + getJavaName(procedureName))
				.replace("${PACKAGE_SERVICE}", servicePackage)
				.replace("${PACKAGE_DAO}", daoPackage)
				.replace("${OBJECT_NAME}",
						getObjectJavaName("Call" + getJavaName(procedureName)))
				.replace("${CURSOR}",
						AppProperties.instanceOf().getProperty(procedureName))
				.replace(
						"${ROW}",
						AppProperties.instanceOf().getProperty(
								procedureName + "Row"))
				.replace("${METHOD_NAME}", "Call")
				.replace(
						"${CONDITION_CURSOR}",
						"void".equals(AppProperties.instanceOf().getProperty(
								procedureName)) ? "" : "return")
				.replace("${CONDITION_METHOD}", returnCondition ? "update" : "query");
	}

	private String createFilterGen(String packageHelper) throws IOException {

		String CLASS = readTemplate("JavaFilter.tpl");
		return CLASS.replace("${PACKAGE}", packageHelper);
	}

	private String createCRUDPrepareStatementCuston(String packageName)
			throws IOException {

		String CLASS = readTemplate("JavaCRUDPrepareStatementCuston.tpl");

		return CLASS.replace("${PACKAGE_HELPER}", packageName);
	}

	private String createCRUDPrepareStatement(String packageName)
			throws IOException {

		String CLASS = readTemplate("JavaCRUDPrepareStatement.tpl");
		return CLASS.replace("${PACKAGE_HELPER}", packageName);
	}

	private String createCRUDInterface(String packageName, String packageModel)
			throws IOException {

		String CRUD = readTemplate("JavaCRUDInterface.tpl");
		return CRUD.replace("${PACKAGE}", packageName);
	}

	private String createJdbcTemplate(List<CollumnDef> cd, String tableName,
			String packageName, String packageModel, String packageMapper,
			String packageDao, String sqlPackage, String packageException) throws IOException {

		String CLASS = readTemplate("JavaJdbcTemplate.tpl");
		return CLASS.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${PACKAGE_HELPER}", sqlPackage)
				.replace("${PACKAGE_MODEL}", packageModel)
				.replace("${PACKAGE_MAPPER}", packageMapper)
				.replace("${PACKAGE_DAO}", packageDao)
				.replace("${PACKAGE_EXCEPTION}", packageException);
	}

	private String createSpringListMapperAbstractBean(String packageName)
			throws IOException {

		String listModelRowMapper = readTemplate("SpringListMapperAbstractBean.tpl");
		return listModelRowMapper;
	}

	private String createSpringListMapperBeans(List<CollumnDef> cd,
			String tableName, String packageName, String packageModel, String packageException)
			throws IOException {
		String springListMapperBean = readTemplate("SpringListMapperBeans.tpl");
		String BODY = readTemplate("SpringListMapperBeans_body.tpl");
		return springListMapperBean
				.replace("${PACKAGE}", packageName)
				.replace("${PACKAGE_MODEL}", packageModel)
				.replace("${PACKAGE_EXCEPTION}", packageException)
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${BODY}",
						BODY.replace("${CLASS_MODEL}", getJavaName(tableName)));
	}

	private String createSpringMapperBeans(List<CollumnDef> cd,
			String tableName, String packageName, String packageModel,
			String packageRules, String packageException) throws IOException {

		String injectRules = readTemplate("SpringMapperBeans_AfterRules.tpl");
		String springMapperBeans = readTemplate("SpringMapperBeans.tpl");

		String HADLE = "\t@Override"
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ "\tpublic ${CLASS_MODEL} mapRow(ResultSet rs, int rowNum) throws SQLException {${METHOD_BODY}\t}"
				+ AppProperties.instanceOf().getProperty("END_LINE");
		String METHOD_BODY = AppProperties.instanceOf().getProperty("END_LINE")
				+ "\t\t${TRY}"
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ "\t\t\t${CLASS_MODEL} model = new ${CLASS_MODEL}();"
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ "${SETTERS_MODEL}"
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ "\t\t\tif (${OBJECT_NAME}AfterRules != null)"
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ "\t\t\t\t${OBJECT_NAME}AfterRules.execute(model);"
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ "\t\t\treturn model;\n${CATCH}";
		String TRY = "\n" + "\t\ttry{";
		String CATCH = "\n" + "\t\t}catch(RulesException e){"
				+ AppProperties.instanceOf().getProperty("END_LINE")
				+ "\t\t\tthrow new SQLException(e);" + "\n" + "\t\t}"
				+ AppProperties.instanceOf().getProperty("END_LINE");

		String SETTERS_MODEL = "";
		for (CollumnDef collumnDef : cd) {
			SETTERS_MODEL += "\t\t\tmodel.set" + collumnDef.getPropertName()
					+ "(rs.get" + fieldsParaDe(collumnDef.getCollumnType())
					+ "(\"" + collumnDef.getCollumnName() + "\"));"
					+ AppProperties.instanceOf().getProperty("END_LINE");
		}

		writeTemplate(HADLE, "SpringMapperBeans_handle.tpl");
		writeTemplate(METHOD_BODY, "SpringMapperBeans_body.tpl");
		writeTemplate(TRY, "SpringMapperBeans_body_try.tpl");
		writeTemplate(CATCH, "SpringMapperBeans_body_catch.tpl");

		return (springMapperBeans)
				.replace("${PACKAGE}", packageName)
				.replace("${PACKAGE_MODEL}", packageModel)
				.replace("${PACKAGE_EXCEPTION}", packageException)
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${PACKAGE_RULES}", packageRules)
				.replace("${TABLE_NAME}", getJavaName(tableName))
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${INJECT_RULES}", injectRules)
				.replace("${BODY}",
						HADLE.replace("${CLASS_MODEL}", getJavaName(tableName)))
				.replace(
						"${METHOD_BODY}",
						METHOD_BODY
								.replace("${CLASS_MODEL}",
										getJavaName(tableName))
								.replace("${SETTERS_MODEL}", SETTERS_MODEL)
								.replace("${TRY}", TRY)
								.replace("${CATCH}", CATCH))
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName))
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName))
				.replace("${CLASS_MODEL}", getJavaName(tableName))
				.replace("${OBJECT_NAME}", getObjectJavaName(tableName));
	}

	private String createModelBeans(List<CollumnDef> cd, String tableName,
			String packageName, String fieldPackage) throws IOException {

		String BODY_FIELD = readTemplate("JavaModel_body.tpl");
		String BODY_GET_PROPERTY = readTemplate("JavaModel_getters.tpl");
		String BODY_SET_PROPERTY = readTemplate("JavaModel_setters.tpl");
		String javaBean = readTemplate("JavaModel.tpl");

		String bodyField = "";
		String bodyGet = "";
		String bodySet = "";

		for (CollumnDef collumnDef : cd) {
			bodyField += BODY_FIELD.replace("${COLLUMN_TYPE}",
					collumnDePara(collumnDef.getCollumnType())).replace(
					"${COLLUMN_NAME}", collumnDef.getCollumnName());

			bodyGet += BODY_GET_PROPERTY
					.replace("${COLLUMN_TYPE}",
							collumnDePara(collumnDef.getCollumnType()))
					.replace("${COLLUMN_NAME}", collumnDef.getCollumnName())
					.replace("${PROPERTY_NAME}", collumnDef.getPropertName());

			bodySet += BODY_SET_PROPERTY
					.replace("${COLLUMN_TYPE}",
							collumnDePara(collumnDef.getCollumnType()))
					.replace("${COLLUMN_NAME}", collumnDef.getCollumnName())
					.replace("${PROPERTY_NAME}", collumnDef.getPropertName());
		}

		return javaBean
				.replace("${FIELD_PACKAGE}", fieldPackage)
				.replace("${BODY}", bodyField + bodyGet + bodySet)
				.replace("${TABLE_NAME}", getJavaName(tableName))
				.replace("${SERIAL_VERSION}",
						String.valueOf(System.currentTimeMillis()) + "L")
				.replace("${PACKAGE_NAME}", packageName);
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

	private String getObjectJavaName(String tableName) {
		String javaName = "";

		String[] pattern = tableName.split("[_]");

		for (String field_crack : pattern) {
			javaName += field_crack.substring(0, 1).toUpperCase()
					+ field_crack.substring(1);
		}

		return javaName.substring(0, 1).toLowerCase() + javaName.substring(1);
	}

	private String fieldsParaDe(String fieldType) {

		String type = AppProperties.instanceOf().getProperty(
				"ws-" + fieldType.toLowerCase());

		if (type == null) {
			type = AppProperties.instanceOf().getProperty("ws-default");
		}

		return type;
	}

	private String collumnDePara(String collumnType) {

		String type = AppProperties.instanceOf().getProperty(
				"dao-" + collumnType.toLowerCase());

		if (type == null) {
			type = AppProperties.instanceOf().getProperty("dao-default");
		}

		return type;
	}

	private List<CollumnDef> getTable(String tableName, String schemaName)
			throws ClassNotFoundException, SQLException, IOException {

		String META_DATA_PK_DEF = read(AppProperties.instanceOf().getProperty("DB_TARGET") + File.separatorChar
				+ "TABLE_COMUMNS_NAME_SCHEMA.sql");

		Connection connection = getConnection();
		List<CollumnDef> list = new ArrayList<CollumnDef>();
		PreparedStatement ps = connection.prepareStatement(META_DATA_PK_DEF);
		ps.setString(1, schemaName);
		ps.setString(2, tableName);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			String columnType = rs.getString(3);
			CollumnDef cd = new CollumnDef();
			cd.setCollumnName(rs.getString(2));
			cd.setCollumnType(columnType);
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
		META_DATA_PK_DEF += read(AppProperties.instanceOf().getProperty("DB_TARGET") + File.separatorChar
				+ "TABLE_NAME_SCHEMA.sql");

		System.out.println(META_DATA_PK_DEF);
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
	
	private void createSrcDirctoryFromMavem() throws IOException {
		File dirJava = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "java"
				+ File.separatorChar);
		if (!dirJava.exists()) {
			dirJava.mkdirs();
		}
		
		File dirJavaResource = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "resources"
				+ File.separatorChar);
		if (!dirJavaResource.exists()) {
			dirJavaResource.mkdirs();
		}
		
		File dirJavaWeb = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "webapp"
				+ File.separatorChar);
		if (!dirJavaWeb.exists()) {
			dirJavaWeb.mkdirs();
		}
		
		File dirJavaWebInf = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "webapp"
				+ File.separatorChar
				+ "WEB-INF" 
				+ File.separatorChar);
		if (!dirJavaWebInf.exists()) {
			dirJavaWebInf.mkdirs();
		}
		
		File dirJavaLib = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "webapp"
				+ File.separatorChar
				+ "lib" 
				+ File.separatorChar);
		if (!dirJavaLib.exists()) {
			dirJavaLib.mkdirs();
		}
		
		File dirJavaMetaInf = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "webapp"
				+ File.separatorChar
				+ "META-INF" 
				+ File.separatorChar);
		if (!dirJavaMetaInf.exists()) {
			dirJavaMetaInf.mkdirs();
		}
		
		File dirTest = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "test"
				+ File.separatorChar);
		if (!dirTest.exists()) {
			dirTest.mkdirs();
		}
		
		File dirTestJava = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "test"
				+ File.separatorChar
				+ "java"
				+ File.separatorChar);
		if (!dirTestJava.exists()) {
			dirTestJava.mkdirs();
		}
		
		File dirTestresource = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "test"
				+ File.separatorChar
				+ "resource"
				+ File.separatorChar);
		if (!dirTestresource.exists()) {
			dirTestresource.mkdirs();
		}
	}

	private void write(String javaBean, String className, String packageName)
			throws IOException {
		
		File dir = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "java"
				+ File.separatorChar
				+ packageName
				+ File.separatorChar);
		
		if(!dir.exists()){
			dir.mkdir();
		}
		
		File javaFile = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src"
				+ File.separatorChar
				+ "main"
				+ File.separatorChar
				+ "java"
				+ File.separatorChar
				+ packageName
				+ File.separatorChar
				+ getJavaName(className)
				+ AppProperties.instanceOf().getProperty("EXTESION"));

		FileWriter writer = new FileWriter(javaFile, false);

		writer.write(javaBean);
		writer.close();
	}

	private void writeResource(String resource, String resourceName)
			throws IOException {

		File resourceFile = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "src" 
				+ File.separatorChar 
				+ "main" 
				+ File.separatorChar 
				+ "webapp" 
				+ File.separatorChar 
				+ "WEB-INF" 
				+ File.separatorChar 
				+ resourceName);
		FileWriter writer = new FileWriter(resourceFile, false);

		writer.write(resource);
		writer.close();
	}

	private String readTemplate(String templateName) throws IOException {
		File resourceFile = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "Template"
				+ File.separatorChar
				+ templateName);

		String template = "";
		FileReader reader = new FileReader(resourceFile);

		char[] buffer = new char[Integer.parseInt(AppProperties.instanceOf()
				.getProperty("BUFFER"))];
		while (reader.ready()) {
			reader.read(buffer);
			template += new String(buffer);
		}

		reader.close();

		return template;
	}

	private void writeTemplate(String template, String templateName)
			throws IOException {

		File dir = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar + "Template");
		if (!dir.exists()) {
			dir.mkdirs();
		}

		File resourceFile = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar
				+ "Template"
				+ File.separatorChar
				+ templateName);
		FileWriter writer = new FileWriter(resourceFile, false);

		writer.write(template);
		writer.close();
	}

	private void writeSpringResource(String appContext, String appName)
			throws IOException {
		File dir0 = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar + "src");
		if (!dir0.exists()) {
			dir0.mkdirs();
		}

		File javaFile = new File(AppProperties.instanceOf().getProperty(
				"DIR_GENERATE")
				+ File.separatorChar + "src" + File.separatorChar + appName);
		FileWriter writer = new FileWriter(javaFile, false);

		writer.write(appContext);
		writer.close();
	}
}
