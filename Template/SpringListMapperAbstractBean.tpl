package mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import org.springframework.jdbc.core.RowMapper;

public abstract class ListModelRowMapper<T> implements RowMapper<List<T>> {

	private List<T> list = new ArrayList<T>();

	public List<T> mapRow(ResultSet rs, int rowNum) throws SQLException {
		list.add(callBackObject(rs, rowNum));
		return list;
	}
	public abstract T callBackObject(ResultSet rs, int rowNum)
			throws SQLException;
}