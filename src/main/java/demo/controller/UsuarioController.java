package demo.controller;




import java.io.IOException;
import java.util.ArrayList;

import demo.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet({"/guardarUsuario","/listarUsuario"})
public class UsuarioController extends HttpServlet {
   
	private final UsuarioService usuarioService = new UsuarioService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String paterno = request.getParameter("paterno");
        String materno = request.getParameter("materno");

        try {
            usuarioService.guardarUsuario(nombre,paterno,materno);

            request.setAttribute("mensaje", "¡Usuario guardado exitosamente!");
            request.setAttribute("tipoMensaje", "exito");
            
            // Redirige a la lista de usuarios después de guardar
            response.sendRedirect("listarUsuario");
            
        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("mensaje", "Ocurrió un error al guardar el usuario.");
            request.setAttribute("tipoMensaje", "error");
            request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
        }

       
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("into doget");
    	String action = request.getServletPath(); // Obtiene el path de la solicitud
       
       
            try {
                ArrayList<String> usuarios = usuarioService.listarUsuarios();

                request.setAttribute("usuarios", usuarios);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("mensaje", "Ocurrió un error al listar los usuarios.");
                request.setAttribute("tipoMensaje", "error");
            }
           
            request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
            
       
       
    }
    
}