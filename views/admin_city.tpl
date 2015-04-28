<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Ciudad</h1>

<form action="<?php  if(isset($params['action'])) :  echo $params['action']; unset($params['action']); else : echo URL.'admin/insert_city'; endif; ?>" method="POST">

	<?php echo isset($params['id']) ? '<input type="hidden" name="id" value="'.$params['id'].'"/>'  : ''; ?>



	<div class="form-group">

		<label>Nombre ciudad</label>
		<input class="form-control" value="<?php echo isset($params['nombre']) ? $params['nombre'] : ''; ?>" type="text" placeholder="Nombre ciudad" name="nombre" required />

	</div>


	<div class="form-group">
		<label for="">Paises</label>
		<select name="id_pais" class="form-control" required>
			<?php
				echo (!isset($params['id_pais'])) ? '<option selected disabled>Selecciona una opción</option>' : '';

				foreach($params['paises'] as $pais) : 
					$selected = (isset($params['id_pais']) && ($params['id_pais'] == $pais['id'])) ? 'selected' : '';
			?>

				<option <?php echo $selected; ?> value="<?php echo $pais['id'] ?>"><?php echo $pais['nombre']; ?></option>
		
			<?php endforeach; ?>
		</select>
	</div>

	<div class="form_group">
		<input type="submit" value="Enviar" />

	</div>
</form>
</div>