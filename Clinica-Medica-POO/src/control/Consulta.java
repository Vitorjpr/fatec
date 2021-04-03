package control;

import java.time.LocalDate;

public class Consulta {
	
	private int exame;
	private String tipo;
	private Paciente paciente;
	private Medico medico;
	private LocalDate data;
	
	public Consulta(int exame, String tipo, Paciente paciente, Medico medico, LocalDate data) {
		this.setExame(exame);
		this.setTipo(tipo);
		this.setPaciente(paciente);
		this.setMedico(medico);
		this.setData(data);
	}

	public int getExame() {
		return exame;
	}

	public void setExame(int exame) {
		this.exame = exame;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Paciente getPaciente() {
		return paciente;
	}

	public void setPaciente(Paciente paciente) {
		this.paciente = paciente;
	}

	public Medico getMedico() {
		return medico;
	}

	public void setMedico(Medico medico) {
		this.medico = medico;
	}

	public LocalDate getData() {
		return data;
	}

	public void setData(LocalDate data) {
		this.data = data;
	}

	
}