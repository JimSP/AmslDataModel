package ${PACKAGE};

import java.util.List;

import javax.sql.DataSource;

public interface ICRUD<T> {

	public List<T> listar();

	public T listar(Long pk);

	public List<T> listar(T parameter);

	public Long inserir(T parameter);

	public List<Long> inserir(List<T> parameter);

	public Integer excluir();

	public Boolean excluir(Long pk);

	public Integer excluir(T parameter);

	public Integer atualizar(T filter, T setter);

	public Boolean atualizar(Long pk, T setter);

	public void setDataSource(DataSource datasource);

}