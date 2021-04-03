package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoSQL {
	private static final String URLCON = "jdbc:mariadb://localhost:3306/clinicadb";
	private static final String USER = "root";
	private static final String PASS = "";
	private static ConexaoSQL instancia = null;
	private Connection connection = null;
	
	public static ConexaoSQL instancia() {
		if (instancia == null) {
			instancia = new ConexaoSQL();
		}
		return instancia;
	}
	
	public Connection conexao() {
		try {
			if (connection == null || connection.isClosed() || !connection.isValid(10)) {
				connection = DriverManager.getConnection(URLCON, USER, PASS);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}
	
	private ConexaoSQL() {
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
}