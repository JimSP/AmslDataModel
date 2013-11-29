package br.com.amsl.dao.interfaces;

import java.util.List;

public interface IGrud<T> {

	public List<T> listar();

	public T listar(Long pk);

	public List<T> listar(T parameter);

	public Long inserir(T parameter);
	
	public List<Long> inserir(List<T> parameter);
	
	public Integer excluir();

	public Boolean excluir(Long pk);
	
	public Integer excluir(T parameter);

	public Boolean atualizar(Long pk, T setter);
	
	public Integer atualizar(T filter, T setter);
}