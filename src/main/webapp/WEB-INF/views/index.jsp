<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Formulario de Usuario</title>
</head>
<body>
    <h1>Formulario de Usuario</h1>
    <form action="guardarUsuario" method="post">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        <br><br>
        <label for="paterno">Ap Paterno:</label>
        <input type="text" id="paterno" name="paterno" required>
        <br><br>
        <label for="materno">Ap Materno:</label>
        <input type="text" id="materno" name="materno" required>
        <button type="submit">Guardar</button>
    </form>
    
	<script>
	
	function mostrarFormulario(id) {
	    console.log("Mostrando formulario para ID:", id);
	    const formulario = document.getElementById("formulario-edicion-"+ id);
	    if (formulario) {
	        formulario.style.display = 'block';
	    } else {
	        console.error(`No se encontró el formulario con id formulario-edicion-${id}`);
	    }
	}

	function ocultarFormulario(id) {
	    console.log("Ocultando formulario para ID:", id);
	    const formulario = document.getElementById("formulario-edicion-"+ id);
	    if (formulario) {
	        formulario.style.display = 'none';
	    } else {
	        console.error(`No se encontró el formulario con id formulario-edicion-${id}`);
	    }
	}

</script>
	
    

    <%-- Mostrar mensaje de éxito/error --%>
    <c:if test="${not empty mensaje}">
        <div class="${tipoMensaje}">
            ${mensaje}
        </div>
    </c:if>

    <%-- Mostrar lista de usuarios --%>
    <c:if test="${not empty usuarios}">
        <h2>Lista de Usuarios</h2>
        <table border="1">
            <thead>
                <tr>
                	<th>Id</th>
                    <th>Nombre</th>
                    <th>Apellido Paterno</th>
                    <th>Apellido Materno</th>
                    <th>Borrar</th>
                    <th>Editar</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="usuario" items="${usuarios}">
                    <tr>
                     	<td>${usuario.id}</td>
                        <td>${usuario.nombre}</td>
                        <td>${usuario.paterno}</td>
                        <td>${usuario.materno}</td>
                        <td>
                            <%-- Formulario para borrar el usuario --%>
                            <form action="borrarUsuario" method="post" style="display:inline;">
                                <input type="hidden" name="usuarioId" value="${usuario.id}" />
                                <button type="submit">Borrar</button>
                            </form>
                        </td>
                        
                        
                        <td>
                            <button type="button" onclick="mostrarFormulario(${usuario.id})">Editar</button>
    <div id="formulario-edicion-${usuario.id}" style="display:none; margin-top:10px;">
        <form action="editarUsuario" method="post">
            <input type="hidden" name="usuarioId" value="${usuario.id}" />
            <label for="nombre-${usuario.id}">Nombre:</label>
            <input type="text" id="nombre-${usuario.id}" name="nombre" value="${usuario.nombre}" required />
            <label for="paterno-${usuario.id}">Apellido Paterno:</label>
            <input type="text" id="paterno-${usuario.id}" name="paterno" value="${usuario.paterno}" required />
            <label for="materno-${usuario.id}">Apellido Materno:</label>
            <input type="text" id="materno-${usuario.id}" name="materno" value="${usuario.materno}" required />
            <button type="submit">Guardar Cambios</button>
            <button type="button" onclick="ocultarFormulario(${usuario.id})">Cancelar</button>
        </form>
    </div>
                        </td>
                        
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>