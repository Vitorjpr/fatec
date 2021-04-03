package controller;

import java.util.concurrent.Semaphore;

public class Carros extends Thread{
	
	private int carro;
	private static int csentido = 0;
	private static String sentido;
//	private static String sentidoOp;
	private Semaphore semaforo;
	
	public Carros(int carro, Semaphore semaforo) {
		this.carro = carro;
		this.semaforo = semaforo;
	}
	
	@Override
	public void run() {
		try {
			semaforo.acquire();
			Sentido();
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
			Passando();
			semaforo.release();
		}
		
	}
	
	public void Sentido() {
		if (csentido == 0) {
			sentido = "Norte";
//			sentidoOp = "Sul";
//			System.out.println("#"+carro+" veio do "+sentidoOp+" e parou.");
			csentido++;
		} else if (csentido == 1) {
			sentido = "Sul";
//			sentidoOp = "Norte";
//			System.out.println("#"+carro+" veio do "+sentidoOp+" e parou.");
			csentido++;
		}else if (csentido == 2) {
			sentido = "Leste";
//			sentidoOp = "Oeste";
//			System.out.println("#"+carro+" veio do "+sentidoOp+" e parou.");
			csentido++;
		}else if(csentido == 3) {
			sentido = "Oeste";
//			sentidoOp = "Leste";
//			System.out.println("#"+carro+" veio do "+sentidoOp+" e parou.");
			csentido++;
		}
	}
	
	public void Passando() {
		int tempo = 1500;
		try {
			sleep(tempo);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("#"+carro+" andou e passou para o "+sentido);
	}
	
}
