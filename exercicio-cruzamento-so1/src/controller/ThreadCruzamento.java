package controller;

import java.util.concurrent.Semaphore;

public class ThreadCruzamento extends Thread {
	
	private String sentido[] = {"Norte", "Sul", "Leste", "Oeste"};
	private Integer idCarro;
	private Semaphore semaforo;
	
	public ThreadCruzamento(Integer idCarro, Semaphore semaforo) {
		this.idCarro = idCarro;
		this.semaforo = semaforo;
	}
	
	public void run() {
		try {
			semaforo.acquire();
			avancar(this.idCarro);
		} catch (InterruptedException e) {
			e.printStackTrace();
		} finally {
			semaforo.release();
		}
	}
	
	public void avancar(Integer idCarro) {
		switch(idCarro) {
			case 0:
				System.out.println("O carro esta indo no sentido " + sentido[idCarro]);
				break;
				
			case 1:
				System.out.println("O carro esta indo no sentido " + sentido[idCarro]);
				break;
				
			case 2:
				System.out.println("O carro esta indo no sentido " + sentido[idCarro]);
				break;
				
			case 3:
				System.out.println("O carro esta indo no sentido " + sentido[idCarro]);
				break;
		}
	}
}
