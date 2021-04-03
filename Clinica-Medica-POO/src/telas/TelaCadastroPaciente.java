package telas;

import interfaces.Assinante;
import interfaces.Produtor;
import interfaces.TelaStrategy;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.Pane;

public class TelaCadastroPaciente implements TelaStrategy, Produtor {
	
	private Pane pane = new Pane();
	private Assinante assinanteComando;
	
	public TelaCadastroPaciente() {
		Label lblTitulo = new Label("Tela de Cadastro de Pacientes");
		lblTitulo.relocate(300, 10);
		
		/*Nome*/
		Label lblNome = new Label("Nome:");
		lblNome.relocate(30, 55);
		
		TextField txtNome = new TextField();
		txtNome.relocate(140, 50);
		txtNome.setPrefWidth(600);
		
		/*Email*/
		Label lblEmail = new Label("Email:");
		lblEmail.relocate(30, 95);
		
		TextField txtEmail = new TextField();
		txtEmail.relocate(140, 90);
		txtEmail.setPrefWidth(600);
		
		/*Telefone*/
		Label lblTel = new Label("Telefone:");
		lblTel.relocate(30, 135);
		
		TextField txtTel = new TextField();
		txtTel.relocate(140, 130);
		txtTel.setPrefWidth(200);
		
		/*Data de Nascimento*/
		Label lblNasc = new Label("Data Nasc:");
		lblNasc.relocate(430, 135);
		
		TextField txtNasc= new TextField();
		txtNasc.relocate(540, 130);
		txtNasc.setPrefWidth(200);
		
		/*Botão Salvar*/
		Button btnSalvar = new Button("Salvar");
		btnSalvar.relocate(30, 180);
		btnSalvar.setPrefWidth(150);
		
		/*Botão Limpar*/
		Button btnLimpar = new Button("Limpar");
		btnLimpar.relocate(200, 180);
		btnLimpar.setPrefWidth(150);
		
		pane.getChildren().addAll(lblTitulo, lblNome, txtNome, 
				                  lblEmail, txtEmail, lblTel, 
				                  txtTel, lblNasc, txtNasc, btnSalvar,
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