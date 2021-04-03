package control;

import java.time.LocalDate;

public class Paciente {

	private String nome;
	private String telefone;
	private String email;
	private LocalDate nascimento;

	public Paciente() {
		super();
	}
	
	public Paciente(String nome, String telefone, String email, LocalDate nascimento) {
		this.setNome(nome);
		this.setTelefone(telefone);
		this.setEmail(email);
		this.setNascimento(nascimento);
	}

	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public LocalDate getNascimento() {
		return nascimento;
	}

	public void setNascimento(LocalDate nascimento) {
		this.nascimento = nascimento;
	}
	
}