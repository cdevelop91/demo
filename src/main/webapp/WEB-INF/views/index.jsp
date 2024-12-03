<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
        <button type="submit">Guardar</button>
    </form>

    <!-- Mostrar mensaje de éxito o error -->
    <c:if test="${not empty mensaje}">
        <p style="color: ${tipoMensaje == 'exito' ? 'green' : 'red'};">
            ${mensaje}
        </p>
    </c:if>
</body>
</html>
