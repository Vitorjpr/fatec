package view;

import java.io.IOException;
import java.util.Scanner;

import javax.swing.JOptionPane;

import controller.ArquivosController;

public class Principal {
	
	static int codigoAutomatico;

	public static void main(String[] args) {
		ArquivosController controlador = new ArquivosController();
		codigoAutomatico = 1;
		
		try {
			controlador.verificaDirTemp();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Scanner input = new Scanner(System.in);
		
		int opcaoUser = 0;
		int codigo;
		String nome;
		String email;
		
		do {
			opcaoUser = Integer.parseInt(JOptionPane.showInputDialog("1) Imprime cadastro\n2) Insere Cadastro\n3) Abrir arquivo\n99) Fechar aplicação"));
			
			switch(opcaoUser) {
				case 1:
					codigo = Integer.parseInt(JOptionPane.showInputDialog("Insira o código: "));
					try {
						controlador.imprimeCadastro("db.csv", codigo);
					} catch (IOException e) {
						e.printStackTrace();
					}
					break;
					
				case 2:
					codigo = codigoAutomatico;
					codigoAutomatico++;
					nome = JOptionPane.showInputDialog("Insira o nome: ");
					email = JOptionPane.showInputDialog("Insira o email: ");
					try {
						controlador.insereCadastro("db.csv", codigo, nome, email);
					} catch (IOException e) {
						e.printStackTrace();
					}
					break;
					
				case 3:
					try {
						controlador.abrirArquivo("db.csv");
					} catch (IOException e) {
						e.printStackTrace();
					}
					break;
					
				case 99:
					JOptionPane.showMessageDialog(null, "Encerrando...");
					break;
			}
		} while(opcaoUser != 99);
	}

}
