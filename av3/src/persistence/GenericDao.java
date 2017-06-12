package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDao  implements IGenericDao{

	@Override
	public Connection getConnection() throws ClassNotFoundException {
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			c = DriverManager.getConnection("jdbc:jtds:sqlserver://127.0.0.1:1433;DatabaseName=av3;namedPipe=true",
					"Patrick", "pa10pa10");
			System.out.println("Conexao ok");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}
	
	public void fechaConexao() {
		try {
			if (c != null)
				c.close();
			c = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
