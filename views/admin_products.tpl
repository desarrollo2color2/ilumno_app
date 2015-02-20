<div class="admin">

<h1 class="title"><i class="fa fa-book"></i> Productos</h1>

<a class="add_button" href="<?php echo URL; ?>admin/add_product"><i class="fa fa-plus"></i> Añadir producto</a>


<?php if($params) : ?>

	<div class="results"></div>

	<div class="table-responsive">

	<table class="table table-striped">

		<thead>

			<tr>

				<th>Nombre producto</th>
				<th>Pais</th>

				<th></th>
				<th></th>

			</tr>
		</thead>

		<tbody>

			<?php  foreach($params as $product) : ?>

				<tr>

					<td><?php echo $product['nombre']; ?></td>
					<td><?php echo $product['nombre_pais']; ?></td>

					<td><a class="edit" href="<?php echo URL.'admin/update_product/id/'.$product['id']; ?>"><i class="fa fa-pencil-square-o"></i></a></td>	
					<td><a class="delete_product delete" href="<?php echo $product['id']; ?>"><i class="fa fa-trash"></i></a></td>
				</tr>

			<?php endforeach; ?>

		</tbody>


	</table>

	</div>

<?php endif; ?>

<script type="text/javascript">

	$('.delete_product').click(function(e){

		e.preventDefault();

		var id = $(this).attr('href');
		$(this).parent().parent().remove();

		$.ajax({

			url: "<?php echo URL.'admin/delete_product'; ?>",
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