package telas;

import javax.swing.JOptionPane;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;
import main.Main;

public class TelaLogin extends Application implements EventHandler<ActionEvent>{
	
	Label lblUsuario = new Label("Usuário: ");
	Label lblSenha = new Label("Senha: ");
	TextField txtUsuario = new TextField();
	TextField txtSenha = new TextField();
	Button btnEntrar = new Button("Entrar");
	Button btnEsqueci = new Button("Esqueci a senha");

	@Override
	public void start(Stage stageLogin) throws Exception {
		GridPane pL = new GridPane();
		Scene sncLogin = new Scene(pL, 230, 115);		
		btnEntrar.setOnAction(this);		
		btnEsqueci.setOnAction(this);
		pL.add(lblUsuario, 1, 1);
		pL.add(txtUsuario, 2, 1);
		pL.add(lblSenha, 1, 2);
		pL.add(txtSenha, 2, 2);
		pL.add(btnEntrar, 1, 3);
		pL.add(btnEsqueci, 2, 3);
		pL.setHgap(10);
		pL.setVgap(10);
		stageLogin.setScene(sncLogin);
		stageLogin.setTitle("Login");
		stageLogin.show();
		}

	@Override
	public void handle(ActionEvent e) {
		if (e.getTarget() == btnEntrar) {
			if(txtUsuario.equals("medico") && txtSenha.equals("123456")) {
				Application.launch(Main.class);
			}else {
				JOptionPane.showMessageDialog(null, "Login e senha inválidos", null, 0);
			}
		}
		
	}

}