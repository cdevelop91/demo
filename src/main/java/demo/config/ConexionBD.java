package demo.config;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class ConexionBD {
    private static final String JNDI_NAME = "java:/comp/env/jdbc/miDataSource";

    public static Connection getConnection() throws SQLException {
        try {
            InitialContext ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup(JNDI_NAME);
            return ds.getConnection();
        } catch (Exception e) {
        	System.out.println(">>Error: " +e);
            throw new SQLException("Error al buscar el DataSource en JNDI", e);
        }
    }
}
