<div class="admin">

<h1 class="title"><i class="fa fa-user"></i>Busqueda</h1>

<form action="<?php echo URL.'admin/advance_search'; ?>" method="POST">

	<div class="form-group">

		<label>Universidades a comparar</label>
		<input type="number" id="number_uni" class="form-control" />
		<a id="generar" href="">Generar</a>
	</div>
	
	<div class="results search_results"></div>

	<div class="form_group" style="display:none;">
		<button type="submit" disabled>
			<i class="fa fa-search"></i>
			Enviar
		</button>

	</div>
</form>
</div>
<script type="text/javascript">
	
	function getcities(nip)
	{
		var id = $(nip).val();
		
		$.ajax({

			url: "<?php echo URL.'admin/get_ajax_cities_university'; ?>",
			cache: false,
			type: 'POST',
			data: {id: id},
			success: function(html){
			$(nip).parent().parent().children('.ciudades').children('select').html(html);
			}
			

		});


		
	}


	

	$('#generar').click(function(e){
		e.preventDefault();

		var number_ = $('#number_uni').val();
		var width   = 100/number_;

		$('.results').empty();


		for (i = 0; i < number_; i++) {
    		$('.results').append('<div class="row" style="width:'+width+'%">'
    				+'<div class="form-group">'
    					+'<label>Pais</label>'
    					+'<select onchange="getcities(this)" class="form-control">'
    					+'<option selected disabled>Selecciona una opcion</option>'
    					<?php foreach($params['paises'] as $country) : ?>
    						+'<option value="<?php echo $country['id'] ?>"><?php echo $country['nombre']; ?></option>'
    					<?php endforeach; ?>
    					+'</select>'
    				+'</div>'
    				+'<div class="form-group ciudades">'
    					+'<label>Ciudad</label>'
    					+'<select onchange="getuniversities(this)" class="form-control">'
    					+'</select>'
    				+'</div>'
    				+'<div class="form-group">'
    					+'<label>Universidades</label>'
    					+'<select name="universities[]" class="form-control">'
    					+'</select>'
    				+'</div>'
    			+'</div>'
			);
		}

	});
</script>