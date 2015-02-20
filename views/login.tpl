<?php if(isset($_SESSION['user'])) : self::url_redirect(URL.'admin'); endif; ?>

<html lang="<?php echo LANG; ?>">

	<head>
		
		<!-- Title -->
		
		<title><?php self::__title(); ?></title>

		<!-- Metas  -->

		<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
		<meta content="PROKSOL se especializa en proveer servicios de ingeniería, construcción y gerencia de proyectos a entidades públicas y privadas. " name="description">
		<meta name="author" content="Color al cuadrado"/>
		<meta content="construccion" name="keywords">
	

	   	
	   	<!-- Links -->

	   	<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css"/>
		<link href="<?php echo URL; ?>assets/css/colormin.css" rel="stylesheet" type="text/css" />	

		<!-- Scripts -->

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300' rel='stylesheet' type='text/css'>	


	</head>

		
	<body class="login_form">

		<div>
			
			<div>
				
				<form action="<?php echo URL.'login'; ?>" method="POST">
					<h3>Ingresar</h3>
					<div><i class="fa fa-user"></i><input type="text" placeholder="Usuario" name="nombre_usuario" /></div>
					<div><i class="fa fa-lock"></i><input type="password" placeholder="Contraseña" name="pass_usuario" /></div>
					
					<input type="submit" value="Iniciar sesion" />

					<a href="#">Has olvidado tu contraseña</a>

				</form>
			</div>
			
		</div>

	</body>

</html>