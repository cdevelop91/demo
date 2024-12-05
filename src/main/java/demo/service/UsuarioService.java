package demo.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.stream.Collectors;

import demo.dao.UsuarioDAO;
import demo.model.Usuario;

public class UsuarioService {
  
	private final UsuarioDAO usuarioDAO = new UsuarioDAO();
		
	private final String PEDRO = "pedro";
	
    public void guardarUsuario(String nombre, String paterno, String materno) throws SQLException {
        if (nombre == null || nombre.trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío");
        }
        usuarioDAO.guardarUsuario(nombre, paterno, materno);
    }
    
    public ArrayList<Usuario> listarUsuarios(){
		
    	return usuarioDAO.listarUsuarios().stream()
    	        .filter(usuario -> PEDRO.equalsIgnoreCase(usuario.getNombre())) // Filtrar por nombre
    	        .collect(Collectors.toCollection(ArrayList::new)); // Convertir a ArrayList
    	
    }
    
    
    /*
    public ArrayList<Usuario> listarUsuarios(){
		
    	ArrayList<Usuario> results = usuarioDAO.listarUsuarios();
    	
    	ArrayList<Usuario> usuariosTransformados = results.stream()
    	        .map(usuario -> {
    	            usuario.setNombre(usuario.getNombre().toUpperCase());
    	            usuario.setPaterno(usuario.getPaterno().toUpperCase());
    	            usuario.setMaterno(usuario.getMaterno().toUpperCase());
    	            return usuario;
    	        })
    	        .collect(Collectors.toCollection(ArrayList::new));
    	    
    	    return usuariosTransformados;
    	
    }*/
}