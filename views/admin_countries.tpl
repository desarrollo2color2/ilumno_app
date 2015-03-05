<div class="admin">

<h1 class="title"><i class="fa fa-book"></i> Paises</h1>

<a class="add_button" href="<?php echo URL; ?>admin/add_country"><i class="fa fa-plus"></i> Añadir pais</a>


<?php if($params) : ?>

	<div class="results"></div>

	<div class="table-responsive">

	<table class="table table-striped">

		<thead>

			<tr>

				<th>Nombre pais</th>


				<th></th>
				<th></th>

			</tr>
		</thead>

		<tbody>

			<?php  foreach($params as $country) : ?>

				<tr>

					<td><?php echo $country['nombre']; ?></td>

					<td><a class="edit" href="<?php echo URL.'admin/update_country/'.$country['id']; ?>"><i class="fa fa-pencil-square-o"></i></a></td>	
					<td><a class="delete_country delete" href="<?php echo $country['id']; ?>"><i class="fa fa-trash"></i></a></td>
				</tr>

			<?php endforeach; ?>

		</tbody>


	</table>

	</div>

<?php endif; ?>

<script type="text/javascript">

	$('.delete_country').click(function(e){

		e.preventDefault();

		var id = $(this).attr('href');
		$(this).parent().parent().remove();

		$.ajax({

			url: "<?php echo URL.'admin/delete_country'; ?>",
			cache: false,
			type: 'POST',
			data: {id: id},
			success: function(html){
			$(".results").fadeIn(100, 'fold').html(html);
			}
			}); 

		});


</script>
</div>