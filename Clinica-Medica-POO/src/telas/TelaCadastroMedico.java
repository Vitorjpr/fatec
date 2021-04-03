package telas;

import interfaces.Assinante;
import interfaces.Produtor;
import interfaces.TelaStrategy;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.Pane;

public class TelaCadastroMedico implements TelaStrategy, Produtor {
	
	private Pane pane = new Pane();
	private Assinante assinanteComando;
	
	public TelaCadastroMedico() {
		Label lblTitulo = new Label("Tela de Cadastro de Medicos");
		lblTitulo.relocate(300, 10);
		
		/*Nome*/
		Label lblNome = new Label("Nome:");
		lblNome.relocate(30, 55);
		
		TextField txtNome = new TextField();
		txtNome.relocate(140, 50);
		txtNome.setPrefWidth(600);
		
		/*Especialidade*/
		Label lblEspecialidade = new Label("Especialidade:");
		lblEspecialidade.relocate(30, 95);
		
		TextField txtEspecialidade = new TextField();
		txtEspecialidade.relocate(140, 90);
		txtEspecialidade.setPrefWidth(600);
		
		/*Botão Salvar*/
		Button btnSalvar = new Button("Salvar");
		btnSalvar.relocate(30, 140);
		btnSalvar.setPrefWidth(150);
		
		/*Botão Limpar*/
		Button btnLimpar = new Button("Limpar");
		btnLimpar.relocate(200, 140);
		btnLimpar.setPrefWidth(150);
		
		pane.getChildren().addAll(lblTitulo, lblNome, txtNome, 
								  lblEspecialidade, txtEspecialidade, btnSalvar,
				                  btnLimpar);
	}
	
	@Override
	public Pane getTela() {
		return pane;
	}

	@Override
	public void setAssinanteComando(Assinante a) {
		this.assinanteComando = a;	
	}

	@Override
	public void acionarComando(String cmd) {
		this.assinanteComando.executarComando(cmd);
	}
}