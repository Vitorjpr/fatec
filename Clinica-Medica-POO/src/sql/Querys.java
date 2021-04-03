package sql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import control.Paciente;
import control.Exame;
import control.Usuario;
import control.Medico;
import control.Consulta;
import control.QueryException;
import interfaces.QuerysInterface;

public class Querys implements QuerysInterface{
	
	public Querys() {
		
	}
	
	@Override
	public void adicionarPaciente(Paciente p) throws QueryException {		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "INSERT INTO pacientes (id, nome, telefone, email, nascimento)" + "VALUES (?, ?, ?, ?, ?)";
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(2,p.getNome());
			st.setString(3,p.getTelefone());
			st.setString(4,p.getEmail());
			st.setDate(5, java.sql.Date.valueOf(p.getNascimento()));
			st.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		} 
	}
	
	@Override
	public List<Paciente> pesquisarPaciente(String nome) throws QueryException {
		List<Paciente> lista = new ArrayList<>();		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "SELECT * FROM pacientes WHERE nome like ?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, "%" + nome + "%");
			ResultSet rs = st.executeQuery();
			while (rs.next()) { 
				Paciente p = new Paciente();
				p.setNome(rs.getString("nome"));
				p.setTelefone(rs.getString("telefone"));
				p.setEmail(rs.getString("email"));
				p.setNascimento(rs.getDate("nascimento").toLocalDate());
				lista.add(p);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		}
		return lista;
	}
	
	@Override
	public void removerPaciente(Paciente p) throws QueryException {		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "DELETE FROM pacientes WHERE id = ?";
			PreparedStatement st = con.prepareStatement(sql);
			st.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		} 
	}
	
	@Override
	public void adicionarExame(Exame ex) throws QueryException {		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "INSERT INTO exames (id, nome, valor)" + "VALUES (?, ?, ?)";
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1,ex.getId());
			st.setString(2,ex.getNome());
			st.setDouble(3,ex.getValor());
			st.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		} 
	}
	
	@Override
	public List<Exame> pesquisarExame(String nome) throws QueryException {
		List<Exame> lista = new ArrayList<>();		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "SELECT * FROM exames WHERE nome like ?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, "%" + nome + "%");
			ResultSet rs = st.executeQuery();
			while (rs.next()) { 
				Exame ex = new Exame();
				ex.setId(rs.getInt("id"));
				ex.setNome(rs.getString("nome"));
				ex.setValor(Double.parseDouble(rs.getString("valor")));
				lista.add(ex);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		}
		return lista;
	}
	
	@Override
	public void removerExame(Exame ex) throws QueryException {		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "DELETE FROM exames WHERE id = ?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1,ex.getId());
			st.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		} 
	}
	
	@Override
	public void adicionarUser(Usuario u) throws QueryException {		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "INSERT INTO users (id, nome, senha)" + "VALUES (?, ?, ?)";
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1,u.getId());
			st.setString(2,u.getNome());
			st.setString(3,u.getSenha());
			st.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		} 
	}
	
	@Override
	public List<Usuario> pesquisarUser(String nome) throws QueryException {
		List<Usuario> lista = new ArrayList<>();		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "SELECT * FROM users WHERE nome like ?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, "%" + nome + "%");
			ResultSet rs = st.executeQuery();
			while (rs.next()) { 
				Usuario u = new Usuario();
				u.setId(rs.getInt("id"));
				u.setNome(rs.getString("nome"));
				u.setSenha(rs.getString("senha"));
				lista.add(u);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		}
		return lista;
	}
	
	@Override
	public void removerUser(Usuario u) throws QueryException {		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "DELETE FROM users WHERE id = ?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1,u.getId());
			st.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		} 
	}
	
	@Override
	public void adicionarMedico(Medico m) throws QueryException {		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "INSERT INTO medicos (id, nome, especialidade)" + "VALUES (?, ?, ?)";
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1,m.getId());
			st.setString(2,m.getNome());
			st.setString(3,m.getEspecialidade());;
			st.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		} 
	}
	
	@Override
	public List<Medico> pesquisarMedico(String nome) throws QueryException {
		List<Medico> lista = new ArrayList<>();		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "SELECT * FROM medicos WHERE nome like ?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, "%" + nome + "%");
			ResultSet rs = st.executeQuery();
			while (rs.next()) { 
				Medico m = new Medico();
				m.setId(rs.getInt("id"));
				m.setNome(rs.getString("nome"));
				m.setEspecialidade(rs.getString("especialidade"));
				lista.add(m);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		}
		return lista;
	}
	
	@Override
	public void removerMedico(Medico m) throws QueryException {		
		try {
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "DELETE FROM medicos WHERE id = ?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1,m.getId());
			st.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		} 
	}
	
	@Override
	public void adicionarConsulta(String exame, String paciente, String medico) throws QueryException {		
		try {
//			Inicia a conexão
			Connection con = ConexaoSQL.instancia().conexao();
			String insql = "INSERT INTO consultas (exame, tipo, paciente, medico, data)" + "VALUES (?, ?, ?, ?, ?)";
			PreparedStatement inst = con.prepareStatement(insql);
			
//			Pesquisa Exame e pega Id
			String exsql = "SELECT * FROM exames WHERE nome like ?";
			PreparedStatement exst = con.prepareStatement(exsql);
			exst.setString(1, "%" + exame + "%");
			ResultSet exrs = exst.executeQuery();			
			if (exrs.first()) {
				inst.setInt(1,exrs.getInt("id"));
			}
			
//			Pesquisa Pacientes e pega Id
			String pacsql = "SELECT * FROM pacientes WHERE nome like ?";
			PreparedStatement pacst = con.prepareStatement(pacsql);
			pacst.setString(1, "%" + paciente + "%");
			ResultSet pcrs = pacst.executeQuery();
			if (pcrs.first()) {
				inst.setInt(3,pcrs.getInt("id"));
			}
			
//			Pesquisa Medicose pega Id e Especialidade
			String medsql = "SELECT * FROM medicos WHERE nome like ?";
			PreparedStatement medst = con.prepareStatement(medsql);
			medst.setString(1, "%" + medico + "%");
			ResultSet medrs = medst.executeQuery();
			if (medrs.first()) {
				inst.setString(2,medrs.getString("especialidade"));
				inst.setInt(4,medrs.getInt("id"));
			}
			LocalDate now = LocalDate.now();
			inst.setDate(5, java.sql.Date.valueOf(now));
			inst.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		}		
	}
	
	@Override
	public List<Consulta> pesquisarConsulta(String exame) throws QueryException {
		List<Consulta> lista = new ArrayList<>();		
		try {			
			Connection con = ConexaoSQL.instancia().conexao();
			String sql = "SELECT * FROM consultas WHERE exame = ?";
			PreparedStatement cst = con.prepareStatement(sql);
			
			String exsql = "SELECT * FROM exames WHERE nome like ?";
			PreparedStatement exst = con.prepareStatement(exsql);
			exst.setString(1, "%" + exame + "%");
			ResultSet exrs = exst.executeQuery();
			if (exrs.first()) {
				cst.setInt(1,exrs.getInt("id"));
				ResultSet crs = cst.executeQuery();
				while (crs.next()) {
					Consulta c = new Consulta();
					c.setId(crs.getInt("id"));
					c.setExame(crs.getInt("exame"));
					c.setTipo(crs.getString("tipo"));
					c.setPaciente(crs.getInt("paciente"));
					c.setMedico(crs.getInt("medico"));
					c.setData(crs.getDate("data").toLocalDate());
					lista.add(c);
				}
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new QueryException(e);
		}
		return lista;
	}
	
}