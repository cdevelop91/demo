package demo.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import demo.config.ConexionBD;

public class UsuarioDAO {
    public void guardarUsuario(String nombre) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre) VALUES (?)";

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.executeUpdate();
            
        }  catch (SQLException e) {
            System.err.println("Error al guardar el usuario en la base de datos." + e);
            throw new SQLException("Error al ejecutar la consulta en la base de datos", e);
        }
    }
}