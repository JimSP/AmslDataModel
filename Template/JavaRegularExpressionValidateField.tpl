package ${PACKAGE_NAME};

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegularExpressionValidadeField {
	
	private Pattern pattern;
	private Matcher matcher;
	
	public boolean executeFild(String valueString, String regularExpression) {

		pattern = Pattern.compile(regularExpression);
		matcher = pattern.matcher(valueString);

		return matcher.find();
	}
}
