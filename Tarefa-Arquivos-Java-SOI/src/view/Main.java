package view;

import java.io.IOException;

import controller.ArquivosController;

public class Main {

	public static void main(String[] args) {
		ArquivosController controlador = new ArquivosController();
		String pathAtual = System.getProperty("user.dir");
		controlador.execute(pathAtual + "/relatorios", "relatorio.csv");
	}

}
