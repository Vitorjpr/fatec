package controller;

import java.awt.Desktop;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.swing.JOptionPane;

public class ArquivosController implements IArquivosController {
	
	File dir;
	
	public ArquivosController() {
		dir = new File(System.getProperty("user.dir") + "/temp");
	}

	@Override
	public void verificaDirTemp() throws IOException {
		File arq = new File(dir, "db.csv");
		
		if (!dir.exists() && !dir.isDirectory()) {
			if(dir.mkdir()) {
				if(arq.createNewFile()) {
					boolean existe = false;
					if(arq.exists()) {
						existe = true;
					}
					String conteudo = "Codigo;Nome;Email\n";
					FileWriter fileWriter = new FileWriter(arq, existe);
					PrintWriter print = new PrintWriter(fileWriter);
					print.write(conteudo);
					print.flush();
					print.close();
					fileWriter.close();
				}
			}
		}
	}

	@Override
	public boolean verificaRegistro(String arquivo, int codigo) throws IOException {
		File arq = new File(dir, arquivo);
		if(arq.exists() && arq.isFile()) {
			FileInputStream fluxo = new FileInputStream(arq);
			InputStreamReader leitor = new InputStreamReader(fluxo);
			BufferedReader buffer = new BufferedReader(leitor);
			String linha = buffer.readLine();
			while(linha != null) {
				String linhaFormatada[] = linha.split(";");
				if(linhaFormatada[0].contains(Integer.toString(codigo))) return true;
				linha = buffer.readLine();
			}
			buffer.close();
			leitor.close();
			fluxo.close();
		} else {
			throw new IOException("Arquivo inválido.");
		}
		
		return false;
	}

	@Override
	public void imprimeCadastro(String arquivo, int codigo) throws IOException {
		File arq = new File(dir, arquivo);
		
		if(verificaRegistro(arquivo, codigo)) {
			FileInputStream fluxo = new FileInputStream(arq);
			InputStreamReader leitor = new InputStreamReader(fluxo);
			BufferedReader buffer = new BufferedReader(leitor);
			String linha = buffer.readLine();
			StringBuffer mostrarDados = new StringBuffer();
			
			while(linha != null) {
				String linhaFormatada[] = linha.split(";");
				if(linhaFormatada[0].contains(Integer.toString(codigo))) {
					mostrarDados.append("Código: " + linhaFormatada[0] + "\n");
					mostrarDados.append("Nome: " + linhaFormatada[1] + "\n");
					mostrarDados.append("Email: " + linhaFormatada[2] + "\n");
				};
				linha = buffer.readLine();
			}
			JOptionPane.showMessageDialog(null, mostrarDados.toString());
			
			buffer.close();
			leitor.close();
			fluxo.close();
		}
	}

	@Override
	public void insereCadastro(String arquivo, int codigo, String nome, String email) throws IOException {
		File arq = new File(dir, arquivo);
		
		if(!verificaRegistro(arquivo, codigo)) {
			if(arq.exists() && arq.isFile()) {		
				String content = Integer.toString(codigo) + ";" + nome + ";" + email + "\n";
				boolean existe = false;
				
				existe = true;
				FileWriter fileWriter = new FileWriter(arq, existe);
				PrintWriter print = new PrintWriter(fileWriter);
				print.write(content);
				print.flush();
				print.close();
				fileWriter.close();
			}
		}
	}
	
	public void abrirArquivo(String name) throws IOException {
		File arq = new File(dir, name);
		if(arq.exists() && arq.isFile()) {
			Desktop desktop = Desktop.getDesktop();
			desktop.open(arq);
		} else {
			throw new IOException("Arquivo inválido");
		}
	}
	
}
