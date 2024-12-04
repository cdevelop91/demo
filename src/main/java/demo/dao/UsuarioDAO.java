package demo.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import demo.config.ConexionBD;

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
    
    public ArrayList<String> listarUsuarios(){
    	String sql = "SELECT nombre FROM usuarios;";
    	ArrayList<String> results = new ArrayList<>();
    	
    	   try (Connection con = ConexionBD.getConnection();
    	        PreparedStatement ps = con.prepareStatement(sql);
    			ResultSet rs = ps.executeQuery()) {

    		   while (rs.next()) {
    			   results.add(rs.getString("nombre"));
               }
           } catch (Exception e) {
               e.printStackTrace();
           }

           return results;
       }
    
    
}