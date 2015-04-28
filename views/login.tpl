<?php if(isset($_SESSION['user'])) : header("Location: ".URL."admin"); endif; ?>

<html lang="<?php echo LANG; ?>">

	<head>
		
		<!-- Title -->
		
		<title><?php self::__title(); ?></title>

		<!-- Metas  -->


		 
		<!-- <meta content="text/html; charset=iso-8859-1" http-equiv="Content-Type"> -->
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
	   	
	   	<!-- Links -->

	   	<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css"/>
		<link href="<?php echo URL; ?>assets/css/colormin.css" rel="stylesheet" type="text/css" />
		<link rel="shortcut icon" href="<?php echo URL; ?>assets/img/favicon.ico">	
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

		<!-- Scripts -->

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>


	</head>
	

		
	<body class="login_form">

		<div class="login_head">
			<div class="container">
				
			</div>
		</div>


		<div class="login_content">
			<div class="container">
					
					<div class="mensajes"><?php if(isset($_SESSION['message'])) : echo $_SESSION['message']; unset($_SESSION['message']); endif; ?></div>

				<div class="form_content">
					
					<div>
						
						<!-- <img src="<?php echo URL; ?>assets/img/Logo_Ilumno.png" alt="Ilumno logo"> -->


						<form action="<?php echo URL.'login'; ?>" method="POST">
							<h3>Ingresar</h3>
							<div><i class="fa fa-user"></i><input type="text" placeholder="Usuario" name="nombre_usuario" /></div>
							<div><i class="fa fa-lock"></i><input type="password" placeholder="Contrase&ntilde;a" name="pass_usuario" /></div>
							
							<input type="submit" value="Iniciar sesion" />

							<!-- <a href="#">Has olvidado tu contraseña</a> -->

						</form>
					</div>
					
				</div>

			</div>
		</div>

		<div class="login_footer">
			<div class="container">
				Copyright © 2015 ILUMNO. Todos los derechos reservados.				
			</div>
		</div>	

	


	</body>

</html>