<?php 

	namespace App;

	use App\app as app;

	Class View extends app {
		

			

		//  Verifica que lan esta activa y llama la variable con las traducciones
		static function lang()
		{

			
			return (file_exists(PATH . 'config/lang/' . LANG . '.php')) ?  require_once PATH . 'config/lang/' . LANG . '.php' : 'Este lenguage no existe';

		

		}

		// Quitar tildes 
		static function quitar_tildes($s) 
		{
			$find    = array( "á", "é", "í", "ó", "ú"," ", "ñ" );
      		$replace = array( "a", "e", "i", "o", "u","_", "n" );
      		return str_replace($find, $replace,  $s);
		} 
		// Mensajes
		static function message($type, $content, $ajax)
		{
		
			if($ajax) : 
				echo  '<div class="alert alert-'.$type.'" role="alert">'.$content.'</div>';
			else :
				return  '<div class="alert alert-'.$type.'" role="alert">'.$content.'</div>';
	
			endif;

		}
		//  Titulo
		static function __title() {

			$url = $_SERVER['REQUEST_URI'];
			$url = is_null(LOCAL) ? ltrim ($url, '/') : str_replace(LOCAL, "", $url);
			$array = explode('/', $url);
			$title = array_pop($array);

			if ($url == ''):

				$title = ucwords(SITENAME);

			elseif (is_numeric($title)):

				$count = count($array);

				if ($count > 1):

					$title = ucwords(str_replace('_', ' ', $array[0]) . ' ' . str_replace('_', ' ', $array[1]));

				else:

					$title = ucwords(str_replace('_', ' ', $array[0]));

				endif;

			elseif (!is_numeric($title)):

				$title = ucwords(str_replace('_', ' ', $title));

			endif;

			echo $title;
		}
		//  Url
		static function url($title) {

			// reemplaza cualquier cadena inválida por "-";
			$title = str_replace("&", "and", $title);
			$arrStupid = array('feat.', 'feat', '.com', '(tm)', ' ', '*', "'s", '"', ",", ":", ";", "@", "#", "(", ")", "?", "!", "_",
				"$", "+", "=", "|", "'", '/', "~", "`s", "`", "\\", "^", "[", "]", "{", "}", "<", ">", "%", "&#8482;");

			$title = htmlentities($title);
			$title = preg_replace('/&([a-zA-Z])(.*?);/', '$1', $title);
			$title = strtolower("$title");
			$title = str_replace(".", "", $title);
			$title = str_replace($arrStupid, "_", $title);
			$flag = 1;

			while ($flag) {
				$newtitle = str_replace("--", "-", $title);
				if ($title != $newtitle) {
					$flag = 1;
				} else {
					$flag = 0;
				}

				$title = $newtitle;
			}
			$len = strlen($title);
			if ($title[$len - 1] == "") {
				$title = substr($title, 0, $len - 1);
			}

			return $title;

		}
		static function create($file, $params = null)
		{
		

			$url = explode(":", $file);

			if (file_exists(PATH . 'views/' . $url[0] . '.tpl') && file_exists(PATH . 'views/layouts/' . $url[1] . '.tpl')):

				$content = PATH . 'views/' . $url[0] . '.tpl';

				require_once PATH . 'views/layouts/' . $url[1] . '.tpl';

			elseif (file_exists(PATH . 'views/' . $url[0] . '.tpl') && $url[1] == 'no_layout'):

				require_once PATH . 'views/' . $url[0] . '.tpl';

			elseif (!file_exists(PATH . 'views/' . $url[0] . '.tpl') && !file_exists(PATH . 'views/layouts/' . $url[1] . '.tpl')):

				echo 'La vista no existe <br/>';

			endif;
		}
		 // Funcion que agrega un widget 
		static function add_widget($name, $params = null) {

			if (file_exists(PATH . 'widgets/' . $name . '.tpl')):

				return require_once PATH . 'widgets/' . $name . '.tpl';

			else:

				echo 'el widget no existe <br/>';

			endif;

		}


	}

 ?>