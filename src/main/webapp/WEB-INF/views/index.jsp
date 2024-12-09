<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Formulario de Usuario</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body class="container my-4">
    <h1 class="mb-4 text-center">Formulario de Usuario</h1>

    <!-- Formulario de creación -->
   <div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <form action="guardarUsuario" method="post" class="border p-4 rounded shadow-sm bg-light">
                <h4 class="text-center mb-4">Nuevo Usuario</h4>
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="paterno">Apellido Paterno:</label>
                    <input type="text" id="paterno" name="paterno" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="materno">Apellido Materno:</label>
                    <input type="text" id="materno" name="materno" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Guardar</button>
            </form>
        </div>
    </div>
</div>

    <!-- Mensajes -->
    <c:if test="${not empty mensaje}">
        <div class="alert ${tipoMensaje == 'error' ? 'alert-danger' : 'alert-success'} mt-4">
            ${mensaje}
        </div>
    </c:if>

    <!-- Lista de usuarios -->
    <c:if test="${not empty usuarios}">
        <h2 class="mt-5">Lista de Usuarios</h2>
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Apellido Paterno</th>
                        <th>Apellido Materno</th>
                        <th>Acciones</th>
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
                                <div class="d-flex">
                                    <!-- Botón de editar -->
                                    <button type="button" class="btn btn-warning btn-sm mr-2" 
                                            data-toggle="modal" 
                                            data-target="#modalEdicion" 
                                            onclick="llenarFormulario(${usuario.id}, '${usuario.nombre}', '${usuario.paterno}', '${usuario.materno}')">
                                        Editar
                                    </button>

                                    <!-- Botón de borrar -->
                                    <form action="borrarUsuario" method="post" class="ml-2">
                                        <input type="hidden" name="usuarioId" value="${usuario.id}">
                                        <button type="submit" class="btn btn-danger btn-sm">Borrar</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

<!--------------------- Modal para editar usuario ----------------------->
    <div class="modal fade" id="modalEdicion" tabindex="-1" role="dialog" aria-labelledby="modalEdicionLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalEdicionLabel">Editar Usuario</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="editarUsuario" method="post">
                    <div class="modal-body">
                        <input type="hidden" id="usuarioId" name="usuarioId">
                        <div class="form-group">
                            <label for="nombre-modal">Nombre:</label>
                            <input type="text" id="nombre-modal" name="nombre" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="paterno-modal">Apellido Paterno:</label>
                            <input type="text" id="paterno-modal" name="paterno" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="materno-modal">Apellido Materno:</label>
                            <input type="text" id="materno-modal" name="materno" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Guardar Cambios</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function llenarFormulario(id, nombre, paterno, materno) {
            // Asigna los valores al formulario dentro del modal
            document.getElementById('usuarioId').value = id;
            document.getElementById('nombre-modal').value = nombre;
            document.getElementById('paterno-modal').value = paterno;
            document.getElementById('materno-modal').value = materno;
        }
    </script>
</body>
</html>