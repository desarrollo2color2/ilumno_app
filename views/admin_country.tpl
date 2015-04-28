<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Pais</h1>

<form action="<?php  if(isset($params['action'])) :  echo $params['action']; unset($params['action']); else : echo URL.'admin/insert_country'; endif; ?>" method="POST" enctype="multipart/form-data">

	<?php echo isset($params['id']) ? '<input type="hidden" name="id" value="'.$params['id'].'"/>'  : ''; ?>


	<div class="form-group full">

		<label>Nombre pais</label>
		<input class="form-control" value="<?php echo isset($params['nombre']) ? $params['nombre'] : ''; ?>" type="text" placeholder="Nombre pais" name="nombre" required />

	</div>

	<div class="form-group">
		<label>Bandera</label>
		<?php if(isset($params['img']) && $params['img'] != '') : ?>
		  	<input type="hidden" name="img" value="<?php echo $params['img'];?>" />
			<img class="file_image"  height="200" alt="Icono atributo" 
			src="<?php echo URL.'assets/upload/'.$params['img']; ?> " style="width: 23px !important;height: 16px;"  />
			<a class="change_foto" data-input="img" href="#"><i class="fa fa-pencil-square-o"></i> Editar bandera</a>

			<?php else : ?>

				<img class="file_image" src="#" />
				<input  type="file" name="img" accept="image/x-png, image/gif, image/jpeg"  required style="margin: 0px;"  class="file" />	

		<?php endif; ?>	
	</div>

	<div class="form_group">
		<input type="submit" value="Enviar" />

	</div>
</form>
</div>