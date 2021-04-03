package control;

import java.time.LocalDate;
import java.util.List;
import interfaces.QuerysInterface;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.LongProperty;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleLongProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import sql.Querys;

public class PacienteControl {
		private ObservableList<Paciente> lista = FXCollections.observableArrayList();
		private IntegerProperty idProperty = new SimpleIntegerProperty(0);
		private StringProperty nomeProperty = new SimpleStringProperty("João");
		private StringProperty telefoneProperty = new SimpleStringProperty("(11)    -    ");
		private StringProperty emailProperty = new SimpleStringProperty("");
		private ObjectProperty<LocalDate> nascimentoProperty = new SimpleObjectProperty<>(LocalDate.now());
		private QuerysInterface pacienteInter = new Querys();
		
	public Paciente getPaciente() {	
		Paciente p = new Paciente();
		p.setNome(nomeProperty.get());
		p.setTelefone(telefoneProperty.get());
		p.setEmail(emailProperty.get());
		p.setNascimento(nascimentoProperty.get());
		return p;
	}
	
	public void setPaciente(Paciente p) { 
		if (p != null)  { 
			nomeProperty.set(p.getNome());
			telefoneProperty.set(p.getTelefone());
			emailProperty.set(p.getEmail());
			nascimentoProperty.set(p.getNascimento());
		}
	}
	
	public void adicionarPaciente() throws QueryException { 
		pacienteInter.adicionarPaciente(getPaciente());
//		pacienteInter.adicionar(paciente);
		
	}
	
	public void removerPaciente() throws QueryException { 
		pacienteInter.removerPaciente(getPaciente());		
	}
	
	public void pesquisarPaciente() throws QueryException {
		List<Paciente> Pacientes = pacienteInter.pesquisarPaciente(this.getNomeProperty().get());
		this.lista.clear();
		this.lista.addAll(Pacientes);
	}
	
	public IntegerProperty getIdProperty() {
		return idProperty;
	}
	public StringProperty getNomeProperty() {
		return nomeProperty;
	}
	public StringProperty getTelefoneProperty() {
		return telefoneProperty;
	}
	public StringProperty getEmailProperty() {
		return emailProperty;
	}
	public ObjectProperty<LocalDate> getNascimentoProperty() {
		return nascimentoProperty;
	}

	public ObservableList<Paciente> getLista() {
		return lista;
	}
}