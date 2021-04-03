package view;

import java.util.concurrent.Semaphore;

import controller.ThreadCruzamento;

public class Principal {

	public static void main(String[] args) {
		
		Semaphore semaforo = new Semaphore(1);
		
		
		for(int idCarro = 0; idCarro < 4; idCarro++) {
			Thread threadCruzamento = new ThreadCruzamento(idCarro, semaforo);
			threadCruzamento.start();
		}
		

	}

}
