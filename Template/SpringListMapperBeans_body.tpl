	public ${CLASS_MODEL} callBackObject(ResultSet rs, int rowNum) throws SQLException {

		return rowMapper.mapRow(rs, rowNum);
	}
