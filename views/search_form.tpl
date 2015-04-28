<?php 
	$monedas  = $params['monedas'];
	$ciudades = $params['cities'];

	unset($params['monedas']);
	unset($params['cities']);

	$total    = $params['total'];   unset($params['total']);

	$nd = array(
		'Argentina',
		'Brasil',
		'Chile',
		'Colombia',
		'Costa Rica',
		'Ecuador',
		'Guatemala',
		'México',
		'Paraguay',
		'Perú'
	);

	foreach ($nd as $k => $value) {
		$n[$k] = utf8_decode($value);
	}

	if(isset($_SESSION['ordernar'])) :
		unset($_SESSION['ordernar']);
	endif;

	if(is_null($params['paises'])) :
		?>
		<script>window.location.href = '<?php echo URL; ?>';</script>
	<?php
	endif;


 ?>


<section id="busqueda">
	<!--<div class="background_search"></div>-->
	
	<div class="busqueda_head">
		<div class="container">
			<h1 style="min-width:240px;">
				<img width="150" style="display:block;" src="<?php echo URL;?>assets/img/logo.png" alt="Logo">

				<!-- <i class="fa fa-search"></i>Busqueda red ilumno -->
			</h1>

			<form class="form-inline" id="simple_search" action="<?php echo URL.'simple_search'; ?>" method="POST">

				<div class="form-group">
					<label style="width:170px;">
						<select class="form-control" style="width:170px;" id="pais" name="id_pais" required>
							<option value="" disabled>Selecciona un pais</option>
							<?php foreach($params['paises'] as $pais) : ?>
								
								<?php 

									if (isset($_SESSION['busqueda'][0]['id_pais'])) :
										$selected = ($_SESSION['busqueda'][0]['id_pais'] == $pais['id']) ? 'selected' : '';
									else :
										$selected = '';
									endif;
								
									$disabled = (is_numeric(array_search($pais['nombre'], $n)) == false) ? 'disabled' : '';

									 $style    = (is_numeric(array_search($pais['nombre'], $n)) == false) ? 'text-transform:uppercase;background:#ccc' : 'text-transform:uppercase;';
								 ?>



								<option <?php echo $disabled.'  '.$selected; ?> style="<?php echo $style; ?> " value="<?php echo $pais['id']; ?>"><?php echo strtoupper($pais['nombre']); ?></option>
							<?php endforeach; ?>
						</select>
					</label>
					
				</div>

				<div class="form-group">
					<label>
						<select name="ciudad" id="sedes" class="form-control">
							<option value="" selected>Selecciona una sede principal  </option>
						</select>
					</label>
					
				</div>
				
				<div class="form-group">
					<label data-toggle="modal" data-target="#cobertura" class="cobertura_btn">
						Selecciona las ciudades de cobertura
					</label>
					<div class="modal fade" id="cobertura" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header" style="background:#f9f9f9;">
					        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
					        <h4 class="modal-title" id="myModalLabel">Ciudades de cobertura</h4>
					      </div>
					      <div class="modal-body">
					       
					      </div>
					      <div class="modal-footer">
					        <button type="button" onclick="change_color(this)" class="btn btn-default" data-dismiss="modal">Seleccionar ciudades</button>
					      </div>
					    </div>
					  </div>
					</div>
				</div>

				

				
				<button type="submit" class="buscar">
					<i class="fa fa-paper-plane"></i>
					BUSCAR
				</button>

				<a style="color: #fff;
					font-size: 17px;
					margin-left: 10px;" href="<?php echo URL; ?>logout"> | <i style="margin-left:10px" class="fa fa-power-off"></i></a>

				
			</form>
		</div>
	</div>

	<div class="container" style="min-height:1200px;">
	
	<div class="uni_full" style="left:0;display:none; position:fixed;z-index:100;background:rgba(244,244,244, 0.7);width:100%;height:100%">
			
			<a style="color:#444;position:absolute;right:30px; font-size:40px;display:block;" href="#" onclick="$(this).parent().children('.container').empty();  $(this).parent().fadeOut('slow');">
				
				<i  class="fa fa-times"></i>

			</a>

			<div class="container" style="padding:0 0 20px 0;background:#fff;margin:0 auto;display:block;max-width:960px;">
				
			</div>

	</div>
		
	<div class="search_results">

		<div class="universidades" style="position:relative;">

			

			<div class="java_filter">
				
				<div class="filters">
				
				<h2>Refinar resultados</h2>

				
				<form  id="filtrar_rango" onsubmit="filtrar_rango(this, event)">
					
					<div class="row">
						<input type="text" style="max-width:94%" name="nombre" placeholder="Filtar por nombre" class="form-control" >
					</div>

					<div class="row">
						<div class="col-md-12">
						<label class="label_">
							<select class="form-control" id="tipo" name="tipo">
								<option value="">Filtrar por tipo</option>
								<option value="0">SIN ANIMO DE LUCRO</option>
								<option value="1">CON ANIMO DE LUCRO</option>
							</select>	
						</label>
						
					</div>

						<div class="col-md-12">
							<label class="label_">
								<select class="form-control" id="acreditaciones_nacionales" name="acreditaciones[nacionales]">
								<option value="">Acreditaciones nacionales</option>
								<option value="1">SI</option>
								<option value="0">NO</option>
							</select>	
							</label>
							
						</div>
						<div class="col-md-12">
							<label class="label_">
								<select class="form-control" id="acreditaciones_internacionales" name="acreditaciones[internacionales]" >
								<option value="">Acreditaciones internacionales</option>
								<option value="1">SI</option>
								<option value="0">NO</option>
							</select>
							</label>
							
						</div>
					</div>
					

					<h4>Numero de sedes</h4>
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="cobertura[num_sedes][desde]" placeholder="Desde" class="form-control" />
						</div>
					
						<div class="col-md-6">
							<input type="text" name="cobertura[num_sedes][hasta]" placeholder="Hasta" class="form-control" />
						</div>
					</div>

					<h4>Poblacion total</h4>
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="poblacion[total][desde]" placeholder="Desde" class="form-control" />
						</div>
						<div class="col-md-6">
							<input type="text" name="poblacion[total][hasta]" placeholder="Hasta" class="form-control" />
						</div>	
					</div>

					<h4>Personal docentes</h4>
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="personal[docentes][desde]" placeholder="Desde" class="form-control" />
						</div>
						<div class="col-md-6">
							<input type="text" name="personal[docentes][hasta]" placeholder="Hasta" class="form-control" />
						</div>
					</div>
					

					<h4>Personal adtivos</h4>
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="personal[adtivos][desde]" placeholder="Desde" class="form-control" />
						</div>
						<div class="col-md-6">
							<input type="text" name="personal[adtivos][hasta]" placeholder="Hasta" class="form-control" />
						</div>
					</div>

					<h4>Total ingresos</h4>
					
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="ingresos[total_ingresos][desde]" placeholder="Desde" class="form-control" />
						</div>
						<div class="col-md-6">
							<input type="text" name="ingresos[total_ingresos][hasta]" placeholder="Hasta" class="form-control" />
						</div>
					</div>
					

					<hr style="border: 1px solid #eee;margin:10px 0 10px -12px;"/>

					<div class="checkbox" style="margin-left:-15px;">
						<label for="">
							<input data-value="presencial" type="checkbox"/> Presencial
						</label>
					</div>
					<div class="checkbox" style="margin-left:6px;">
						<label for="">
							<input data-value="distancia" type="checkbox" /> Distancia
						</label>
					</div>
					<div class="checkbox" style="margin-left:5px;">
						<label for="">
							<input data-value="virtual" type="checkbox" /> Virtual
						</label>
					</div>


					<button type="submit">
						<i class="fa fa-paper-plane"></i>
						Filtrar
					</button>

				</form>
				
				</div>

		</div>
		<!-- Lazo derecho -->

		<div class="results" style="margin-top:58px;display:inline-block;vertical-align:top;width:70%;float:right;">


		<?php if(!is_null($params) && $_SESSION['busqueda'] != false) : ?>

		<h3>(<?php echo count($_SESSION['busqueda']); ?>) Resultados encontrados <small>de <?php echo $total; ?> registros en total</small></h3>
		<?php echo (count($_SESSION['busqueda']) == 0) ? '<div style="margin-top:25px;" class="alert alert-danger" role="alert">No se encontraron resultados</div>' : ''; ?>
		
		<!-- Ordenar -->

		<?php if($_SESSION['busqueda'] > 0): ?>
	
		<form id="ordenar" action="" method="post" class="form-inline" onsubmit="ordenar(this, event)">

			<div class="form-group">
				<label><select name="por" class="form-control" required>
					<option value="" disabled selected>Ordenar de forma</option>
					<option value="ASC">Descendente</option>
					<option value="DSC">Ascendente</option>
				</select></label>
			</div>
			<div class="form-group">
				<label><select name="campo" class="form-control" required>
					<option value="" disabled selected>Ordenar por</option>
					<option value="nombre">Nombre</option>
					<option value="cobertura:num_sedes">Numero de sedes</option>
					<option value="poblacion:total">Poblacion total</option>
					<option value="personal:docentes">Personal docentes</option>
					<option value="personal:adtivos">Personal adtivos</option>
					<option value="ingresos:total_ingresos">Total ingresos</option>
					<option value="modalidad:presencial">Presencial</option>
					<option value="modalidad:distancia">Distancia</option>
					<option value="modalidad:virtual">Virtual</option>
				</select></label>
			</div>

			<button type="submit" class="btn btn-default">Ordenar</button>
		</form>


		


		

	<?php endif; ?>


		<!-- Fin ordenar -->



		<?php 

			$total_registros = count($_SESSION['busqueda']);
			$total_registros = $total_registros/30;



			if(is_float($total_registros)) :

				$total_registros = ceil($total_registros);

			endif;

	
		 	$puff = 1; $con = 0; 

		 	foreach($_SESSION['busqueda'] as $v) : 
				if($con == 30) :
					$puff = $puff +1;
					$con  = 0;

					
				endif;

				$con++;

		?>


		<div class="uni" data-page="<?php echo $puff; ?>" style="<?php echo ($puff == 1) ? 'display:inline-block' : 'display:none'; ?>">
		
		<!-- <i class="fa fa-university"></i> -->

		
		<span style="display:none"><?php echo $v['id']; ?></span>

		<div class="nombre">
			<strong>Nombre</strong> <?php echo $v['nombre']; ?>
		</div>
		<div class="sede">
			<strong>Sede principal</strong><?php echo ucfirst($v['ciudad']); ?>
		</div>
		<div class="rector">
			<strong>Rector</strong><?php echo $v['rector']; ?>
		</div>

		<div class="presidente">
				<strong>Presidente</strong><?php echo $v['presidente']; ?>
			</div>
		
		<div class="email">
			<strong>Email</strong><?php echo $v['email']; ?>
		</div>


		<a href="#" onclick="see_more(this, event)">Ver en detalle<i class="fa fa-plus"></i></a>

		<div class="see_more">
			
			<div class="pagina_web">
				<strong>Pagina web</strong><?php echo $v['pagina_web']; ?>
			</div>

			<div class="telefono">
				<strong>Telefono</strong><?php echo $v['telefono']; ?>
			</div>

			<div class="direccion">
				<strong>Direccion</strong><?php echo $v['direccion']; ?>
			</div>


			<div class="tipo">
				<strong>Tipo : </strong><span><?php echo ($v['tipo'] == '0') ? 'Sin animo de lucro' : 'Con animo de lucro'; ?></span>
			</div>
			
			

			<div class="acreditaciones">
				<?php $acreditaciones = json_decode($v['acreditaciones'], true); ?>
				<strong>Acreditaciones</strong>
				<ul>
				    <li class="acreditaciones_nacionales">
				    	<i>Nacionales:</i>
				    	<span><?php echo ($acreditaciones['nacionales'] == '0') ? 'NO' : 'SI'; ?></span>
			    	</li>
				    <li class="acreditaciones_internacionales">
				    	<i>Internacionales:</i>
				    	<span><?php echo ($acreditaciones['internacionales'] == '0') ? 'NO' : 'SI'; ?></span>
			    	</li>
				</ul>	
			</div>
			<div class="cobertura">
				<?php $cobertura = json_decode($v['cobertura'], true); ?>
				<strong>Cobertura</strong>
				<ul>
				    <li><i>Numero de sedes:</i><?php echo $cobertura['num_sedes']; ?></li>
				    
				</ul>
			</div>
			<div class="modalidad">
				<?php $modalidad = json_decode($v['modalidad'], true); ?>
				<strong># Programas por modalidad</strong>
				<ul>
				    <li><i>Presencial:</i><?php echo $modalidad['presencial']; ?></li>
				    <li><i>Virtual:</i><?php echo $modalidad['virtual']; ?></li>
				    <li><i>Distancia:</i><?php echo $modalidad['distancia']; ?></li>
				</ul>
			</div>
			<div class="poblacion">
				<?php $poblacion = json_decode($v['poblacion'], true); ?>
				<strong>Poblacion</strong>
				<ul>
				    <li class="poblacion_total">
				    	<i>Total:</i>
				    	<span><?php echo ($poblacion['total'] != ' -   ') ? number_format(str_replace('.', '',$poblacion['total'])) : '0'; ?></span>
			    	</li>
				    <li class="poblacion_pregrado">
				    	<i>Pregrado:</i>
				    	<span><?php echo ($poblacion['pregrado'] != ' -   ') ? number_format(str_replace('.', '',$poblacion['pregrado'])) : '0'; ?></span>
			    	</li>
				    <li class="poblacion_posgrado">
				    	<i>Posgrado:</i>
				    	<span><?php echo ($poblacion['posgrado'] != ' -   ') ? number_format(str_replace('.', '',$poblacion['posgrado'])) : '0'; ?></span>
			    	</li>
				</ul>
			</div>
			<div class="poblacion_primer_ingreso">
				<?php $poblacion_primer_ingreso = json_decode($v['poblacion_primer_ingreso'], true); ?>
				<strong>Poblacion primer ingreso</strong>
				<ul>
				    <li><i>Pregrado:</i><?php echo ($poblacion_primer_ingreso['posgrado'] != ' -   ') ? number_format(str_replace('.', '',$poblacion_primer_ingreso['pregrado'])) : '0'; ?></li>
				    <li><i>posgrado:</i><?php echo ($poblacion_primer_ingreso['posgrado'] != ' -   ') ? number_format(str_replace('.', '',$poblacion_primer_ingreso['posgrado'])) : '0'; ?></li>
				</ul>
			</div>
			<div class="desercion">
				<?php $desercion = json_decode($v['desercion'], true); ?>
				<strong>Desercion</strong>
				<ul>
				    
				    <li><i>Acumulada:</i><?php echo ($desercion['acumulada'] != ' -   ') ? number_format(str_replace('.', '', $desercion['acumulada'])) : '0'; ?></li>
				    <li><i>Por Periodo:</i><?php echo ($desercion['por_periodo'] != ' -   ') ? number_format(str_replace('.', '',$desercion['por_periodo'])) : '0'; ?></li>
				</ul>
			</div>
			<div class="personal">
				<?php $personal = json_decode($v['personal'], true); ?>
				<strong>Personal</strong>
				<ul>
				    <li><i>Docentes:</i><?php echo ($personal['docentes'] != ' -   ') ? number_format(str_replace('.', '',$personal['docentes'])) : '0'; ?></li>
				    <li><i>Adtivos:</i><?php echo ($personal['adtivos'] != ' -   ') ? number_format(str_replace('.', '',$personal['adtivos'])) : ''; ?></li>
				</ul>
			</div>
			<div class="ingresos">
				<?php $ingresos = json_decode($v['ingresos'], true); ?>
				<strong>Ingresos</strong>
				<ul>
				    <li class="matricula_posgrado">
				    	<i>Total ingresos anuales:</i>
				    	<span><?php echo ($ingresos['total_ingresos'] != ' -   ') ? number_format(str_replace('.', '',$ingresos['total_ingresos'])) : '0'; ?></span>
			    	</li>
				    <li class="matricula_posgrado">
				    	<i>Valor matricula pregrado promedio:</i>
				    	<span><?php echo ($ingresos['matricula_pregrado'] != ' -   ') ? number_format(str_replace('.', '',$ingresos['matricula_pregrado'])) : '0'; ?></span>
			    	</li>
				    <li class="matricula_pregrado">
				    	<i>Valor matricula posgrado promedio:</i>
				    	<span><?php echo ($ingresos['matricula_posgrado'] != ' -   ') ? number_format(str_replace('.', '',$ingresos['matricula_posgrado'])) : ''; ?></span>
			    	</li>
			    	<li>
			    		<i>Moneda</i>
			    			
		    			


			    		<?php echo $monedas[$ingresos['moneda']]; ?>
			    	</li>
				</ul>
			</div>
			<div class="ciudades_cobertura">
				<strong>Ciudades de cobertura</strong>
				<ul>
				   <?php 

				   	if(!is_numeric($cobertura['ciudades'])) :
					   	if(is_array($cobertura['ciudades'])) :

					   		foreach($cobertura['ciudades'] as $ciudad) :

					   			echo '<li>'.ucfirst($ciudades[$ciudad]).'</li>';

				   			endforeach;

				   		else :

				   			echo '<li>'.ucfirst($ciudades[$cobertura['ciudades']]).'</li>';

				   		endif;
				   	endif;

				    ?>

				</ul>
			</div>

			<div class="observaciones">
				<strong>Observaciones</strong><?php echo $v['observaciones']; ?>
			</div>
				
		</div>

	</div>


		<?php endforeach; ?>

		<!-- Paginador -->
		<div class="paginas">
			
		
		<?php 

			for ($i=1; $i <= $total_registros; $i++) { 
				echo '<a class="page"  onclick="page(this, event)" href="'.$i.'">'.$i.'</a>';
			}
		

		?>
		</div>
		<!-- Fin paginador -->

		<?php else : ?>
			<h3>(0) Resultados </h3>
			<div style="margin-top:25px;" class="alert alert-danger" role="alert">No se encontraron resultados</div>
		<?php endif; ?>

		</div>

	</div>	

	<script type="text/javascript">
		
		function see_more(nip, e)
		{
			e.preventDefault();
			console.log('aaaa');
			var uni_html = $(nip).parent().html();
			$('.uni_full').fadeIn('slow');
			$('.uni_full .container').html(uni_html);
		}

		function ordenar(nip, e)
		{
			e.preventDefault();	
			var form = $(nip);

			$.ajax({
				url: '<?php echo URL ?>ordenar',
				cache: false,
				type: 'POST',
				data: form.serialize(),
				success: function(html){
				$('.results').html(html);
				}
			});

		}
		

		function page(nip, e)
		{
			e.preventDefault();

			var data_page = $(nip).attr('href');



			$('.paginas a').css("color","#ff4c4c");
			$(nip).css("color","#2eb8d4");

			$('.uni').fadeOut('slow');
			$('.uni[data-page="'+ data_page +'"]').fadeIn('slow').css("display","inline-block");


		}

		/*function buscar(nip)
		{
			
			$('.uni_full').empty().fadeOut('slow');

			var text  = $(nip).val();
			var campo = $(nip).attr('id');
			console.log(text);

			if(text.length > 1){

				$('.'+campo).parent().fadeOut('slow');

				$(' .'+campo+':contains("'+text+'")').parent().fadeIn('slow');
			}
			else {

				$('.'+campo).parent().fadeIn('slow');
			}

		}*/

		function change_color(nip)
		{
			$('.buscar').css("background-color", "#fff");
			$('.buscar').css("color", "#ff4c4c");

			$('.cobertura_btn').text('Nada');

			 var text = ' ';

			$.each($('#cobertura .modal-body input:checked')  , function( index, value ) {
  				
				 var np   = $(value).parent().text().replace(" ", "");
			 	
				 if(index < 3){
				 	 text = text.concat(np, ' ');	
				 }

				 


  				
			});	

			$('.cobertura_btn').text(text);
			console.log(text);


		}

		function filtrar_rango(nip, e)
		{
			
			e.preventDefault();

			var form = $(nip);

			$.ajax({
				url: '<?php echo URL ?>filtros',
				cache: false,
				type: 'POST',
				data: form.serialize(),
				success: function(html){
				$('.results').html(html);
				}
			});

	   }


	   function modalidad(nip)
	   {

	   	var clase = $(nip).attr('data-value');

	   		if(nip.checked){

	   			$( "#filtrar_rango button" ).before('<div class="row '+clase+'">'
				+'<h4 style="margin-left:0;">MODALIDAD '+clase.toUpperCase()+'</h4>'
				+'<div class="col-md-6">'
						+'<input type="text" name="modalidad['+clase+'][desde]" placeholder="Desde" class="form-control" />'
				+'</div>'
				+'<div class="col-md-6">'
					+'<input type="text" name="modalidad['+clase+'][hasta]" placeholder="Hasta" class="form-control" />'
				+'</div>'
   				+'</div>');

	   		}
	   		else {

	   			$('.'+clase).remove();

	   		}

	   }

	   $('input[type="checkbox"]').change(function(e){

	   		var clase = $(this).attr('data-value');

	   		if(this.checked){

	   			$( "#filtrar_rango button" ).before('<div class="row '+clase+'">'
				+'<h4 style="margin-left:0;">MODALIDAD '+clase.toUpperCase()+'</h4>'
				+'<div class="col-md-6">'
						+'<input type="text" name="modalidad['+clase+'][desde]" placeholder="Desde" class="form-control" />'
				+'</div>'
				+'<div class="col-md-6">'
					+'<input type="text" name="modalidad['+clase+'][hasta]" placeholder="Hasta" class="form-control" />'
				+'</div>'
   				+'</div>');

	   		}
	   		else {

	   			$('.'+clase).remove();

	   		}

	   });



		$('#pais').change(function(e){
		
			var id = $(this).val();
			
			$('#cobertura option:gt(0)').remove();
			$('#sedes option:gt(0)').remove();


			$.ajax({

				url: "<?php echo URL.'cobertura_ajax'; ?>",
				cache: false,
				type: 'POST',
				data: {id: id},
				success: function(html){
				$('#cobertura .modal-body').html(html);
				}
				

			});

			$.ajax({

				url: "<?php echo URL.'sedes_ajax'; ?>",
				cache: false,
				type: 'POST',
				data: {id: id},
				success: function(html){
				$('#sedes').append(html);
				}
				

			});

		});

		$('#simple_search').submit(function(e){

			e.preventDefault();

			var form = $(this);

			$.ajax({

				url: "<?php echo URL.'busqueda_simple'; ?>",
				cache: false,
				type: 'POST',
				data: form.serialize(),
				success: function(html){
				$('.search_results').html(html);
				}
				

			});

		});





		$(document).ready(function(e){

			<?php if (isset($_SESSION['busqueda'][0]['id_pais'])) : ?>

				$('#pais').val(<?php echo $_SESSION['busqueda'][0]['id_pais']; ?>).change();

			<?php endif; ?>


		});



	</script>
	</div>
</section>