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
                <th>Nombre</th>
                <th>Apellido Paterno</th>
                <th>Apellido Materno</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="usuario" items="${usuarios}">
                <tr>
                    <td>${usuario.nombre}</td>
                    <td>${usuario.paterno}</td>
                    <td>${usuario.materno}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
    
    
    
</body>
</html>
