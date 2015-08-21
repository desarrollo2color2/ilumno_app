<?php 

	
	
?>


<div id="type_pais" class="type">
	
	<table id="table_filter" class="table table-striped">
		<thead>
			<tr>
				<th colspan="6">TOP POR PAIS - TIER 3 y 4</th>
			</tr>
			<tr style="display:none" class="apli_filters">
				<th colspan="6"></th>
			</tr>
			<tr class="fields">
				<th>País 
					<a onclick="filter_a(this,event)" data-text="Paises" data-form="tipo_pais" data-field="id_pais" data-type="combo" href="">
					<i class="fa fa-filter"></i></a>
				</th>

				<th>Institucíon 
					<a onclick="filter_a(this,event)" data-text="Nombre universidad" data-form="tipo_pais" data-field="nombre" data-type="like" href="">
					<i class="fa fa-filter"></i></a>
				</th>
				
				<th>Tier 
					<a onclick="filter_a(this,event)" data-text="Tier" data-form="tipo_pais" data-field="tier" data-type="combo" href="">
						<i class="fa fa-filter"></i>
					</a>
				</th>
				<th>No estudiantes 
					<a onclick="filter_a(this,event)" data-text="No estudiantes" data-form="tipo_pais" data-field="poblacion:total" data-type="rang" href="">
						<i class="fa fa-filter"></i>
					</a>
				</th>

				<th>Ingresos USD 
					<a onclick="filter_a(this,event)" data-text="Ingresos" data-form="tipo_pais" data-field="ingresos:total_ingresos" data-type="rang" href="">
						<i class="fa fa-filter"></i>
					</a>
				</th>
				<th>Ranking nacional 
					<a onclick="filter_a(this,event)" data-text="Ranking nacional" data-form="tipo_pais" data-field="rank_nacional" data-type="rang" href="">
						<i class="fa fa-filter"></i>
					</a>
				</th>
			</tr>
		</thead>
		<tbody>
			
				<?php foreach($params as $k => $v) : $paises[$v['id_pais']] = $v['nombre_pais'];  ?>
					<tr>
						<td> <?php echo $v['nombre_pais']; ?> </td>
						<td> <?php echo $v['nombre']; ?></td>
						<td> <?php echo $v['tier']; ?> </td>
						<td> <?php echo number_format($v['poblacion']['total']); ?></td>
						<td> <?php echo number_format(str_replace(' ', '', $v['ingresos']['total_ingresos'])); ?></td>
						<td> <?php echo $v['rank_nacional']; ?></td>
					</tr>
				<?php endforeach; ?>	
			
		</tbody>
	</table>	



</div>





<div class="type_pop_up">
		<div class="type_container">
			<a href="" class="close_type"><i class="fa fa-times"></i></a>
			<div class="type_form">
				
			</div>
		</div>
</div>


<script type="text/javascript">
	
	var id_pais = {

		

		<?php foreach($paises as $k1 => $v1): ?>
			'<?php echo $k1; ?>' : '<?php echo utf8_encode($v1); ?>', 
		<?php endforeach; ?>
	}; 


	var tier = {
		'3' : '3',
		'4' : '4',
	};

	var nombre = [
		<?php foreach($params as $k2 => $v2): ?>
			<?php echo $v2['id']; ?>, 
		<?php endforeach; ?>
	];



	function open_select(nip, e)
	{
		e.preventDefault();
		$(nip).parent().children('.option').fadeToggle();
	}


	function apli_filter(field, value, data_type, text)
	{

		var html = '';

		switch(data_type)
		{
			case 'combo' :
				

				var combo_array = eval(field);
				var new_value   = value.split(",");
				
				html = html.concat('<h4>'+text+'</h4>');
				
				$.each( new_value, function( key, value ) {
					
					
					 html = html.concat('<a onclick="" data-field="'+field+'" '
					  +'data-value="'+value+'"'
					  +'data-type="'+data_type+'"'
					  +'href="#">'+combo_array[value]+' <i class="fa fa-times-circle-o"></i></a>');
					
					
				});

			break;


			case 'like' :

				html = html.concat('<h4>'+text+'</h4>');

				html = html.concat('<a onclick="" data-field="'+field+'" '
					  +'data-value="'+value+'"'
					  +'data-type="'+data_type+'"'
					  +'href="#">'+value+' <i class="fa fa-times-circle-o"></i></a>');

			break;

			case 'rang' :
				
				var new_value   = value.split(",");

				html = html.concat('<h4>'+text+'</h4>');

				html = html.concat('<a onclick="" data-field="'+field+'" '
					  +'data-value="'+value+'"'
					  +'data-type="'+data_type+'"'
					  +'href="#">'+new_value[0]+' -  '+new_value[1]+''
					  +' <i class="fa fa-times-circle-o"></i></a> ');

		

			break;
		}

		$('.apli_filters').fadeIn();
		$('.apli_filters th').append(html);		
	}

	function send_value(nip, e)
	{

		var field     = $(nip).parent().attr('data-field');
		var data_form = $(nip).parent().attr('data-form');
		var data_type = $(nip).parent().attr('data-type');	
		var value     = $(nip).attr('data-value');
		var text      = $(nip).parent().attr('data-text');

		
		

		if(value != ''){


			if(data_type == 'rang')
			{

				var init = $(nip).parent().children('.rango').children('#init').val(); 	
				var fin  = $(nip).parent().children('.rango').children('#fin').val();
					
				
				

				if(fin > init)
				{

					$('.type_pop_up').fadeOut('slow');
					$('.type_pop_up .type_container').removeClass('on');

					$.ajax({
					
						url: "<?php echo URL.'filter_by_type'; ?>",
						cache: false,
						type: 'POST',
						data: {field : field, data_form, data_form, data_type : data_type, value : value},		
						success: function(html){
							$('#table_filter a[data-field="'+field+'"] ').fadeOut();
							apli_filter(field, value, data_type, text);
							$(".type table tbody").fadeIn(100, 'fold').html(html);
						}
					});


				}	
				else {
					alert('El valor de hasta debe ser mayor a desde');
				}
				
			}
			else {
				$('.type_pop_up').fadeOut('slow');
				$('.type_pop_up .type_container').removeClass('on');

				$.ajax({
				
					url: "<?php echo URL.'filter_by_type'; ?>",
					cache: false,
					type: 'POST',
					data: {field : field, data_form, data_form, data_type : data_type, value : value},		
					success: function(html){
						$('#table_filter a[data-field="'+field+'"] ').fadeOut();
						apli_filter(field, value, data_type, text);
						$(".type table tbody").fadeIn(100, 'fold').html(html);
					}
				});
			}	

			

		}
		else {
			alert('Indique algun valor para el filtro');
		}

		

	}

	function key_input(nip, e)
	{

		var value = $(nip).val();
		$('.type_form > a').attr('data-value', value);

	}


	function select_option(nip, e)
	{

		if($(nip).hasClass('selected'))
		{
			$(nip).removeClass('selected');
			var selected = {};
				$.each( $('.type_form .select .selected'), function( key, value ) {
					
					selected[key] = $(this).attr('data-value');
				});
		}
		else {
			$(nip).addClass('selected');
			var selected = [];
			
				$.each( $('.type_form .select .selected'), function( key, value ) {
					
					var n1 = $(this).attr('data-value');
					var n2 = $(this).text();

					selected[key] = n1;
				});

		}	

	
		
		$('.type_form > a').attr('data-value', selected);


	}


	function rang_init(nip,e)
	{

		var fin   = $(nip).next().val();
		var init  = $(nip).val();

		

		if(fin.length != 0){
			// console.log(fin);
			var value = init.concat(',');
			value     = value.concat(fin);
			// console.log(value);
			$('.type_form > a').attr('data-value', value);

		}

	

	}
	function rang_fin(nip,e)
	{


		var init   = $(nip).parent().children('input:first-child').val();
		var fin    = $(nip).val();



		// console.log(nip);
		

		if( init.length != 0){
				
			var value = init.concat(',').concat(fin);
			// console.log(value);

			$('.type_form > a').attr('data-value', value);

		}


	}


	function filter_a(nip, e)
	{
		e.preventDefault();
		$('.type_pop_up').fadeIn('slow');
		$('.type_pop_up .type_container').addClass('on');

		$('.type_form').empty();
		var field    = $(nip).attr('data-field');
		var data_form = $(nip).attr('data-form');
		var data_type = $(nip).attr('data-type');
		var data_text = $(nip).attr('data-text');

		$('.type_form').attr('data-field', field);
		$('.type_form').attr('data-form',  data_form);
		$('.type_form').attr('data-type', data_type);
		$('.type_form').attr('data-text', data_text);


		switch(data_type)
		{

			case 'combo' :
				var text = $(nip).attr('data-text');
				var html = '<a class="open_select" href="#" onclick="open_select(this,event)"> '+text+'<i class="fa fa-bars"></i></a>';
				
				


				var i = 1;


				var combo_array = eval(field);


				

				$.each( combo_array, function( key, value ) {
					
					
					var margin = (i == 1) ? 'style="margin-top:40px;"' : '';
					
					html = html.concat('<div '+margin+' onclick="select_option(this,event)" class="option" data-value="'+key+'">'+value+'</div>');
					i++;	
					
				});

				$('.type_form').append('<div class="select">'+html+'</div>'
					+'<a onclick="send_value(this,event)" data-value="">Aplicar filtro</a>');

			break;


			case 'like' :
				var text = $(nip).attr('data-text');
				var html = '<a onclick="send_value(this,event)" data-value="">Aplicar filtro</a>';
				html = html.concat('<div class="input"><input class="form-control" onkeyup="key_input(this, event)" value="" placeholder="'+text+'" /></div>');


				// var combo_array = eval(field);

				// html = html.concat('<div class="checkgroup">');
				

				// $.each( combo_array, function( key, value ) {
					
					
				// 	var margin = (i == 1) ? 'style="margin-top:40px;"' : '';
					
				// 	html = html.concat('<div>'
				// 		'<input type="checkbox"'
				// 		'</div>');
				// 	i++;	
					
				// });

				// html = html.concat('</div>');

				$('.type_form').append(html);

			break;

			case 'rang' :
				
				var text = $(nip).attr('data-text');

				var html = '<a onclick="send_value(this,event)" data-value="">Aplicar filtro</a>';
				html = html.concat('<div class="rango">'
					+'<input id="init" class="form-control" onkeyup="rang_init(this, event)" value="" placeholder="Desde" />'
					+'<input id="fin" class="form-control" onkeyup="rang_fin(this, event)" value="" placeholder="Hasta" /></div>');
				

				$('.type_form').append(html);

			break;

		}	
	}




	$('#table_filter a').click(function(e){
		



	});	

	$('.close_type').click(function(e){
		e.preventDefault();
		$('.type_pop_up').fadeOut('slow');
		$('.type_pop_up .type_container').removeClass('on');

	});





</script>