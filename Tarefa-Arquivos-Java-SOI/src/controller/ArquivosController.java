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

	public ArquivosController() {
		super();
	}
	
	public void execute(String path, String nomeArquivoCSV) {
		try {
			createFile(path, "relatorio.csv");
			openFile(path, "relatorio.csv");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void readDir(String path) throws IOException {
		File dir = new File(path);
		if (dir.exists() && dir.isDirectory()) {
			File files[] = dir.listFiles();
			for(File f : files) {
				if(f.isFile()) {
					System.out.println("     \t" + f.getName());
				} else {
					System.out.println("<DIR>\t" + f.getName());
				}
			}
		} else {
			throw new IOException("Diretório inválido");
		}
	}

	@Override
	public void createFile(String path, String name) throws IOException {
		File dir = new File(path);
		File arq = new File(path, name);
		
		if(dir.exists() && dir.isDirectory()) {
			boolean existe = false;
			if(arq.exists()) {
				existe = true;
			}
			String conteudo = createContentCSV(path, "relatorio.txt");
			FileWriter fileWriter = new FileWriter(arq, existe);
			PrintWriter print = new PrintWriter(fileWriter);
			print.write(conteudo);
			print.flush();
			print.close();
			fileWriter.close();
		} else {
			throw new IOException("Diretório Inválido");
		}
	}

	@Override
	public void readFile(String path, String name) throws IOException {
		File arq = new File(path, name);
		if(arq.exists() && arq.isFile()) {
			FileInputStream fluxo = new FileInputStream(arq);
			InputStreamReader leitor = new InputStreamReader(fluxo);
			BufferedReader buffer = new BufferedReader(leitor);
			String linha = buffer.readLine();
			while(linha != null) { //procurando EOF
				System.out.println(linha);
				linha = buffer.readLine();
			}
			buffer.close();
			leitor.close();
			fluxo.close();
		} else {
			throw new IOException("Arquivo Inválido");
		}
	}

	@Override
	public void openFile(String path, String name) throws IOException {
		File arq = new File(path, name);
		if(arq.exists() && arq.isFile()) {
			Desktop desktop = Desktop.getDesktop();
			desktop.open(arq);
		} else {
			throw new IOException("Arquivo inválido");
		}
	}

	private String createContentCSV(String path, String name) throws IOException {
		File arq = new File(path, name);
		StringBuffer content = new StringBuffer();
		if(arq.exists() && arq.isFile()) {
			FileInputStream fluxo = new FileInputStream(arq);
			InputStreamReader leitor = new InputStreamReader(fluxo);
			BufferedReader buffer = new BufferedReader(leitor);
			String linha = buffer.readLine();
			while(linha != null) { //procurando EOF
				content.append(linha.replace(" ", ";"));
				content.append("\n");
				linha = buffer.readLine();
			}
			buffer.close();
			leitor.close();
			fluxo.close();
		} else {
			throw new IOException("Arquivo Inválido");
		}
		return content.toString();
	}
}
