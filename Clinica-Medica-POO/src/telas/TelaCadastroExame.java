package telas;

import interfaces.Assinante;
import interfaces.Produtor;
import interfaces.TelaStrategy;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.Pane;

public class TelaCadastroExame implements TelaStrategy, Produtor {
	
	private Pane pane = new Pane();
	private Assinante assinanteComando;
	
	public TelaCadastroExame() {
		Label lblTitulo = new Label("Tela de Cadastro de Exames");
		lblTitulo.relocate(300, 10);
		
		/*Nome*/
		Label lblNome = new Label("Nome:");
		lblNome.relocate(30, 55);
		
		TextField txtNome = new TextField();
		txtNome.relocate(140, 50);
		txtNome.setPrefWidth(200);
		
		/*Valor*/
		Label lblValor = new Label("Valor (R$):");
		lblValor.relocate(430, 55);
		
		TextField txtValor = new TextField();
		txtValor.relocate(540, 50);
		txtValor.setPrefWidth(200);
		
		/*Botão Salvar*/
		Button btnSalvar = new Button("Salvar");
		btnSalvar.relocate(30, 100);
		btnSalvar.setPrefWidth(150);
		
		/*Botão Limpar*/
		Button btnLimpar = new Button("Limpar");
		btnLimpar.relocate(200, 100);
		btnLimpar.setPrefWidth(150);
		
		pane.getChildren().addAll(lblTitulo, lblNome, txtNome, lblValor, txtValor, btnSalvar, btnLimpar);
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