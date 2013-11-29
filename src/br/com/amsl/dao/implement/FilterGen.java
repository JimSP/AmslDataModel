package br.com.amsl.dao.implement;

public class FilterGen {
	private String sqlFilters;
	private Object[] values;

	public String getSqlFilters() {
		return sqlFilters;
	}

	public void setSqlFilters(String sqlFilters) {
		this.sqlFilters = sqlFilters;
	}

	public Object[] getValues() {
		return values;
	}

	public void setValues(Object[] values) {
		this.values = values;
	}
}
