package demo.service;

import java.sql.SQLException;
import java.util.ArrayList;

import demo.dao.UsuarioDAO;

public class UsuarioService {
  
	private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    public void guardarUsuario(String nombre, String paterno, String materno) throws SQLException {
        if (nombre == null || nombre.trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío");
        }
        usuarioDAO.guardarUsuario(nombre, paterno, materno);
    }
    
    public ArrayList<String> listarUsuarios(){
		
    	ArrayList<String> results = usuarioDAO.listarUsuarios();
    	return results;
    	
    }
}