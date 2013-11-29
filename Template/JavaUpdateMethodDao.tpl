	public int update(${DAO_PARAMETERS}){

		return super.update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection connection)
					throws SQLException {
				
				PreparedStatement prepareStatement = connection.prepareStatement(SQL);
				int i = 1;
				${SP_SETTER_PARAMETERS}

				return prepareStatement;
			}
		});
	}