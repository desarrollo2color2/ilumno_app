<?php 

	namespace App;

	use App\View as view;
	

	Class Controller
	{



		protected static function view()
		{

			
			return new view();
		}


		protected static function url_redirect($url) {

			header("Location: {$url}");
			exit();
		}


		// Funcion general para subir archivos ya sena uno o multiples
		static function __upload_file($path, $file, $multiple = false) {

			// Si es multiple

			if ($multiple):

				if (isset($file["name"]) && ($file["name"] != '')):

					$file_count = count($file['name']);

					for ($i = 0; $i < $file_count; $i++) {

						$name = $file['name'][$i];

						move_uploaded_file($file['tmp_name'][$i], $path . $name);

						$images[] = $name;

					}

					return $images;

				else:

					return null;

				endif;

			// Si es sencillo

			else:

				if (isset($file["name"]) && ($file["name"] != '')):
					$file_name = $file["name"];
					$fileNameTemp = $file["tmp_name"];
					$fileNameNew = $path . basename($file_name);

					if (move_uploaded_file($fileNameTemp, $fileNameNew)):

						return $file_name;

					else:

						return null;

					endif;

				else:

					return null;

				endif;

			endif;

		}
		// Generar la entrada al controlador
		static function create($file, $params = null)
		{
			$url = explode(":", $file);

			if (file_exists(PATH . 'controllers/' . $url[1] . '.php')):


				$name = ucfirst($url[1]).'Controller';
	

				if (method_exists($name, $url[0])):

					return is_null($params) ? $name::{$url[0]}() : $name::{$url[0]}($params);

				else:

					echo 'este metdodo no existe';

				endif;

			else:

				echo 'el controlador no existe no existe <br/>';

			endif;
		}
	}

?>