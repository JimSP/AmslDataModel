package br.com.amsl.dao.util;

public class CollumnDef {
	private String collumnName;
	private String CollumnType;

	public String getCollumnName() {
		return collumnName;
	}

	public void setCollumnName(String collumnName) {
		this.collumnName = collumnName;
	}

	public String getCollumnType() {
		return CollumnType;
	}

	public void setCollumnType(String collumnType) {
		CollumnType = collumnType;
	}
	
	public String getPropertName() {
		String propertyName = "";
		
		String[] pattern = collumnName.split("[_]");
		
		for (String field_crack : pattern) {
			propertyName += field_crack.substring(0,1).toUpperCase() + field_crack.substring(1);
		}
		
		return propertyName;
	}
}
