package demo.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

import demo.service.UsuarioService;


@WebServlet("/guardarUsuario")
public class UsuarioController extends HttpServlet {
   
	private final UsuarioService usuarioService = new UsuarioService();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");

        try {
            usuarioService.guardarUsuario(nombre);

            request.setAttribute("mensaje", "¡Usuario guardado exitosamente!");
            request.setAttribute("tipoMensaje", "exito");
        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("mensaje", "Ocurrió un error al guardar el usuario.");
            request.setAttribute("tipoMensaje", "error");
        }

        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
    }
    
}