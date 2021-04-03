package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class RedesController {
	
	public RedesController() {
		super();	
	}
	
	public void ip(String so) {
		if(so.contains("Windows")) {
			System.out.println("Windows ainda não implementado.");
		} else if(so.contains("Linux") || so.contains("Mac")) {
			try {
				Process p = Runtime.getRuntime().exec("ifconfg");
				InputStream stream = p.getInputStream();
				InputStreamReader reader = new InputStreamReader(stream);
				BufferedReader buffer = new BufferedReader(reader);
				String line = buffer.readLine();
				
				while(line != null) {
					try {
						Thread.sleep(200);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					if((line.contains("inet") || line.contains("ether")) && !line.contains("inet6")){
						System.out.println(line.trim());
					}
					line = buffer.readLine();
				}
				
			} catch (IOException e) {
				System.err.println("Comando nao encontrado!");
			}
		} else {
			System.err.println("Sistema Operacional não compatível com o programa.");
		}
	}
	
	public void ping(String so){
		String url = "www.google.com";
		if(so.contains("Windows")) {
			System.out.println("Windows ainda não implementado.");
		} else if(so.contains("Linux") || so.contains("Mac")) {
			try {
				Process p = Runtime.getRuntime().exec("ping -c 10 " + url);
				InputStream stream = p.getInputStream();
				InputStreamReader reader = new InputStreamReader(stream);
				BufferedReader buffer = new BufferedReader(reader);
				String line = buffer.readLine();

				Double tempoMedio = 0.0;
				while(line != null){
					if(line.contains("time=")) {
						tempoMedio = tempoMedio + Double.parseDouble(line.split(" ")[6].split("=")[1]);
						System.out.println(line);
					}
					line = buffer.readLine();
				}
				tempoMedio = tempoMedio / 10;
				System.out.printf("Tempo médio de Ping: %.2f \n", tempoMedio);
			} catch (IOException e) {
				System.err.println("Comando nao encontrado!");
			}
		} else {
			System.err.println("Sistema Operacional não compatível com o programa.");
		}
	}	
}