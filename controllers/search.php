<?php 

	use App\Controller  as controller;


	Class SearchController extends controller
	{

		


		public static function get_total_register()
		{
			return UniversityModel::find_by_attr('', 'COUNT(*) as total');
		}

		public static function search_form()
		{

			$total          = self::get_total_register();
			$data['total'] = $total[0]['total'];

			

			if(empty($_POST)) : 
				$data['paises']    = CountryModel::find_by_attr('', '*', '', 'ORDER BY nombre ASC');
				return parent::view()->create('search_form:layout', null); 
			endif;

			$data['paises']    = CountryModel::find_by_attr('', '*', '', 'ORDER BY nombre ASC');
			
			$_SESSION['busqueda'] = UniversityModel::find_by_attr(array('id_pais' => $_POST['id_pais']));

			$data['monedas']   = self::simple_cities(CurrencyModel::find_by_attr());
			$data['cities']    = self::simple_cities(CityModel::find_by_attr());

			


			return parent::view()->create('search_form:layout', $data);

		}

		public static function country_filter()
		{

			

			$data['paises']    = CountryModel::find_by_attr('', '*', '', 'ORDER BY nombre ASC');
			return parent::view()->create('paises:no_layout', $data);
		}


		private static function simple_cities($array)
		{

			if($array):
				foreach(@$array as $v) :

					$new_array[$v['id']] = $v['nombre'];

				endforeach;
		


			return @$new_array;
			endif;

		}
		//  Traer las ciudades de sedes principales x ajax
		public static function ajax_sedes_ciudades()
		{
			if(parent::is_ajax()) :

				header('Content-Type: text/html; charset=ISO-8859-15');

				foreach(UniversityModel::find_by_attr(array('id_pais' => $_POST['id']), 'DISTINCT ciudad', '',  'ORDER BY ciudad ASC') as $city) :

					echo '<option value="'.$city['ciudad'].'">'.strtoupper($city['ciudad']).'</option>';

				endforeach;

			else :
			
				$url = URL."acceso_denegado";
				return parent::url_redirect($url);

			endif;
		}
		// Traer las ciudades de cobertura x ajax 
		public static function cobertura_ajax()
		{

			if(parent::is_ajax()) :

				header('Content-Type: text/html; charset=ISO-8859-15');

				foreach(CityModel::find_by_attr(array('id_pais' => $_POST['id']), '*', '', 'ORDER BY nombre ASC') as $city) :

					echo '<div class="checkbox">
						<label for="">
							<input type="checkbox" name="cobertura[]" value="'.$city['id'].'"> '.strtoupper($city['nombre']).'
						</label>
					</div>';

				endforeach;

			else :
			
				$url = URL."acceso_denegado";
				return parent::url_redirect($url);

			endif;
		}


		private static function empty_ajax_field($array)
		{

			foreach($array as $k => $v) :
				if(!empty($v)) :
					$new[$k] = $v;
				endif;
			endforeach;

			return $new;

		}

		//  Funcion para saber que datos filtar

		private static function comparaciones($array)
		{

			$i = 1;
			foreach($array as $k => $v) :

				if(is_array($v)) :

		
					foreach($v as $k2 => $v2) :
						//  En caso de ser selector en array json
						if($v2 != '' && is_string($v2)) :
							$new_array[$i]['operador'] = '=';
							$new_array[$i][$k][$k2] =   $v2;
							$i++;
						//  En caso de ser array json por rango
						elseif((isset($v2['desde']) && $v2['desde'] != '' ) && ( isset($v2['hasta']) && $v2['hasta'] != '' )) :
							
							$new_array[$i]['operador'] = '=';
							$new_array[$i][$k][$k2] =   $v2;
							$i++;


						endif;

					endforeach;

					

				else :

					if($v != '') :

						$new_array[$i]['operador'] =  '=';
						$new_array[$i][$k]         =   $v;
						$i++;
					endif;

				endif;

				
			endforeach;

			
			return isset($new_array) ? $new_array : null;
	

		}
		//  Funcion para traer tipo de filtro
		private static function filter_type($array)
		{
			foreach($array as $k => $v) :
				if($k != 'operador') :
					return $k;
				endif;
			endforeach;
		}

		private static function quitar_tildes($cadena) 
		{
			$no_permitidas= array ("á","é","í","ó","ú","Á","É","Í","Ó","Ú","ñ","À","Ã","Ì","Ò","Ù","Ã™","Ã ","Ã¨","Ã¬","Ã²","Ã¹","ç","Ç","Ã¢","ê","Ã®","Ã´","Ã»","Ã‚","ÃŠ","ÃŽ","Ã”","Ã›","ü","Ã¶","Ã–","Ã¯","Ã¤","«","Ò","Ã","Ã„","Ã‹");
			$permitidas= array ("a","e","i","o","u","A","E","I","O","U","n","N","A","E","I","O","U","a","e","i","o","u","c","C","a","e","i","o","u","A","E","I","O","U","u","o","O","i","a","e","U","I","A","E");
			$texto = str_replace($no_permitidas, $permitidas ,$cadena);
			return $texto;
		}



		private static function is_aviable($comparaciones, $value)
		{
			
			@$data = array_map('parent::set_json_data',$value);
			

			//parent::dump($value);



			foreach($comparaciones as $compa) :

				$filter_type = self::filter_type($compa);

				if(is_array($compa[$filter_type])) :

						//  Comparacion por rangos json
						if(isset($compa[$filter_type][self::filter_type($compa[$filter_type])]['desde'])) : 
						
							$desde = $compa[$filter_type][self::filter_type($compa[$filter_type])]['desde'];
							$hasta = $compa[$filter_type][self::filter_type($compa[$filter_type])]['hasta'];

							$val   = $data[$filter_type][self::filter_type($compa[$filter_type])];
							$val   = str_replace(' ', '', str_replace('.', '', $val));


							

							if($val == '-') :

								return false;

							endif;

							$cal = (int)$desde <= (int)$val && (int)$val < (int)$hasta;

							if(!$cal) :
								return false;
							endif;
						
						//  Comparacion por valores
						else :

							if (@$data[$filter_type][self::filter_type($compa[$filter_type])] != @$compa[$filter_type][self::filter_type($compa[$filter_type])] ):  
								
								return false;

							endif;

						endif;

					

					else :
					// sino es array
					
					// echo '<pre>';
					// 	var_dump(strtoupper($compa[$filter_type]));
					// 	var_dump(strtoupper($data[$filter_type]));
					// 	if(strpos(strtolower(self::quitar_tildes($data[$filter_type])), strtolower(self::quitar_tildes($compa[$filter_type]))) !== false) :
					// 		echo 'aaaa';
					// 	endif;
					
					// echo '</pre>';

					if(strpos(strtolower(self::quitar_tildes($data[$filter_type])), strtolower(self::quitar_tildes($compa[$filter_type]))) === false) :
						 return false;
					endif;

				endif;



			endforeach;

			return true;

		}

		public static function filtros()
		{

			if(parent::is_ajax()) :

					header('Content-Type: text/html; charset=ISO-8859-15');

					$comparaciones = self::comparaciones($_POST);


					
					//  recorrer array consulta general
					foreach($_SESSION['busqueda'] as $k => $v) :

						if(is_null($comparaciones)) :

							$new_array[$k] = $v;

						else :


							if(self::is_aviable($comparaciones, $v)) :

								$new_array[$k] = $v;

							endif;
						

						endif;

				

					endforeach;

					


					@$data = $new_array;
					$_SESSION['ordernar'] = $data;
					$data['monedas']   = self::simple_cities(CurrencyModel::find_by_attr());
					$data['cities']    = self::simple_cities(CityModel::find_by_attr());
					$total             = self::get_total_register();
					$data['total'] = $total[0]['total'];



					return parent::view()->create('filtro:no_layout', $data);

			else :
			
				$url = URL."acceso_denegado";
				return parent::url_redirect($url);

			endif;
			

		}



		public static function ajax_simple_search()
		{

		  if(parent::is_ajax()) :

				header('Content-Type: text/html; charset=ISO-8859-15');

				if(isset($_POST['cobertura']) && $_POST['cobertura'] != '') :

					$cobertura = $_POST['cobertura'];
					unset($_POST['cobertura']);
				else :

					$cobertura = false; 

				endif;

				

				$_POST['id_pais'] = utf8_decode($_POST['id_pais']);
				
				if (isset($_POST['ciudad']))  :
					$_POST['ciudad']  = utf8_decode($_POST['ciudad'] );
				endif;


				if(!$cobertura) :

					if($data = UniversityModel::find_by_attr(self::empty_ajax_field($_POST))) :

						
						$_SESSION['busqueda'] = $data;
						$data['monedas']   = self::simple_cities(CurrencyModel::find_by_attr());
						$data['cities']      = self::simple_cities(CityModel::find_by_attr(array('id_pais' => $_POST['id_pais'])));
						$total          = self::get_total_register();
						$data['total'] = $total[0]['total'];

						return parent::view()->create('simple_search_results:no_layout', $data);

					else :

						echo '<div class="alert alert-danger" role="alert">Sin resultados</div>';
					endif;


					// else si hay ciudades de cobertura
					else :
						
						if($data = UniversityModel::find_by_attr(self::empty_ajax_field($_POST))) :
	
							// $cities  = CityModel::find_by_attr(array('id_pais' => $_POST['id_pais']));
							$_SESSION['busqueda']    = self::cobertura_array($data, $cobertura);
							$new_data                = $_SESSION['busqueda'];
							$new_data['monedas']     = self::simple_cities(CurrencyModel::find_by_attr());
							$new_data['cities']      = self::simple_cities(CityModel::find_by_attr(array('id_pais' => $_POST['id_pais'])));
							$total          = self::get_total_register();
							$new_data['total'] = $total[0]['total'];

							return parent::view()->create('simple_search_results:no_layout', $new_data);

						else :
							echo '<div class="alert alert-danger" role="alert">Sin resultados</div>';	
						
						endif;


				endif;

			else :
			
				$url = URL."acceso_denegado";
				return parent::url_redirect($url);

			endif;
		}

		private static function cobertura_array($array, $cities)
		{

			foreach($array as $k => $v) :

				if(self::is_cobertura(array_map('parent::set_json_data', $v), $cities)) :

					$new_array[$k] = $v;

				endif;

			endforeach;

			

			return (isset($new_array)== false) ? null : $new_array;

		}

		private static function is_cobertura($array, $cities)
		{
			
			$current_cities = $array['cobertura']['ciudades'];

	
			
			$i = 1;

			if(is_array($current_cities)) :

				foreach($cities as $city) :

					if(is_numeric(array_search((int)$city, $current_cities))) :
						
						return true;

					endif;

			
				endforeach;

				return false;

			else :


				if(is_numeric(array_search((int)$current_cities, $cities))) :
						// echo 'aaaaa';
						return true;

				endif;

				return false;

			endif;


		}


		private static function filter_by($array, $campo)
		{

			foreach($array as $k =>  $v):
			
				if($campo == 'nombre') :
					$new_array[$k] = $v['nombre'];
				else :
					$campos = explode(':', $campo);
					$new_array[$k] = number_format((int) str_replace('.', '', $v[$campos[0]][$campos[1]]));
				endif;
			endforeach;

			

			return $new_array;

		}


		private static function conver_int($array)
		{

			return (int) str_replace(',', '', $array);

		}


		public static function order()
		{


			if(isset($_SESSION['ordernar'])) :
				// $data = self::ordernar_array($_POST['por'], $_POST['campo']);
				
					header('Content-Type: text/html; charset=ISO-8859-15');

					foreach($_SESSION['ordernar'] as $k =>  $d) :
						@$data[$k] = array_map('parent::set_json_data',$d);
					endforeach;

					$new_data = self::filter_by($data, $_POST['campo']);
					
					// de mayor a menor descenditente

					if($_POST['campo'] == 'nombre') :

						if($_POST['por'] == 'DSC') :

							arsort($new_data, SORT_STRING);
							$new_data = array_reverse($new_data, true);

						else :
							arsort($new_data, SORT_STRING);
						endif;

					else :
						
						$new_data = array_map('self::conver_int',$new_data);

						if($_POST['por'] == 'DSC') :

							arsort($new_data, SORT_NUMERIC);
							$new_data = array_reverse($new_data, true);

						else :
							arsort($new_data, SORT_NUMERIC);
							
						endif;

					endif;

					

					 foreach($new_data as $k => $v) :
					 	$final_data[$k] = $_SESSION['ordernar'][$k];
					 
				 	 endforeach;

				 	

				 	$final_data['monedas']   = self::simple_cities(CurrencyModel::find_by_attr());
					$final_data['cities']    = self::simple_cities(CityModel::find_by_attr());
					$final_total             = self::get_total_register();
					$final_data['total']     = $final_total[0]['total'];

					$final_data['ordernar_por']   = $_POST['por'];
					$final_data['ordernar_campo'] = $_POST['campo'];


					//unset($_SESSION['ordernar']);


					return parent::view()->create('filtro:no_layout', $final_data);
				
			else :

				header('Content-Type: text/html; charset=ISO-8859-15');

				foreach($_SESSION['busqueda'] as $k =>  $d) :
						@$data[$k] = array_map('parent::set_json_data',$d);
					endforeach;

					$new_data = self::filter_by($data, $_POST['campo']);
					
					// de mayor a menor descenditente

					if($_POST['campo'] == 'nombre') :

						if($_POST['por'] == 'DSC') :

							arsort($new_data, SORT_STRING);
							$new_data = array_reverse($new_data, true);

						else :
							arsort($new_data, SORT_STRING);
						endif;

					else :
						
						$new_data = array_map('self::conver_int',$new_data);
						if($_POST['por'] == 'DSC') :

							arsort($new_data, SORT_NUMERIC);
							$new_data = array_reverse($new_data, true);

						else :
							arsort($new_data, SORT_NUMERIC);
							
						endif;

					endif;

					

					 foreach($new_data as $k => $v) :
					 	$final_data[$k] = $_SESSION['busqueda'][$k];
					 
				 	 endforeach;

				 	

				 	$final_data['monedas']   = self::simple_cities(CurrencyModel::find_by_attr());
					$final_data['cities']    = self::simple_cities(CityModel::find_by_attr());
					$final_total             = self::get_total_register();
					$final_data['total']     = $final_total[0]['total'];

					$final_data['ordernar_por']   = $_POST['por'];
					$final_data['ordernar_campo'] = $_POST['campo'];


					return parent::view()->create('filtro:no_layout', $final_data);


			endif;

			

		}

	}

?>