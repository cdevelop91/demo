package demo.controller;

import java.io.IOException;
import java.util.ArrayList;

import demo.model.Usuario;
import demo.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/", "/guardarUsuario", "/listarUsuario", "/borrarUsuario", "/editarUsuario" })
public class UsuarioController extends HttpServlet {

	private final UsuarioService usuarioService = new UsuarioService();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String action = request.getServletPath(); 

		switch (action) {
		case "/guardarUsuario":
			System.out.println("guardarUsuario");
			String nombre = request.getParameter("nombre");
			String paterno = request.getParameter("paterno");
			String materno = request.getParameter("materno");

			try {
				usuarioService.guardarUsuario(nombre, paterno, materno);

				request.setAttribute("mensaje", "¡Usuario guardado exitosamente!");
				request.setAttribute("tipoMensaje", "exito");

				response.sendRedirect("listarUsuario");

			} catch (Exception e) {
				e.printStackTrace();

				request.setAttribute("mensaje", "Ocurrió un error al guardar el usuario.");
				request.setAttribute("tipoMensaje", "error");
				request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
			}

			break;

		case "/borrarUsuario":
			System.out.println("into borrarUsuario");

			try {

				String usuarioIdParam = request.getParameter("usuarioId");
				int usuarioId = Integer.parseInt(usuarioIdParam);
				usuarioService.borrarUsuario(usuarioId);

				response.sendRedirect("listarUsuario");

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
			}

			break;

		case "/editarUsuario":
			System.out.println("editarUsuario");
			try {
				int id = Integer.parseInt(request.getParameter("usuarioId"));
				String nuevoNombre = request.getParameter("nombre");
				String nuevoPaterno = request.getParameter("paterno");
				String nuevoMaterno = request.getParameter("materno");

				usuarioService.editarUsuario(id, nuevoNombre, nuevoPaterno, nuevoMaterno);

				response.sendRedirect("listarUsuario");
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("mensaje", "Ocurrió un error al editar el usuario.");
				request.setAttribute("tipoMensaje", "error");
				request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
			}
			break;

		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "La acción no es válida.");
			break;
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String action = request.getServletPath(); // Obtiene el path de la solicitud

		switch (action) {

		case "/listarUsuario":
			System.out.println("listarUsuario");
			try {
				ArrayList<Usuario> usuarios = usuarioService.listarUsuarios();

				request.setAttribute("usuarios", usuarios);
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("mensaje", "Ocurrió un error al listar los usuarios.");
				request.setAttribute("tipoMensaje", "error");
			}

			request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);

			break;

		default:
			break;
		}

	}

}