package telas;

import interfaces.Assinante;
import interfaces.Produtor;
import interfaces.TelaStrategy;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.Pane;

public class TelaCadastroConsulta implements TelaStrategy, Produtor {
	
	private Pane pane = new Pane();
	private Assinante assinanteComando;
	
	public TelaCadastroConsulta() { 
		Label lblTitulo = new Label("Tela de Cadastro de Consultas");
		lblTitulo.relocate(300, 10);
		
		/*Exame*/
		Label lblExame = new Label("Exame:");
		lblExame.relocate(30, 55);
		
		TextField txtExame = new TextField();
		txtExame.relocate(140, 50);
		txtExame.setPrefWidth(600);
		
		/*Tipo*/
		Label lblTipo= new Label("Tipo:");
		lblTipo.relocate(30, 95);
		
		TextField txtTipo = new TextField();
		txtTipo.relocate(140, 90);
		txtTipo.setPrefWidth(600);
		
		/*Paciente*/
		Label lblPaciente = new Label("Paciente:");
		lblPaciente.relocate(30, 135);
		
		TextField txtPaciente = new TextField();
		txtPaciente.relocate(140, 130);
		txtPaciente.setPrefWidth(200);
		
		/*Medico*/
		Label lblMedico = new Label("Medico:");
		lblMedico.relocate(430, 135);
		
		TextField txtMedico = new TextField();
		txtMedico.relocate(540, 130);
		txtMedico.setPrefWidth(200);
		
		/*Data*/
		Label lblData = new Label("Data:");
		lblData.relocate(30, 175);
		
		TextField txtData = new TextField();
		txtData.relocate(140, 170);
		txtData.setPrefWidth(200);
		
		/*Botão Salvar*/
		Button btnSalvar = new Button("Salvar");
		btnSalvar.relocate(30, 220);
		btnSalvar.setPrefWidth(150);
		
		/*Botão Limpar*/
		Button btnLimpar = new Button("Limpar");
		btnLimpar.relocate(200, 220);
		btnLimpar.setPrefWidth(150);
		
		pane.getChildren().addAll(lblTitulo, lblExame, txtExame, lblTipo, txtTipo, lblPaciente, txtPaciente,
								  lblMedico, txtMedico, lblData, txtData, btnSalvar, btnLimpar);
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