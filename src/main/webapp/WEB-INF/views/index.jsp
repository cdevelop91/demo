<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Formulario de Usuario</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body class="container my-4">

	<script>
		function listarRegistros() {
			$
					.ajax({
						url : 'listarUsuario',
						method : 'GET',
						dataType : 'json',
						success : function(response) {
							console.log("Respuesta JSON:", response); // Verifica la estructura completa

							// Limpiamos la tabla antes de agregar los nuevos registros
							const tableBody = document
									.querySelector('table tbody');
							tableBody.innerHTML = ''; // Limpiamos el contenido del <tbody>

							// Verificamos si la respuesta contiene la propiedad 'usuarios' que es un array
							if (response && response.usuarios
									&& Array.isArray(response.usuarios)) {
								// Llenamos la tabla con los registros de usuarios
								response.usuarios
										.forEach(function(usuario) {
											console.log('Usuario:', usuario); // Verifica si los datos son correctos

											// Crear una nueva fila <tr>
											const row = document
													.createElement('tr');

											// Crear y agregar las celdas <td> para los datos
											const idCell = document
													.createElement('td');
											idCell.textContent = usuario.id;

											const nombreCell = document
													.createElement('td');
											nombreCell.textContent = usuario.nombre;

											const paternoCell = document
													.createElement('td');
											paternoCell.textContent = usuario.paterno;

											const maternoCell = document
													.createElement('td');
											maternoCell.textContent = usuario.materno;

											// Crear celda con botón "Editar"
											const editCell = document
													.createElement('td');
											const editButton = document
													.createElement('button');
											editButton.textContent = 'Editar';
											editButton.className = 'btn btn-warning btn-sm';
											editButton.setAttribute(
													'data-toggle', 'modal');
											editButton.setAttribute(
													'data-target',
													'#modalEdicion');
											editButton.onclick = function() {
												llenarFormulario(usuario.id,
														usuario.nombre,
														usuario.paterno,
														usuario.materno);
											};
											editCell.appendChild(editButton);

											// Crear celda con botón "Borrar"
											const deleteCell = document
													.createElement('td');
											const hiddenInput = document
													.createElement('input');
											hiddenInput.type = 'hidden';
											hiddenInput.name = 'usuarioId';
											hiddenInput.value = usuario.id;

											const deleteButton = document
													.createElement('button');
											deleteButton.textContent = 'Borrar';
											deleteButton.className = 'btn btn-danger btn-sm borrarUsuarioBtn';

											deleteCell.appendChild(hiddenInput);
											deleteCell
													.appendChild(deleteButton);
											row.appendChild(deleteCell);

											// Agregar las celdas a la fila
											row.appendChild(idCell);
											row.appendChild(nombreCell);
											row.appendChild(paternoCell);
											row.appendChild(maternoCell);
											row.appendChild(editCell);
											row.appendChild(deleteCell);

											// Agregar la fila al <tbody>
											tableBody.appendChild(row);
										});
							} else {
								alert('No se encontraron usuarios.');
							}
						},
						error : function(xhr, status, error) {
							console.error('Error en la solicitud AJAX:', error);
						}
					});
		}

		$(document).ready(function() {
			listarRegistros();
		});

		$(document).on('submit', '#crearUsuarioForm', function(e) {
			e.preventDefault();

			const datos = {
				nombre : $('#nombre').val(),
				paterno : $('#paterno').val(),
				materno : $('#materno').val()
			};

			$.ajax({
				url : 'guardarUsuario',
				method : 'POST',
				data : datos,
				success : function(response) {

					listarRegistros();
					$('#crearUsuarioForm')[0].reset();
				},
				error : function() {
					alert('Hubo un error al guardar el usuario.');
				}
			});
		});

		$(document).on('submit', '#editarUsuarioForm', function(e) {
			e.preventDefault();

			const datos = {
				usuarioId : $('#usuarioId').val(),
				nombre : $('#nombre-modal').val(),
				paterno : $('#paterno-modal').val(),
				materno : $('#materno-modal').val()
			};

			$.ajax({
				url : 'editarUsuario',
				method : 'POST',
				data : datos,
				success : function(response) {

					listarRegistros();
					$('#modalEdicion').modal('hide');
				},
				error : function() {
					alert('Hubo un error al editar el usuario.');
				}
			});
		});

		$(document).on('click', '.borrarUsuarioBtn', function() {
		    const usuarioId = $(this).closest('tr').find('input[name="usuarioId"]').val();

		    if (confirm('¿Estás seguro de que deseas eliminar este usuario?')) {
		        $.ajax({
		            url: 'borrarUsuario',
		            method: 'POST',
		            data: { usuarioId: usuarioId },
		            success: function() {
		                listarRegistros();
		            },
		            error: function() {
		                alert('Hubo un error al borrar el usuario.');
		            }
		        });
		    }
		});

		function llenarFormulario(id, nombre, paterno, materno) {
			$('#usuarioId').val(id);
			$('#nombre-modal').val(nombre);
			$('#paterno-modal').val(paterno);
			$('#materno-modal').val(materno);
		}
	</script>

	<h1 class="mb-4 text-center">Formulario de Usuario</h1>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-4">
				<form id="crearUsuarioForm"
					class="border p-4 rounded shadow-sm bg-light">
					<h4 class="text-center mb-4">Nuevo Usuario</h4>
					<div class="form-group">
						<label for="nombre">Nombre:</label> <input type="text" id="nombre"
							name="nombre" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="paterno">Apellido Paterno:</label> <input type="text"
							id="paterno" name="paterno" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="materno">Apellido Materno:</label> <input type="text"
							id="materno" name="materno" class="form-control" required>
					</div>
					<button type="submit" class="btn btn-primary btn-block">Guardar</button>
				</form>
			</div>
		</div>
	</div>

	<h2 class="mt-5">Lista de Usuarios</h2>
	<div class="table-responsive">
		<table id="tablaUsuarios" class="table table-striped table-bordered">
			<thead class="thead-dark">
				<tr>
					<th>ID</th>
					<th>Nombre</th>
					<th>Apellido Paterno</th>
					<th>Apellido Materno</th>
					<th>Editar</th>
					<th>Borrar</th>
				</tr>
			</thead>
			<tbody>
				<!-- Aquí se agregarán las filas dinámicamente -->
			</tbody>
		</table>
	</div>

	<div class="modal fade" id="modalEdicion" tabindex="-1" role="dialog"
		aria-labelledby="modalEdicionLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalEdicionLabel">Editar Usuario</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="editarUsuarioForm">
					<div class="modal-body">
						<input type="hidden" id="usuarioId" name="usuarioId">
						<div class="form-group">
							<label for="nombre-modal">Nombre:</label> <input type="text"
								id="nombre-modal" name="nombre" class="form-control" required>
						</div>
						<div class="form-group">
							<label for="paterno-modal">Apellido Paterno:</label> <input
								type="text" id="paterno-modal" name="paterno"
								class="form-control" required>
						</div>
						<div class="form-group">
							<label for="materno-modal">Apellido Materno:</label> <input
								type="text" id="materno-modal" name="materno"
								class="form-control" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-success">Guardar
							Cambios</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Cancelar</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>