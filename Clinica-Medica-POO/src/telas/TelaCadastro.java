package telas;

import interfaces.Assinante;
import interfaces.Produtor;
import interfaces.TelaStrategy;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.Pane;

public class TelaCadastro implements TelaStrategy, Produtor {
	
	private FlowPane pane = new FlowPane();
	private Assinante assinanteComando;
	
	public TelaCadastro() { 
		pane.getChildren().addAll(new Label("Tela de Cadastro"));
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