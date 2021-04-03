package view;

import java.util.Scanner;

import javax.swing.JOptionPane;

import controller.RedesController;

public class Main {

	public static void main(String[] args) {
		String os = System.getProperty("os.name");
		String ver = System.getProperty("os.version");
		Scanner input = new Scanner(System.in);
		
		int decisaoUsuario = 0;
		while(decisaoUsuario != 99) {
			decisaoUsuario = Integer.parseInt(JOptionPane.showInputDialog("1-Ping\n2-IP\n99-Sair"));
			switch(decisaoUsuario) {
				case 1:
					RedesController rcIp = new RedesController();
					rcIp.ip(os);
					break;
					
				case 2:
					RedesController rcPing = new RedesController();
					rcPing.ping(os);
					break;
				
				default:
					JOptionPane.showMessageDialog(null,"Valor inv�lido, digite novamente");
			}
		}
		
		System.out.println("\n\nExecucao finalizada!");
	}
}