package ${PACKAGE_NAME};

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface ExecuteField {
	String regularExpression() default "";
	Class<?> targetValidationClass() default NoValidationClassTarget.class;
}