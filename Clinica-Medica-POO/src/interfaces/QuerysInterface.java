package interfaces;

import java.util.List;

import control.Paciente;
import control.Consulta;
import control.Exame;
import control.Usuario;
import control.Medico;
import control.QueryException;

public interface QuerysInterface {
	void adicionarPaciente(Paciente p) throws QueryException;
	void removerPaciente(Paciente p) throws QueryException;
	List<Paciente> pesquisarPaciente(String nome) throws QueryException;
	void adicionarExame(Exame ex) throws QueryException;
	void removerExame(Exame ex) throws QueryException;
	List<Exame> pesquisarExame(String nome) throws QueryException;
	void adicionarMedico(Medico m) throws QueryException;
	void removerMedico(Medico m) throws QueryException;
	List<Medico> pesquisarMedico(String nome) throws QueryException;
	void adicionarUser(Usuario u) throws QueryException;
	void removerUser(Usuario u) throws QueryException;
	List<Usuario> pesquisarUser(String nome) throws QueryException;
	void adicionarConsulta(String exame, String paciente, String medico) throws QueryException;
	List<Consulta> pesquisarConsulta(String exame) throws QueryException;
}