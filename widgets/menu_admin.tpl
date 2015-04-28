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
	<!-- Paises -->
	<li class="submenu"><a href="#"><i class="fa fa-user"></i> Paises<i class="fa fa-plus"></i></a>
		<ul>

			<li><a href="<?php echo URL; ?>admin/countries"> Todos los paises </a></li>
			<li><a href="<?php echo URL; ?>admin/add_country"> Añadir pais </a></li>

		</ul>
	</li>
	<!-- Monedas -->
	<li class="submenu"><a href="#"><i class="fa fa-user"></i> Monedas<i class="fa fa-plus"></i></a>
		<ul>

			<li><a href="<?php echo URL; ?>admin/currencies"> Todas las monedas </a></li>
			<li><a href="<?php echo URL; ?>admin/add_currency"> Añadir moneda </a></li>

		</ul>
	</li>
	<!-- Ciudades -->
	<li class="submenu"><a href="#"><i class="fa fa-user"></i> Ciudades<i class="fa fa-plus"></i></a>
		<ul>

			<li><a href="<?php echo URL; ?>admin/cities"> Todas las ciudades </a></li>
			<li><a href="<?php echo URL; ?>admin/add_city"> Añadir ciudad </a></li>

		</ul>
	</li>
	<!-- Universidades -->
	<li class="submenu"><a href="#"><i class="fa fa-user"></i> Universidades<i class="fa fa-plus"></i></a>
		<ul>

			<li><a href="<?php echo URL; ?>admin/universities"> Todas las universidades </a></li>
			<li><a href="<?php echo URL; ?>admin/add_university"> Añadir universidad </a></li>
			<li><a href="<?php echo URL; ?>admin/form_import_university"> Importar universidad </a></li>
			<li><a href="<?php echo URL; ?>admin/import_cities_cobertura"> Importar coberturas </a></li>

		</ul>
	</li>
	<!-- Buscar -->
	<!-- <li><a href="<?php //echo URL.'admin/search' ?>"><i class="fa fa-user"></i> Buscar </a></li> -->
	
</ul>

<?php endif; ?>
