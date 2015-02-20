<?php if(isset($_SESSION['user']) && $_SESSION['user']['tipo'] == 'admin') : ?>

<ul>
	<li><a href="<?php echo URL; ?>admin"> <i class="fa fa-home"></i>Inicio</a></li>
	<!-- Usuario -->
	<li class="submenu"><a href="#"><i class="fa fa-user"></i> Usuarios<i class="fa fa-plus"></i></a>
		<ul>

			<li><a href="<?php echo URL; ?>admin/users"> Todos los usuarios </a></li>
			<li><a href="<?php echo URL; ?>admin/add_user"> Añadir usuario </a></li>

		</ul>
	</li>
	
</ul>

<?php endif; ?>
