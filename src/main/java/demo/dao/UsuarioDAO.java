package demo.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import demo.config.ConexionBD;
import demo.model.Usuario;

public class UsuarioDAO {
	
    public void guardarUsuario(String nombre, String paterno, String materno) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, paterno, materno) VALUES (?,?,?)";

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, paterno);
            ps.setString(3, materno);
            ps.executeUpdate();
            
        }  catch (SQLException e) {
            System.err.println("Error al guardar el usuario en la base de datos." + e);
            throw new SQLException("Error al ejecutar la consulta en la base de datos", e);
        }
    }
    
    public ArrayList<Usuario> listarUsuarios() {
        String sql = "SELECT * FROM usuarios;"; 
        ArrayList<Usuario> results = new ArrayList<>();

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setPaterno(rs.getString("paterno"));
                usuario.setMaterno(rs.getString("materno"));
 
                results.add(usuario);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return results;
    }
    
    public void borrarUsuario(int usuarioId) throws SQLException {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            ps.executeUpdate();
        }
    }
    
    public void editarUsuario(int id, String nombre, String paterno, String materno) throws SQLException {
        String sql = "UPDATE usuarios SET nombre = ?, paterno = ?, materno = ? WHERE id = ?";

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, paterno);
            ps.setString(3, materno);
            ps.setInt(4, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al editar el usuario en la base de datos." + e);
            throw new SQLException("Error al ejecutar la consulta en la base de datos", e);
        }
    }
    
}