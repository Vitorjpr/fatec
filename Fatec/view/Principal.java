package view;

import java.util.concurrent.Semaphore;

import controller.Carros;

public class Principal {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int permissoes = 1;
		Semaphore semaforo = new Semaphore(permissoes);
		
		for (int carro = 0; carro <4; carro++) {
			Thread tcarro = new Carros(carro, semaforo);
			tcarro.start();
		}
	}

}
