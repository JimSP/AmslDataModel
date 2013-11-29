	public ${CURSOR} query(${DAO_PARAMETERS}){

		${CONDIDION_CURSOR} super.query(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection connection)
					throws SQLException {
				
				PreparedStatement prepareStatement = connection.prepareStatement(SQL);
				int i = 1;
				${SP_SETTER_PARAMETERS}

				return prepareStatement;
			}
		}, mapper);
	}