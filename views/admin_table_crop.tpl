

<script type="text/javascript" src="<?php echo URL.'libs/tiny/tinymce.min.js'?>"></script>
<script type="text/javascript">

	tinymce.init({

	    selector: "textarea",

	    plugins: [
	         "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
	         "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
	         "save table contextmenu directionality emoticons template paste textcolor"
	   ]

 	});

</script>


<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Tablas Cultivos</h1>

<form action="<?php  if(isset($params['action'])) :  echo $params['action']; unset($params['action']); else : echo URL.'admin/insert_tablecrop'; endif; ?>" method="POST" enctype="multipart/form-data">

	<?php echo isset($params['id']) ? '<input type="hidden" name="id" value="'.$params['id'].'"/>'  : ''; ?>


	<!-- Cultivo asosiado -->

	<div class="form-group">
		<label for="cultivos">Cultivo Asosiado</label>
		<select name="id_cultivo" class="form-control" required>
			<?php
				echo (!isset($params['id_cultivo'])) ? '<option value="" selected disabled>Selecciona una opción</option>' : '';

				foreach($params['cultivos_'] as $cultivo) : 
					$selected = (isset($params['id_cultivo']) && ($params['id_cultivo'] == $cultivo['id'])) ? 'selected' : '';
			?>

				<option <?php echo $selected; ?> value="<?php echo $cultivo['id'] ?>"><?php echo $cultivo['nombre']; ?></option>

			<?php endforeach; ?>
		</select>
	</div>
	<!-- Paises -->
	<div class="form-group">
		<label for="paises">Paises</label>
			<select name="paises[]" class="form-control" multiple required>
				<?php

					foreach($params['paises_'] as $pais) : 

						if(isset($params['paises'])) :


							if( is_numeric(array_search($pais['id'], json_decode($params['paises'], true)))) :

								$is_exist = true;

								else :

								$is_exist = false;	

							endif;
						endif;

				?>

					<option  <?php echo($is_exist) ? 'selected' : '';  ?> value="<?php echo $pais['id'] ?>">
						<?php echo $pais['nombre']; ?>
					</option>

				<?php endforeach; ?>
			</select>
	</div>
	<!-- Plaga -->
	<div class="form-group">
		<label for="">Plaga</label>
		<input type="text" class="fom-control" name="plaga" value="<?php echo (isset($params['plaga'])) ? $params['plaga'] : ''; ?>" />
	</div>
	<!-- Tolerancia -->
	<div class="form-group">
		<label for="">Tolerancia</label>
		<input type="text" class="fom-control" name="tolerancia" value="<?php echo (isset($params['tolerancia'])) ? $params['tolerancia'] : ''; ?>" />
	</div>
	<!-- Cultivos -->
	<div class="form-group">
		<label for="">Cultivos</label>
		<i class="fa fa-plus add_crop">Añadir cultivo</i>
		<?php 

			if(isset($params['cultivos'])) :

				$cultivos = json_decode($params['cultivos'], true);
				
				foreach($cultivos as $cultivo) :

					echo '<div class="crop"><a onClick="nd(this.parentNode)" class="remove_crop"><i class="fa fa-minus"></i>
						  Remove cultivo</a>
						  <input type="text" name="cultivos[]" value="'.$cultivo.'" class="form-control"/></div>';

				endforeach;

			endif;	
		?>

	</div>
	<!-- Dosis -->
	<div class="form-group">
		<label for="">Dosis</label>
		<i class="fa fa-plus add_dosis">Añadir dosis</i>
		<?php 

			if(isset($params['dosis'])) :

				$dosis = json_decode($params['dosis'], true);
				
				foreach($dosis as $dosi) :

					echo '<div class="crop"><a onClick="nd(this.parentNode)" class="remove_dosis"><i class="fa fa-minus"></i>
						  Remove dosis</a>
						  <input type="text" name="dosis[]" value="'.$dosi.'" class="form-control"/></div>';

				endforeach;

			endif;	
		?>

	</div>
	<!-- Recomendaciones -->
	<div class="form-group">
		<label for="">Recomendaciones</label>
		<textarea name="recomendaciones" placeholder="Recomendaciones" class="form-control">
			<?php echo (isset($params['recomendaciones'])) ? $params['recomendaciones'] : ''; ?>
		</textarea>
	</div>

	<div class="form_group">
		<input type="submit" value="Enviar" />

	</div>
</form>
</div>

<script type="text/javascript">
	
	function nd(but){

		$(but).remove();
	}

	$('.add_dosis').click(function(){

		$(this).parent().append('<div class="dosis"><a onClick="nd(this.parentNode)" class="remove_dosis"><i class="fa fa-minus"></i>'
		+'Remove dosis</a>'
		+'<input type="text" name="dosis[]" class="form-control"/></div>');

	});


	$('.add_crop').click(function(){

		$(this).parent().append('<div class="crop"><a onClick="nd(this.parentNode)" class="remove_crop"><i class="fa fa-minus"></i>'
		+'Remove cultivo</a>'
		+'<input type="text" name="cultivos[]" class="form-control"/></div>');

	});


</script>
