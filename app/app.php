<?php

namespace App;

use App\session     as session;
use App\view        as view;
use App\controller  as controller;


Class App {


	public static $session;
	protected static $class;


	//  Obtiene todas las rutas del sitio
	private static function routes() {

		return include PATH . 'config/routes.php';

	}

	static function url_redirect($url) {

		header("Location: {$url}");
		exit();
	}

	static function dump($var)
	{
		echo '<pre>';
			var_dump($var);
		echo '</pre>';
	}

	private static function  if_key_exist($key, $array)
	{

		foreach($array as $k => $v) :

			if($key == $k) :

				return $v;

			endif;

		endforeach;

		return false;

	}

	static function send_mail($to, $content, $subject)
	{
		
		//$to = "mercadeo@bebridge.co";
	    $from = " ".$subject."  <info@mundoilumno.com>";
	    //$subject = "Formulario de capacitacion Be Bridge";

	    //begin of HTML message 
	    $message ="
		<html> 
		  <body> 
		  		".$content."
		    
		  </body>
		</html>";
	   //end of message 
	    $headers  = "From: $from\r\n"; 
	    $headers .= "Content-type: text/html\r\n";

	    mail($to, $subject, $message, $headers); 
	}

	//  funcion interna que recorre la url para obtener las variables por $_GET
	private static function get_vars($array, $array_keys_get) {

		$i = 0;
		
		foreach ($array as $k => $v):

			if($is_exist = self::if_key_exist($i, $array_keys_get)) :
				$new_array[$is_exist] = $v;
			else :

				self::url_redirect(URL.'404');
			endif;

		endforeach;

		return isset($new_array) ? $new_array : null;

	}

	// Funcion que recorre el string la ruta y determina si es controlador  o vista
	static function __content($url, $routes) {

		$url = is_null(LOCAL) ? ltrim ($url, '/') : str_replace(LOCAL, "", $url);

		foreach ($routes as $route => $route_val):

			if (strpos($route, '$1')):

				$route = explode("$1", $route);
				$route = $route[0];

				// if(is_numeric(strpos(trim($url, '1'), $route)) and ($url != $route)) :

				if (strstr($url, substr($url, strlen($route), strlen($url)), true) === $route):

					$url = str_replace($route, '', $url);

					$get_vars = explode("/", $url);

					$array_keys_get = $route_val['get_vars'];


					$get_vars = self::get_vars($get_vars, $array_keys_get);

					$url = $route;

				endif;

			endif;

			if ($url == $route):

				self::$class = $route;

				switch (key($route_val)) {

					case 'view':


						if (isset($route_val['perm']) && $perms = $route_val['perm']):

							foreach ($perms as $perm):

								if (isset($_SESSION['user']) && $_SESSION['user']['tipo'] == $perm):

									return isset($get_vars) ? view::create($route_val['view'], $get_vars) : view::create($route_val['view']);

								endif;

							endforeach;

							return isset($_SESSION['user']) ? self::url_redirect(URL . 'acceso_denegado') : self::url_redirect(URL.'login_form');

						else:

					

							return isset($get_vars) ? view::create($route_val['view'], $get_vars) : view::create($route_val['view']);


						endif;


						break;

					case 'controller':


						if (isset($route_val['perm']) && $perms = $route_val['perm']):

							foreach ($perms as $perm):

								if (isset($_SESSION['user']) && $_SESSION['user']['tipo'] == $perm):

									return isset($get_vars) ? controller::create($route_val['controller'], $get_vars) : controller::create($route_val['controller']);

								endif;

							endforeach;

							return isset($_SESSION['user']) ? (URL . 'acceso_denegado') : self::url_redirect(URL.'login_form');

						else:


							return isset($get_vars) ? controller::create($route_val['controller'], $get_vars) : controller::create($route_val['controller']);

				
							
						endif;

						break;

				}

			endif;

		endforeach;

		return self::url_redirect(URL.'404');;

	}


	static function __init() {

		$url = $_SERVER['REQUEST_URI'];
		
		self::$session = (SESSION)  ? new session : false;
		

		return self::__content($url, self::routes());

	}

}


?>