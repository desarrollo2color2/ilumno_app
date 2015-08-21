<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Universidad</h1>

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

<form action="<?php  if(isset($params['action'])) :  echo $params['action']; unset($params['action']); else : echo URL.'admin/insert_university'; endif; ?>" method="POST">

	<?php echo isset($params['id']) ? '<input type="hidden" name="id" value="'.$params['id'].'"/>'  : ''; ?>

	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Nombre universidad</label>
				<input class="form-control" value="<?php echo isset($params['nombre']) ? $params['nombre'] : ''; ?>" type="text" placeholder="Nombre universidad" name="nombre" required />
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Rector</label>
				<input class="form-control" value="<?php echo isset($params['rector']) ? $params['rector'] : ''; ?>" type="text" placeholder="Rector" name="rector" required />
			</div>
		</div>
	</div>

	<div class="form-group">
		<label for="">Paises</label>
		<select name="id_pais" class="form-control" id="id_pais" required>
			<?php
				echo (!isset($params['id_pais'])) ? '<option selected disabled>Selecciona una opción</option>' : '';

				foreach($params['paises'] as $pais) : 
					$selected = (isset($params['id_pais']) && ($params['id_pais'] == $pais['id'])) ? 'selected' : '';
			?>

				<option <?php echo $selected; ?> value="<?php echo $pais['id'] ?>"><?php echo $pais['nombre']; ?></option>
		
			<?php endforeach; ?>
		</select>
	</div>

	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Presidente</label>
				<input class="form-control" value="<?php echo isset($params['presidente']) ? $params['presidente'] : ''; ?>" type="text" placeholder="Presidente" name="presidente" required />
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Telefono</label>
				<input class="form-control" value="<?php echo isset($params['telefono']) ? $params['telefono'] : ''; ?>" type="text" placeholder="Telefono" name="telefono" required />
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Email</label>
				<input class="form-control" value="<?php echo isset($params['email']) ? $params['email'] : ''; ?>" type="email" placeholder="ejemplo@ejemplo.com" name="email" required />
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Direccion</label>
				<input class="form-control" value="<?php echo isset($params['direccion']) ? $params['direccion'] : ''; ?>" type="text"  name="direccion" required />
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Sede principal</label>
				<input class="form-control" value="<?php echo isset($params['ciudad']) ? $params['ciudad'] : ''; ?>" type="text" placeholder="Ciudad" name="ciudad" required />
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Tipo</label>
				<select name="tipo" class="form-control">
					<?php echo (!isset($params['tipo'])) ? '<option selected disabled>Selecciona una opción</option>' : ''; ?>

					<option <?php echo (isset($params['tipo']) && $params['tipo'] == 0) ? 'selected' : ''; ?> value="0">SIN ANIMO DE LUCRO</option>
					<option <?php echo (isset($params['tipo']) && $params['tipo'] == 1) ? 'selected' : ''; ?> value="1">CON ANIMO DE LUCRO</option>
				</select>
			</div>
		</div>
	</div>

	

	

	<!-- Json fields -->
	
	<!-- Acreditaciones -->
	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Acreditaciones - Nacionales</label>
				<select name="acreditaciones[nacionales]" class="form-control" required>
					<?php echo (!isset($params['acreditaciones'])) ? '<option selected disabled>Selecciona una opción</option>' : ''; ?>
					<option value="0">SI</option>
					<option value="1">NO</option>
				</select>
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Acreditaciones - Internacionales</label>
				<select name="acreditaciones[internacionales]" class="form-control" required>
					<?php echo (!isset($params['acreditaciones'])) ? '<option selected disabled>Selecciona una opción</option>' : ''; ?>
					<option value="0">SI</option>
					<option value="1">NO</option>
				</select>
			</div>
		</div>
	</div>

	<!-- Cobertura -->

	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Cobertura -  numero de sedes</label>
				
				<input type="number" name="cobertura[num_sedes]" class="form-control" 
				value="<?php echo (isset($params['cobertura']['num_sedes'])) ? $params['cobertura']['num_sedes'] : '';  ?>" required/>
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Cobertura - ciudades</label>
				<select id="ciudades" name="cobertura[ciudades][]" class="form-control" multiple required>
					<?php if(isset($params['ciudades']) && isset($params['cobertura']['ciudades'])) :
						  
						  if (is_array($params['cobertura']['ciudades'])) : 
						  		$cities = $params['cobertura']['ciudades'];
						  else :
						  		$cities[] = $params['cobertura']['ciudades'];
						  endif;	
					  	  
						  foreach($params['ciudades'] as $city ) :  ?>
							
							<option 
							<?php echo (is_numeric(array_search($city['id'], $cities))) ? 'selected' : ''; ?>
							value="<?php echo $city['id']; ?>"><?php echo ucfirst($city['nombre']); ?></option>


					<?php endforeach; endif;  ?>

				</select>
			</div>
		</div>
	</div>

	<!-- Modalidad -->
	<div class="row">
		<div class="col-md-4">
			<div class="form-group">
				<label>Modalidad - Presencial</label>
				<input name="modalidad[presencial]" type="number" class="form-control" 
				value="<?php echo (isset($params['modalidad']['presencial'])) ? $params['modalidad']['presencial'] : '';  ?>"
				placeholder="Numeros de programas por modalidad" required/>
			</div>
		</div>
		<div class="col-md-4">
			<div class="form-group">
				<label>Modalidad - Virtual</label>
				<input name="modalidad[virtual]" type="number" class="form-control" 
				value="<?php echo (isset($params['modalidad']['virtual'])) ? $params['modalidad']['virtual'] : '';  ?>"
				placeholder="Numeros de programas por modalidad" required/>
			</div>
		</div>
		<div class="col-md-4">
			<div class="form-group">
				<label>Modalidad - Distancia</label>
				<input name="modalidad[distancia]" type="number" class="form-control" 
				value="<?php echo (isset($params['modalidad']['distancia'])) ? $params['modalidad']['distancia'] : '';  ?>"
				placeholder="Numeros de programas por modalidad" required/>
			</div>
		</div>
	</div>

	<!-- Poblacion -->

	<div class="row">
		<div class="col-md-4">
			<div class="form-group">
				<label>Poblacion - Total</label>
				<input name="poblacion[total]" type="number" class="form-control" 
				value="<?php echo (isset($params['poblacion']['total'])) ? $params['poblacion']['total'] : '';  ?>"
				placeholder="Total de estudiantes" required/>
			</div>
		</div>
		<div class="col-md-4">
			<div class="form-group">
				<label>Poblacion - posgrado</label>
				<input name="poblacion[posgrado]" type="number" class="form-control" 
				value="<?php echo (isset($params['poblacion']['posgrado'])) ? $params['poblacion']['posgrado'] : '';  ?>"
				placeholder="Total estudiantes posgrado" required/>
			</div>
		</div>
		<div class="col-md-4">
			<div class="form-group">
				<label>Poblacion - pregrado</label>
				<input name="poblacion[pregrado]" type="number" class="form-control" 
				value="<?php echo (isset($params['poblacion']['total'])) ? $params['poblacion']['pregrado'] : '';  ?>"
				placeholder="Total estudiantes pregrado" required/>
			</div>
		</div>
	</div>

	<!-- Poblacion de primer ingreso -->

	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Poblacion - 1er ingreso (posgrado)</label>
				<input name="poblacion_primer_ingreso[posgrado]" type="number" class="form-control" 
				value="<?php echo (isset($params['poblacion_primer_ingreso']['posgrado'])) ? $params['poblacion_primer_ingreso']['posgrado'] : '';  ?>"
				placeholder="Total estudiante posgrados nuevos" required/>
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Poblacion - 1er ingreso pregrado</label>
				<input name="poblacion_primer_ingreso[pregrado]" type="number" class="form-control" 
				value="<?php echo (isset($params['poblacion_primer_ingreso']['pregrado'])) ? $params['poblacion_primer_ingreso']['pregrado'] : '';  ?>"
				placeholder="Total estudiantes pregrado nuevos" required/>
			</div>
		</div>
	</div>

	<!-- Desercion -->

	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Desercion - acumulada</label>
				<input name="desercion[acumulada]" type="number" class="form-control" 
				value="<?php echo (isset($params['desercion']['acumulada'])) ? $params['desercion']['acumulada'] : '';  ?>"
				placeholder="Deebe ser solo el numero" required/>
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Desercion - por periodo</label>
				<input name="desercion[por_periodo]" type="number" class="form-control" 
				value="<?php echo (isset($params['desercion']['por_periodo'])) ? $params['desercion']['por_periodo'] : '';  ?>"
				placeholder="Deebe ser solo el numero" required/>
			</div>
		</div>
	</div>

	<!-- Personal -->

	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>Personal - docentes</label>
				<input name="personal[docentes]" type="number" class="form-control" 
				value="<?php echo (isset($params['personal']['docentes'])) ? $params['personal']['docentes'] : '';  ?>"
				placeholder="Docentes" required/>
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label>Personal - adtivos</label>
				<input name="personal[adtivos]" type="number" class="form-control" 
				value="<?php echo (isset($params['personal']['adtivos'])) ? $params['personal']['adtivos'] : '';  ?>"
				placeholder="Adtivos" required/>
			</div>
		</div>
	</div>

	<!-- Ingresos -->

	<div class="row">
		<div class="col-md-3">
			<div class="form-group">
				<label>Ingresos - Valor matricula posgrado</label>
				<input name="ingresos[matricula_posgrado]" type="number" class="form-control" 
				value="<?php echo (isset($params['ingresos']['matricula_posgrado'])) ? $params['ingresos']['matricula_posgrado'] : '';  ?>"
				required/>
			</div>
		</div>
		<div class="col-md-3">
			<div class="form-group">
				<label>Ingresos - Valor matricula pregrado</label>
				<input name="ingresos[matricula_pregrado]" type="number" class="form-control" 
				value="<?php echo (isset($params['ingresos']['matricula_pregrado'])) ? $params['ingresos']['matricula_pregrado'] : '';  ?>"
				required/>
			</div>
		</div>
		<div class="col-md-3">
			<div class="form-group">
				<label>Ingresos - Total</label>
				<input name="ingresos[total_ingresos]" type="number" class="form-control" 
				value="<?php echo (isset($params['ingresos']['total_ingresos'])) ? $params['ingresos']['total_ingresos'] : '';  ?>"
				required/>
			</div>
		</div>
		<div class="col-md-3">
			<div class="form-group">
				<label>Ingresos - Moneda</label>
				<select class="form-control" name="ingresos[moneda]"id="monedas">
				<?php echo(isset($params['nombre_moneda'])) ? 
					  '<option selected value="'.$params['nombre_moneda'][0]['id'].'">'.$params['nombre_moneda'][0]['nombre'].'</option>' : ''; ?>
			
					
				</select>
			</div>
		</div>
	</div>

	<div class="row">
		
		<div class="col-md-3">
			<div class="form-group">
				<label for="">Tier</label>
				<input type="text" name="tier" class="form-control" value="<?php echo (isset($params['tier'])) ? $params['tier'] : '';  ?>"
					required />
			</div>
		</div>
		<div class="col-md-3">
			<div class="form-group">
				<label for="">Ranking nacional</label>
				<input type="text" name="rank_nacional" class="form-control" value="<?php echo (isset($params['rank_nacional'])) ? $params['rank_nacional'] : '';  ?>"
					required />
			</div>
		</div>
		<div class="col-md-3">
			<div class="form-group">
				<label for="">Ranking latinoamercia</label>
				<input type="text" name="rank_lati" class="form-control" value="<?php echo (isset($params['rank_lati'])) ? $params['rank_lati'] : '';  ?>"
					required />
			</div>
		</div>
		<div class="col-md-3">
			<div class="form-group">
				<label for="">Ranking mundial</label>
				<input type="text" name="rank_mundial" class="form-control" value="<?php echo (isset($params['rank_mundial'])) ? $params['rank_mundial'] : '';  ?>"
					required />
			</div>
		</div>
		
	</div>


	<!-- Observaciones -->
	<div class="form-group">
		<label for="">Observaciones</label>
		<textarea name="observaciones" class="form-control"><?php echo isset($params['observaciones']) ? $params['observaciones'] : ''; ?></textarea>
	</div>

	<!-- Pagina web -->
	
	<div class="form-group">
		<label>Pagina web</label>
		<input class="form-control" value="<?php echo isset($params['pagina_web']) ? $params['pagina_web'] : ''; ?>" type="text" placeholder="Pagina web" name="pagina_web" required />
	</div>


	<div class="form_group">
		<input type="submit" value="Enviar" />

	</div>
</form>
</div>

<script type="text/javascript">
	$('#id_pais').change(function(e){
		var id = $(this).val();
		
	
		
		$.ajax({

			url: "<?php echo URL.'admin/get_ajax_cities_university'; ?>",
			cache: false,
			type: 'POST',
			data: {id: id},
			success: function(html){
			$("#ciudades").fadeIn(100, 'fold').html(html);
			}
			

		});

		$.ajax({

			url: "<?php echo URL.'admin/get_ajax_currencies_university'; ?>",
			cache: false,
			type: 'POST',
			data: {id: id},
			success: function(html){
			$("#monedas").fadeIn(100, 'fold').html(html);
			}
			

		});
	});
</script>

