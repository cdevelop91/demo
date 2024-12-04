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
        <br>
         <br>
         <label for="paterno">Ap Paterno:</label>
        <input type="text" id="paterno" name="paterno" required>
        <br>
         <br>
         <label for="materno">Ap Materno:</label>
        <input type="text" id="materno" name="materno" required>
        
        <button type="submit">Guardar</button>
    </form>

    <!-- Mostrar mensaje de éxito o error -->
    <c:if test="${not empty mensaje}">
        <p style="color: ${tipoMensaje == 'exito' ? 'green' : 'red'};">
            ${mensaje}
        </p>
    </c:if>
    
    

    
    
    
    <%-- Mostrar mensaje de éxito/error --%>
<c:if test="${not empty mensaje}">
    <div class="${tipoMensaje}">
        ${mensaje}
    </div>
</c:if>

<%-- Mostrar lista de usuarios --%>
<c:if test="${not empty usuarios}">
    <h2>Lista de Usuarios</h2>
    <ul>
        <c:forEach var="usuario" items="${usuarios}">
            <li>${usuario}</li>
        </c:forEach>
        
        
        
    </ul>
</c:if>
    
    
    
</body>
</html>
