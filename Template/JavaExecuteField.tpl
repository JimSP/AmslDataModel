package ${PACKAGE_NAME};

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;

import ${PACKAGE_EXCEPTION}.ExecuteFieldException;

public abstract class ExecuteFieldBase {

	public void execute(Object parameter) throws ExecuteFieldException,
			IllegalAccessException, IllegalArgumentException,
			InvocationTargetException, NoSuchMethodException,
			SecurityException, InstantiationException {
		Field[] fields = parameter.getClass().getFields();

		for (Field field : fields) {

			ExecuteField annotation = field.getAnnotation(ExecuteField.class);

			if (annotation != null) {
				String regularExpression = annotation.regularExpression();
				Class<?> target = annotation.targetValidationClass();

				Object value = parameter
						.getClass()
						.getMethod(
								"get"
										+ field.getName().substring(0, 1)
												.toUpperCase()
										+ field.getName().substring(1),
								new Class[0]).invoke(parameter, new Object[0]);

				try {
					if ("".equals(regularExpression)) {
						RegularExpressionValidadeField revf = new RegularExpressionValidadeField();
						revf.executeFild(String.valueOf(value),
								regularExpression);
					}
				} catch (Exception e) {
					throw new ExecuteFieldException(
							"RegularExpression error. Field Name:"
									+ field.getName() + ", Field Type:"
									+ field.getType().getName()
									+ ", Field Value:" + value, e);
				}

				ITargetClassValidationField targetInterface = null;

				if (!target.equals(NoValidationClassTarget.class)) {
					targetInterface = (ITargetClassValidationField) target
							.getConstructor(new Class[0]).newInstance(
									new Object[0]);

				}

				try {
					targetInterface.ExecuteField(parameter);
				} catch (Exception e) {
					throw new ExecuteFieldException(targetInterface.getClass()
							+ " error. Field Name:" + field.getName()
							+ ", Field Type:" + field.getType().getName()
							+ ", Field Value:" + value, e);
				}
			}
		}
	}

}
