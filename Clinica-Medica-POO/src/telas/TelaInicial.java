package telas;

import interfaces.Assinante;
import interfaces.Produtor;
import interfaces.TelaStrategy;
import javafx.scene.control.Label;
import javafx.scene.layout.Pane;

public class TelaInicial implements TelaStrategy, Produtor {
	
	private Pane pane = new Pane();
	private Assinante assinanteComando;
	
	public TelaInicial() { 
		Label lblTitulo = new Label("Bem vindo ao Programa!");
		lblTitulo.relocate(300, 10);
		pane.getChildren().addAll(lblTitulo);
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