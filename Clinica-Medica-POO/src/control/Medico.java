package control;

public class Medico {

	private String nome;
	private String especialidade;
	
	public Medico(String nome, String especialidade) {
		this.setNome(nome);
		this.setEspecialidade(especialidade);
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEspecialidade() {
		return especialidade;
	}
	
	public void setEspecialidade(String especialidade) {
		this.especialidade = especialidade;
	}
}