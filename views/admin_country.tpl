<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Pais</h1>

<form action="<?php  if(isset($params['action'])) :  echo $params['action']; unset($params['action']); else : echo URL.'admin/insert_country'; endif; ?>" method="POST">

	<?php echo isset($params['id']) ? '<input type="hidden" name="id" value="'.$params['id'].'"/>'  : ''; ?>


	<div class="form-group full">

		<label>Nombre pais</label>
		<input class="form-control" value="<?php echo isset($params['nombre']) ? $params['nombre'] : ''; ?>" type="text" placeholder="Nombre pais" name="nombre" required />

	</div>

	<div class="form_group">
		<input type="submit" value="Enviar" />

	</div>
</form>
</div>