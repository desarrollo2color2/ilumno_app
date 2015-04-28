<?php 

	namespace App;

	use App\view as view;

	use App\app as app;

	Class Controller extends app
	{


		protected static function view()
		{

			return new view();
		}

		public static function mensaje($type, $content)
		{

			return self::view()->message($type, $content, $ajax = self::is_ajax());

		}

		// Convertir un arreglo normal en json para insertar
		protected static function get_json_data($array)
		{
			if(is_array($array)) :
				return json_encode($array, JSON_UNESCAPED_UNICODE);
			else :
				return $array;
			endif;
		}

		// Convertir un arreglo json en noraml para mostar
		protected static function set_json_data($array)
		{

		
			if(is_object(json_decode($array))) :
				


				return json_decode($array, true);
			else :
				return $array;
			endif;
		}

		protected static function is_ajax()
		{

			if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') :
				
				return true;

			else :		
					return false;
			endif;

		}

		
		//  Import csv
		static function import_csv($path_file)
		{
			$row = 0;
			if (($handle = fopen($path_file, "r")) !== FALSE) {

			    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			        $num = count($data);



			        foreach($data as $k => $v) :

			      //   	echo '<pre>';

					   	// var_dump($v);

					  	 // echo '</pre>';
			        	$values[$row] = explode(';', $v);

			        	// if($row == 0) :


				        // 	$new_array[$row][$k] = $v;


			        	// else :

			        	// 	$new_array[$row][$new_array[0][$k]] = $v;

			        	// endif;

		        	endforeach;

			        $row++;
			    }
			    fclose($handle);
			    // unset($new_array[0]);
			    
		   
			     return $values;

			}


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