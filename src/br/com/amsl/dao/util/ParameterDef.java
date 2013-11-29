package br.com.amsl.dao.util;

public class ParameterDef {

	private String specificName;
	private int ordinalPosition;
	private String parameterMode;
	private String parameterName;
	private String dbDataType;

	public String getSpecificName() {
		return specificName;
	}

	public void setSpecificName(String specificName) {
		this.specificName = specificName;
	}

	public int getOrdinalPosition() {
		return ordinalPosition;
	}

	public void setOrdinalPosition(int ordinalPosition) {
		this.ordinalPosition = ordinalPosition;
	}

	public String getParameterMode() {
		return parameterMode;
	}

	public void setParameterMode(String parameterMode) {
		this.parameterMode = parameterMode;
	}

	public String getParameterName() {
		return parameterName;
	}

	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}

	public String getDbDataType() {
		return dbDataType;
	}

	public void setDbDataType(String dbDataType) {
		this.dbDataType = dbDataType;
	}
}
