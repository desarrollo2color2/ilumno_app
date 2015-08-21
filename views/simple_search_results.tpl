<?php 

	$monedas  = $params['monedas']; unset($params['monedas']); 
	$ciudades = $params['cities'];  unset($params['cities']); 
	$total    = $params['total'];   unset($params['total']);



?>

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

					<h4>Tier</h4>
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="tier[desde]" placeholder="Desde" class="form-control" />
						</div>
						<div class="col-md-6">
							<input type="text" name="tier[hasta]" placeholder="Hasta" class="form-control">
						</div>
					</div>

					<h4>Ranking Nacional</h4>
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="rank_nacional[desde]" placeholder="Desde" class="form-control" />
						</div>
						<div class="col-md-6">
							<input type="text" name="rank_nacional[hasta]" placeholder="Hasta" class="form-control">
						</div>
					</div>

					<h4>Ranking latinoamercia</h4>
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="rank_lati[desde]" placeholder="Desde" class="form-control" />
						</div>
						<div class="col-md-6">
							<input type="text" name="rank_lati[hasta]" placeholder="Hasta" class="form-control">
						</div>
					</div>

					<h4>Ranking Mundial</h4>
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="rank_mundial[desde]" placeholder="Desde" class="form-control" />
						</div>
						<div class="col-md-6">
							<input type="text" name="rank_mundial[hasta]" placeholder="Hasta" class="form-control">
						</div>
					</div>
					

					<hr style="border: 1px solid #eee;margin:10px 0 10px -12px;"/>

					<div class="checkbox" style="margin-left:-15px;">
						<label for="">
							<input data-value="presencial" onchange="modalidad(this)" type="checkbox"/> Presencial
						</label>
					</div>
					<div class="checkbox" style="margin-left:6px;">
						<label for="">
							<input data-value="distancia" onchange="modalidad(this)" type="checkbox" /> Distancia
						</label>
					</div>
					<div class="checkbox" style="margin-left:5px;">
						<label for="">
							<input data-value="virtual" onchange="modalidad(this)" type="checkbox" /> Virtual
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
			
			<h3>(<?php echo count($params); ?>) Resultados encontrados <small>de <?php echo $total; ?> registros en total</small></h3>
			<?php echo (count($params) == 0) ? '<div style="margin-top:25px;" class="alert alert-danger" role="alert">No se encontraron resultados</div>' : ''; ?>

		<!-- Ordenar -->

		<?php if($_SESSION['busqueda'] > 0): ?>
	
		<form id="ordenar" action="" method="post" class="form-inline" onsubmit="ordenar(this, event)">

			<div class="form-group">
				<label>
					<select name="por" class="form-control" required>
						<option value="" disabled selected>Ordenar de forma:</option>
						<option value="ASC">Descendente</option>
						<option value="DSC">Ascendente</option>
					</select>
				</label>
				
			</div>
			<div class="form-group">
				<label>
					<select name="campo" class="form-control" required>
						<option value="" disabled selected>Ordenar por:</option>
						<option value="nombre">Nombre</option>
						<option value="cobertura:num_sedes">Numero de sedes</option>
						<option value="poblacion:total">Poblacion total</option>
						<option value="personal:docentes">Personal docentes</option>
						<option value="personal:adtivos">Personal adtivos</option>
						<option value="ingresos:total_ingresos">Total ingresos</option>
						<option value="modalidad:presencial">Presencial</option>
						<option value="modalidad:distancia">Distancia</option>
						<option value="modalidad:virtual">Virtual</option>
						<option value="tier">Tier</option>
						<option value="rank_nacional">Ranking nacional</option>
						<option value="rank_lati">Ranking latinoamerica</option>
						<option value="rank_mundial">Ranking mundial</option>
					</select>	
				</label>	
				
			</div>

			<button type="submit" class="btn btn-default">Ordenar</button>
		</form>

		<?php endif; ?>


		<!-- Fin ordenar -->





		<?php 

			$total_registros = count($params);
			$total_registros = $total_registros/30;

				if(is_float($total_registros)) :

					$total_registros = ceil($total_registros);

				endif;

		
		 	$puff = 1; $con = 0; 

			foreach($params as $v) : 

				if($con == 30) :
					$puff = $puff +1;
					$con  = 0;

					
				endif;

				$con++;

		?>
		<div class="uni" data-page="<?php echo $puff; ?>" style="<?php echo ($puff == 1) ? 'display:inline-block' : 'display:none'; ?>">
		
			<!-- <i class="fa fa-university"></i> -->
		
		<?php $poblacion = json_decode($v['poblacion'], true); ?>
		<?php $ingresos = json_decode($v['ingresos'], true); ?>
		
		<span style="display:none"><?php echo $v['id']; ?></span>

		<div class="nombre">
			<strong>Nombre</strong> <?php echo $v['nombre']; ?>
		</div>
		
		<div class="poblacion_total">
			<strong>Poblacion total</strong>
			<?php echo ($poblacion['total'] != '0' and $poblacion['total'] != ' -   ') ? number_format(str_replace(' ', '',$poblacion['total'])) : '0'; ?>
		</div>
		
		<div class="valor_pregrado">
			<strong>Valor matricula pregrado promedio:</strong>
		
			<?php echo ($ingresos['matricula_pregrado'] != '0' and $ingresos['matricula_pregrado'] != ' -   ') ? number_format(str_replace(' ', '', $ingresos['matricula_pregrado'])) : '0'; ?>
		</div>

		<div class="valor_posgrado">
			<strong>Valor matricula posgrado promedio:</strong>
			<?php echo ($ingresos['matricula_posgrado'] != '0' and $ingresos['matricula_posgrado'] != ' -   ') ? number_format(str_replace(' ', '',$ingresos['matricula_posgrado'])) : '0'; ?>
		</div>
	

		<div class="total_ingresos">
			<strong>Total ingresos anuales:</strong>
			<?php echo ($ingresos['total_ingresos'] != '0' and $ingresos['total_ingresos'] != ' -   ' ) ? number_format(str_replace(' ', '',$ingresos['total_ingresos'])) : '0'; ?>
		</div>	



		

		<a href="#" onclick="see_more(this, event)">Ver en detalle<i class="fa fa-plus"></i></a>

		<div class="see_more">
			
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
				
				<strong>Poblacion</strong>
				<ul>
				    <li class="poblacion_total1">
				    	<i>Total:</i>
				    	<span><?php echo ($poblacion['total'] != '0' and $poblacion['total'] != ' -   ') ? number_format(str_replace(' ', '',$poblacion['total'])) : '0'; ?></span>
			    	</li>
				    <li class="poblacion_pregrado">
				    	<i>Pregrado:</i>
				    	<span><?php echo ($poblacion['pregrado'] != '0' and $poblacion['pregrado'] != ' -   ') ? number_format(str_replace(' ', '',$poblacion['pregrado'])) : '0'; ?></span>
			    	</li>
				    <li class="poblacion_posgrado">
				    	<i>Posgrado:</i>
				    	<span><?php echo ($poblacion['posgrado'] != '0' and $poblacion['posgrado'] != ' -   ') ? number_format(str_replace(' ', '',$poblacion['posgrado'])) : '0'; ?></span>
			    	</li>
				</ul>
			</div>
			<div class="poblacion_primer_ingreso">
				<?php $poblacion_primer_ingreso = json_decode($v['poblacion_primer_ingreso'], true); ?>
				<strong>Poblacion primer ingreso</strong>
				<ul>
				    <li><i>Pregrado:</i><?php echo ($poblacion_primer_ingreso['posgrado'] != '0' and $poblacion_primer_ingreso['posgrado'] != ' -   ') ? number_format(str_replace(' ', '',$poblacion_primer_ingreso['pregrado'])) : '0'; ?></li>
				    <li><i>posgrado:</i><?php echo ($poblacion_primer_ingreso['posgrado'] != '0' and $poblacion_primer_ingreso['posgrado'] != ' -   ') ? number_format(str_replace(' ', '',$poblacion_primer_ingreso['posgrado'])) : '0'; ?></li>
				</ul>
			</div>
			<div class="desercion">
				<?php $desercion = json_decode($v['desercion'], true); ?>
				<strong>Desercion</strong>
				<ul>
				    
				    <li><i>Acumulada:</i><?php echo ($desercion['acumulada'] != '0' and $desercion['acumulada'] != ' -   ') ? number_format(str_replace(' ', '', $desercion['acumulada'])) : '0'; ?></li>
				    <li><i>Por Periodo:</i><?php echo ($desercion['por_periodo'] != '0' and $desercion['por_periodo'] != ' -   ') ? number_format(str_replace(' ', '',$desercion['por_periodo'])) : '0'; ?></li>
				</ul>
			</div>
			<div class="personal">
				<?php $personal = json_decode($v['personal'], true); ?>
				<strong>Personal</strong>
				<ul>
				    <li><i>Docentes:</i><?php echo ($personal['docentes'] != '0' and $personal['docentes'] != ' -   ') ? number_format(str_replace(' ', '',$personal['docentes'])) : '0'; ?></li>
				    <li><i>Adtivos:</i><?php echo ($personal['adtivos'] != '0' and $personal['adtivos'] != ' -   ') ? number_format(str_replace(' ', '',$personal['adtivos'])) : ''; ?></li>
				</ul>
			</div>
			<div class="ingresos">
				<?php $ingresos = json_decode($v['ingresos'], true); ?>
				<strong>Ingresos</strong>
				<ul>
				    <li class="matricula_posgrado">
				    	<i>Total ingresos anuales:</i>
				    	<span><?php echo ($ingresos['total_ingresos'] != '0' and $ingresos['total_ingresos'] != ' -   ') ? number_format(str_replace(' ', ' ',$ingresos['total_ingresos'])) : '0'; ?></span>
			    	</li>
				    <li class="matricula_posgrado">
				    	<i>Valor matricula pregrado promedio:</i>

				    	<span><?php echo ($ingresos['matricula_pregrado'] != '0' and $ingresos['matricula_pregrado'] != ' -   ') ? number_format(str_replace(' ', '',$ingresos['matricula_pregrado'])) : '0'; ?></span>
			    	</li>
				    <li class="matricula_pregrado">
				    	<i>Valor matricula posgrado promedio:</i>
				    	<span><?php echo ($ingresos['matricula_posgrado'] != '0' and $ingresos['matricula_posgrado'] != ' -   ') ? number_format(str_replace(' ', '',$ingresos['matricula_posgrado'])) : '0'; ?></span>
			    	</li>
			    	<li>
			    		<i>Moneda</i>

			    		<?php echo $monedas[$ingresos['moneda']]; ?>
			    	</li>
				</ul>
			</div>

			<div class="tier">
				<strong>Tier</strong>
				<ul>
					<li><?php echo $v['tier']; ?></li>
				</ul>
				
			</div>
			
			<div class="ranking">
				<strong>Ranking</strong>
				<ul>
					<li><i>Nacional :</i> <?php echo $v['rank_nacional']; ?></li>
					<li><i>Latinoamerica :</i> <?php echo $v['rank_lati']; ?></li>
					<li><i>Mundial :</i> <?php echo $v['rank_mundial']; ?></li>
				</ul>
				
			</div>
			<div class="ciudades_cobertura">
				<strong>Ciudades de coberturas</strong>
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

				   		else : 

			   				echo '<li>'.ucfirst($ciudades[$cobertura['ciudades']]).'</li>';



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

		</div>

	</div>	