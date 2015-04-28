<html lang="<?php echo LANG; ?>">

	<head>
		
		<!-- Title -->
		
		<title><?php self::__title(); ?></title>

		<!-- Metas  -->


		 
		<meta content="text/html; charset=iso-8859-1" http-equiv="Content-Type">
	
	   	
	   	<!-- Links -->

	   	<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css"/>
		<link href="<?php echo URL; ?>assets/css/negma.css" rel="stylesheet" type="text/css" />
		<link rel="shortcut icon" href="<?php echo URL; ?>assets/img/favicon.ico">	
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

		<!-- Scripts -->

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />


	</head>

	<body class="home">

		<div class="login_head">
			<div class="container">
				
			</div>
		</div>

		<div class="maincontent">
			<?php 

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

			 ?>


			<section id="seleccion_paises">
				<div class="container">
					<!-- Content -->
					<div class="content_paises">
						<h1 class="title"><?php echo utf8_decode('Selecciona un país'); ?></h1>
						<form action="<?php echo URL.'busqueda'; ?>" method="POST">
						<?php $i = 1; foreach($params['paises'] as $pais) : ?>
							
							


							<div class="radio">
							  <label style="text-transform:uppercase;">
							    <?php if (is_numeric(array_search($pais['nombre'], $n))) : ?>
									<input type="radio" name="id_pais" <?php echo ($i == 1) ? 'required' : ''; ?>  value="<?php echo $pais['id']; ?>" />
								<?php endif; ?>
							    <img width="40" height="40" src="<?php echo URL; ?>assets/upload/<?php echo $pais['img'] ?>" alt="bandera" />
							    <?php echo ucfirst($pais['nombre']); ?>	
							  </label>
							</div>
						<?php $i++; endforeach; ?>
						<button type="submit">
							<i class="fa fa-paper-plane"></i>
							Enviar 
						</button>
						</form>
					</div>
					<!--  -->
				</div>
			</section>	
		</div>


		<div class="login_footer">
			<div class="container">
				Copyright &copy; 2015 ILUMNO. Todos los derechos reservados.				
			</div>
		</div>	

	</body>

</html>


