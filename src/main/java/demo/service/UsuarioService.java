package demo.service;

import java.sql.SQLException;

import demo.dao.UsuarioDAO;

public class UsuarioService {
  
	private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    public void guardarUsuario(String nombre) throws SQLException {
        if (nombre == null || nombre.trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío");
        }
        usuarioDAO.guardarUsuario(nombre);
    }
}