<!DOCTYPE html>
<html lang="<?php echo LANG ?>" class="demo-drawings no-js">

	<head>
	
		<!-- Title -->
		
		<title><?php self::__title(); ?></title>

		<!-- Metas  -->

		<meta content="text/html; charset=iso-8859-1" http-equiv="Content-Type">

		
		<meta content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0" name="viewport">
		<meta content="http://cuberto.com/media/images/logo-for-social.png" property="og:image">
		<meta content="all" name="robots">
		<meta content="desarrollo4@coloralcuadrado.com " name="publisher-email">
		<meta content="es_CO" property="og:locale">
		
		<meta content="<?php echo URL; ?>" property="og:url">
		<meta content="NegmaPro" property="og:site_name">
	   	
	   	<!-- Links -->
	   	<link href="<?php echo 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']; ?>" rel="canonical">
	   	<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
	   	<link rel="stylesheet" href="<?php echo URL.'assets/css/color.css'; ?>" type="text/css" />
	   	<link rel="stylesheet" href="<?php echo URL.'assets/css/negma.css'; ?>" type="text/css" />
	   	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	   	<link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"/>
	   	<link href='http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz' rel='stylesheet' type='text/css'>
	   	<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
	   	<link rel="shortcut icon" href="<?php echo URL; ?>assets/img/favicon.ico">
		
		<!-- Scripts -->

		<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
		
		


	 	<!--[if IE]>
			<style>
				#busqueda .busqueda_head form label:after, .java_filter #filtrar_rango .label_::after {
					display:none !important;
				}

				#busqueda .busqueda_head form select {
					border:none;
				}
			

			</style>

		<![endif]-->

	</head>	

	

	<body class="<?php echo (parent::$class != '') ? parent::$class : 'home';  ?>">
	

