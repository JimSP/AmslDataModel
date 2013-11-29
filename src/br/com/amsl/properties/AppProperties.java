package br.com.amsl.properties;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class AppProperties extends Properties {

	private static final long serialVersionUID = 4408418694809890352L;

	private static AppProperties thisInstance = new AppProperties();

	public static AppProperties instanceOf() {
		return AppProperties.thisInstance;
	}

	public void load() {
		
		/**************************************
		 * 
		 **************************************/

		//System.out.println("carregando arquivo app.properties");
		InputStream reader = null;

		try {
			
			/**************************************
			 * 
			 **************************************/

			reader = new FileInputStream("app.properties");
			super.load(reader);
		} catch (FileNotFoundException e) {
			//System.out.println("arquivo app.properties não encontrado");
			e.printStackTrace();
		} catch (IOException e) {
			//System.out.println("erro ao tentar abrir arquivo app.properties");
			e.printStackTrace();
		}
	}

	private AppProperties() {

	}
}
