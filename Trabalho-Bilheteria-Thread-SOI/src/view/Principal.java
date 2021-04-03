package view;

import java.util.concurrent.Semaphore;
import controller.BilheteriaThread;

public class Principal {

	public static void main(String[] args) {
		Semaphore semaforo = new Semaphore(1);
		for(int i = 0; i < 300; i++) {
			Thread bilheteria = new BilheteriaThread(i, semaforo);
			bilheteria.start();
		}
	}

}
