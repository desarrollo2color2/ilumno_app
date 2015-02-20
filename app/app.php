<?php

namespace App;

use App\Session     as session;
use App\View        as view;
use App\Controller  as controller;


Class App {


	public static $session;



	//  Obtiene todas las rutas del sitio
	private static function routes() {

		return include PATH . 'config/routes.php';

	}

	static function url_redirect($url) {

		header("Location: {$url}");
		exit();
	}

	//  funcion interna que recorre la url para obtener las variables por $_GET
	private static function get_vars($array) {

		$i = 1;

		foreach ($array as $k => $v):

			if ($i % 2 == 0):

				$new_array[$array[$k - 1]] = $array[$k];

			endif;

			$i++;

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

					$get_vars = self::get_vars($get_vars);

					$url = $route;

				endif;

			endif;

			if ($url == $route):

				switch (key($route_val)) {

					case 'view':

						$perms = next($route_val);

						if ($perms):

							foreach ($perms as $perm):

								if (isset($_SESSION['user']) && $_SESSION['user']['tipo'] == $perm):

									return isset($get_vars) ? view::create($route_val['view'], $get_vars) : view::create($route_val['view']);

								endif;

							endforeach;

							return isset($_SESSION['user']) ? self::url_redirect(URL . 'perm') : self::url_redirect(URL);

						else:

							return isset($get_vars) ? view::create($route_val['view'], $get_vars) : view::create($route_val['view']);

						endif;

					

						break;

					case 'controller':

						$perms = next($route_val);

						if ($perms):

							foreach ($perms as $perm):

								if (isset($_SESSION['user']) && $_SESSION['user']['tipo'] == $perm):

									return isset($get_vars) ? controller::create($route_val['controller'], $get_vars) : controller::create($route_val['controller']);

								endif;

							endforeach;

							return isset($_SESSION['user']) ? (URL . 'perm') : self::url_redirect(URL);

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