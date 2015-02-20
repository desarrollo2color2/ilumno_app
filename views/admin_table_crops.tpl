<div class="admin">

<h1 class="title"><i class="fa fa-book"></i> Tabla Cultivos</h1>

<a class="add_button" href="<?php echo URL; ?>admin/add_tablecrop"><i class="fa fa-plus"></i> Añadir tabla cultivo</a>


<?php if($params) : ?>

	<div class="results"></div>

	<div class="table-responsive">

	<table class="table table-striped">

		<thead>

			<tr>

				<th>Nombre cultivo</th>
			
				

				<th></th>
				<th></th>

			</tr>
		</thead>

		<tbody>

			<?php  foreach($params as $tablecrop) : ?>

				<tr>

					<td><?php echo $tablecrop['nombre']; ?></td>
			
					

					<td><a class="edit" href="<?php echo URL.'admin/update_tablecrop/id/'.$tablecrop['id']; ?>"><i class="fa fa-pencil-square-o"></i></a></td>	
					<td><a class="delete_tablecrop delete" href="<?php echo $tablecrop['id']; ?>"><i class="fa fa-trash"></i></a></td>
				</tr>

			<?php endforeach; ?>

		</tbody>


	</table>

	</div>

<?php endif; ?>

<script type="text/javascript">

	$('.delete_tablecrop').click(function(e){

		e.preventDefault();

		var id = $(this).attr('href');
		$(this).parent().parent().remove();

		$.ajax({

			url: "<?php echo URL.'admin/delete_tablecrop'; ?>",
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