
<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Pais</h1>

<form action="<?php  if(isset($params['action'])) :  echo $params['action']; unset($params['action']); else : echo URL.'admin/insert_product'; endif; ?>" method="POST" enctype="multipart/form-data">

	<?php echo isset($params['id']) ? '<input type="hidden" name="id" value="'.$params['id'].'"/>'  : ''; ?>


	<div class="form-group full">

		<label>Nombre producto</label>
		<input class="form-control" value="<?php echo isset($params['nombre']) ? $params['nombre'] : ''; ?>" type="text" placeholder="Nombre producto" name="nombre" required />

	</div>
	
	<div class="form-group">
		<label for="paises">Paises</label>
		<select name="id_pais" class="form-control" required>
			<?php
				echo (!isset($params['id_pais'])) ? '<option selected disabled>Selecciona una opción</option>' : '';

				foreach($params['pais'] as $pais) : 
					$selected = (isset($params['id_pais']) && ($params['id_pais'] == $pais['id'])) ? 'selected' : '';
			?>

				<option <?php echo $selected; ?> value="<?php echo $pais['id'] ?>"><?php echo $pais['nombre']; ?></option>
		
			<?php endforeach; ?>
		</select>
	</div>

	<div class="form-group">
		<label for="descripcion">Descripcion</label>
		<textarea name="desc_product"  placeholder="Descripcion" class="form-control"><?php echo (isset($params['desc_product'])) ? $params['desc_product'] : ''; ?></textarea>
	</div>

	<div class="form-group">
		<label for="imagen">Imagen</label>

		<?php if(isset($params['img']) && $params['img'] != '') : ?>
			  	<input type="hidden" name="img" value="<?php echo $params['img'];?>" />
				<img class="file_image"  height="200" alt="Foto producto" 
				src="<?php echo URL.'assets/upload/productos/'.$params['id'].'/'.$params['img']; ?> "  />
				<a class="change_foto" data-input="img" href="#"><i class="fa fa-pencil-square-o"></i> Editar Foto</a>

		<?php else : ?>
				<img class="file_image" src="#" />
				<input type="file" name="img" accept="image/x-png, image/gif, image/jpeg" class="file" />

	<?php endif; ?>

	</div>


	<div class="form_group">
		<input type="submit" value="Enviar" />

	</div>
</form>
</div>