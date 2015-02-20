<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Usuario</h1>

<form action="<?php  if(isset($params['action'])) :  echo $params['action']; unset($params['action']); else : echo URL.'admin/insert_user'; endif; ?>" method="POST">

	<?php echo isset($params['id']) ? '<input type="hidden" name="id" value="'.$params['id'].'"/>'  : ''; ?>


	<div class="form-group full">

		<label>Nombre Usuario</label>
		<input class="form-control" value="<?php echo isset($params['nombre_usuario']) ? $params['nombre_usuario'] : ''; ?>" type="text" placeholder="Nombre Usuario" name="nombre_usuario" required />

	</div>

	<div class="form-group full">

		<label for="nombre">Nombre</label>
		<input class="form-control" value="<?php echo isset($params['nombre']) ? $params['nombre'] : ''; ?>" type="text" placeholder="Nombre Completo" name="nombre" required />

	</div>

	<div class="form-group full">

		<label for="email">Email</label>
		<input class="form-control" value="<?php echo isset($params['email']) ? $params['email'] : ''; ?>" type="email" placeholder="Email" name="email" required />

	</div>

	<div class="form-group full">

		<label for="password">Password</label>
		<input class="form-control" type="password" placeholder="Password" name="pass_usuario" <?php echo isset($params['pass_usuario']) ? '' : 'required'; ?> />

	</div>


	<div class="form-group full">

		<label for="tipo">Tipo de usuario</label>

		<select name="tipo" class="form-control" required>

			<?php $value = (isset($params['tipo'])) ? $params['tipo'] : ''; ?>


			<option <?php echo ($value == 'admin') ? 'selected' : ''; ?> value="admin">Administrador</option>
			<option <?php echo ($value == 'editor') ? 'selected' : ''; ?> value="editor">Editor</option>
			<option <?php echo ($value == 'registrado') ? 'selected' : ''; ?> value="registrado">Registrado</option>
		
			
		</select>

	</div>

	<div class="form_group">
		<input type="submit" value="Enviar" />

	</div>
</form>
</div>