<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Importar Universidad</h1>
<form action="<?php echo URL.'admin/import_universidades' ?>" method="POST" enctype="multipart/form-data">



	<div class="form-group">
		<label for="archivo">Archivo (csv)</label>
		<input type="file" name="archivo" accept=".csv" />
	</div>

	<div class="form_group">
		<input type="submit" value="Enviar" required/>

	</div>
</form>
</div>

