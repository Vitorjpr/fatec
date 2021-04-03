package main;

import control.Paciente;
import interfaces.Assinante;
import interfaces.TelaStrategy;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;
import telas.TelaCadastroPaciente;
import telas.TelaCadastroConsulta;
import telas.TelaCadastroMedico;
import telas.TelaCadastroExame;
import telas.TelaInicial;
import telas.TelaLogin;
import control.PacienteControl;
import interfaces.QuerysInterface;
import sql.Querys;

public class Main extends Application implements EventHandler<ActionEvent>, Assinante {
	
	private BorderPane panePrincipal = new BorderPane();
	
	private TelaCadastroConsulta telaCadastroConsulta = new TelaCadastroConsulta();
	private TelaCadastroPaciente telaCadastroPaciente = new TelaCadastroPaciente();
	private TelaCadastroMedico telaCadastroMedico = new TelaCadastroMedico();
	private TelaCadastroExame telaCadastroExame = new TelaCadastroExame();
	private TelaInicial telaInicial = new TelaInicial();
	
	private TelaStrategy tela = telaInicial;
	
	private MenuBar mnuPrincipal = new MenuBar();
	
	private Menu mnuMenu = new Menu("Menu");
	private Menu mnuSair = new Menu("Sair");
	
	private MenuItem mnuCadastroPaciente = new MenuItem("Cadastro de Paciente");
	private MenuItem mnuCadastroMedico = new MenuItem("Cadastro de Medico");
	private MenuItem mnuCadastroExames = new MenuItem("Cadastrar Exames");
	private MenuItem mnuConsultas = new MenuItem("Cadastrar Consulta");
	private MenuItem mnuSairSist = new MenuItem("Sair");
	
	
	
	@Override
	public void start(Stage stage) { 
		Scene scn = new Scene(panePrincipal, 800, 600);
		
		panePrincipal.setTop(mnuPrincipal);
		mnuPrincipal.getMenus().addAll(mnuMenu, mnuSair);
		
		mnuMenu.getItems().addAll(mnuCadastroPaciente, mnuCadastroMedico, mnuCadastroExames, mnuConsultas);
		mnuSair.getItems().addAll(mnuSairSist);
		
		mnuCadastroPaciente.setOnAction(this);
		mnuCadastroMedico.setOnAction(this);
		mnuCadastroExames.setOnAction(this);
		mnuConsultas.setOnAction(this);
		mnuSairSist.setOnAction(this);
		
		telaCadastroConsulta.setAssinanteComando(this);
		
		this.telaContext();
		
		stage.setScene(scn);
		stage.setTitle("Tela Inicial");
		stage.show();
	}
	
	public static void main(String[] args) {
//		Teste SQL
		QuerysInterface control = new Querys();
//		Inclusão de Paciente
		/*
		Paciente paciente = new Paciente();
		paciente.setNome("Rafael");
		paciente.setTelefone("1124813695");
		paciente.setEmail("rafael.teste@gmail.com");
		paciente.setNascimento(java.sql.Date.valueOf("1998-04-10").toLocalDate());
		try {
			control.adicionarConsulta(exame, paciente, medico);
			System.out.println("Consulta: " + exame + " adicionado");
			control.remover(paciente);
			System.out.println("Paciente: " + paciente.getNome() + " removido");
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		
//		Inclusão de Consulta
		String exame = "Hemograma";
		String paciente = "Rafael";
		String medico = "Satoshi";
//		String data = "2020-12-09";
		try {
//			control.adicionarConsulta(exame, paciente, medico);
			System.out.println("Consulta: " + exame + " adicionado");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
//		Application.launch(TelaLogin.class, args);
		Application.launch(Main.class, args);
	}

	@Override
	public void handle(ActionEvent e) {
		if (e.getTarget() == mnuSairSist) { 
			this.executarComando("sair");
		} else if (e.getTarget() == mnuCadastroPaciente) { 
			this.executarComando("Cadastro de Paciente");
		} else if(e.getTarget() == mnuCadastroMedico) {
			this.executarComando("Cadastro de Medico");
		} else if (e.getTarget() == mnuCadastroExames) {
			this.executarComando("Cadastrar Exames");
		} else if (e.getTarget() == mnuConsultas) {
			this.executarComando("Cadastrar Consulta");
		}
	}
	
	public void telaContext() { 
		panePrincipal.setCenter(tela.getTela());
	}

	@Override
	public void executarComando(String cmd) {
		if ("sair".equals(cmd)) { 
			System.exit(0);
		} else if ("Cadastro de Paciente".equals(cmd)) { 
			tela = telaCadastroPaciente;
		} else if ("Cadastro de Medico".equals(cmd)) {
			tela = telaCadastroMedico;
		} else if ("Cadastrar Exames".equals(cmd)) { 
			tela = telaCadastroExame;
		} else if ("Cadastrar Consulta".equals(cmd)) { 
			tela = telaCadastroConsulta;
		}
		this.telaContext();
	}
}