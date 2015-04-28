<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Importar Ciudades de cobertura</h1>

<form method="POST" action="<?php echo URL; ?>import_cobers">

	
	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<input type="number" class="form-control" placeholder="ID de la universidad" name="id" required />
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<textarea name="cobertura" placeholder="Ciudades de cobertura sepradas x - y sin saltos de linea" required class="form-control"></textarea>
			</div>
		</div>
	</div>



	<div class="form_group">
		<input type="submit" value="Enviar">

	</div>
</form>
</div>



