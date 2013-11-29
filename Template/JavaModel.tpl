package ${PACKAGE_NAME};

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

import ${FIELD_PACKAGE}.ExecuteField;
import ${FIELD_PACKAGE}.NoValidationClassTarget;

@XmlRootElement(name="${TABLE_NAME}")
public class ${TABLE_NAME} implements Serializable {

private static final long serialVersionUID = ${SERIAL_VERSION};

${BODY}
}