<?php


	use App\Controller  as controller;

	Class UniversityController extends controller
	{

		public static function all_universities()
		{


			$universities = UniversityModel::find_by_attr();
			return parent::view()->create('admin_universities:admin_layout', $universities);	


		}

		

		public static function insert_university()
		{

			$is_exist = UniversityModel::find_by_attr(array('id_pais' => $_POST['id_pais'], 'nombre' => $_POST['nombre']));

			$data 	  = array_map('parent::get_json_data',$_POST);


   			if($is_exist == false && UniversityModel::save($data)) :

				$_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> al crear el universidad');
				$url = URL."admin/universities";
				return parent::url_redirect($url);
			
			elseif($is_exist) :

				$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> la universidad ya existe');
				$url = URL."admin/universities";
				return parent::url_redirect($url);

			else :

				$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> al crear el universidad');
				$url = URL."admin/universities";
				return parent::url_redirect($url);

			endif;


		}

		public static function update_university($array)
		{

			 $university = UniversityModel::find_by_attr(array('id' => $array['id']));

			 if($university) :
			 	$university = $university[0];
			 	$university = array_map('parent::set_json_data',$university);
			 	
			 	$university['ciudades']        = CityModel::find_by_attr(array('id_pais' => $university['id_pais']));
			 	$university['paises']          = CountryModel::find_by_attr();
			 	$university['nombre_moneda']   = CurrencyModel::find_by_attr(array('id_pais' => $university['id_pais']));
			 	$university['action']   = URL.'admin/update_by_university';

			 	else :

			 	return parent::url_redirect(URL.'admin/university');

			 endif;

			return parent::view()->create('admin_university:admin_layout', $university);


		}

		public static function update_by_university ()
		{
			
			$data 	  = array_map('parent::get_json_data',$_POST);

			if(isset($_POST['id']) && UniversityModel::update($data, ' WHERE id = '.$_POST['id'].' ')) :

				$url = URL."admin/universities";
				return parent::url_redirect($url);

			endif;


		}

		public static function get_ajax_cities()
		{

			if(parent::is_ajax()) :

				foreach(CityModel::find_by_attr(array('id_pais' => $_POST['id'])) as $city) :

					echo '<option value="'.$city['id'].'">'.ucfirst($city['nombre']).'</option>';

				endforeach;

			else :
			
				$url = URL."acceso_denegado";
				return parent::url_redirect($url);

			endif;
		}

		public static function get_ajax_currencies()
		{
			if(parent::is_ajax()) :

				foreach(CurrencyModel::find_by_attr(array('id_pais' => $_POST['id'])) as $currency) :

					echo '<option value="'.$currency['id'].'">'.ucfirst($currency['nombre']).'</option>';

				endforeach;

			else :
			
				$url = URL."acceso_denegado";
				parent::url_redirect($url);

			endif;
		}

		public static function get_add_form()
		{
			$data['paises']   = CountryModel::find_by_attr();
			return parent::view()->create('admin_university:admin_layout', $data);	

		}

		public static function delete_university()
		{

			if( isset($_POST['id']) &&  UniversityModel::delete_by_id($_POST['id'])) :
				$_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> universidad eliminado');
			endif;


		}



		static function order_cities_db($array)
		{
			foreach($array as $v) :

				$new[$v['id']] = $v['nombre'];

			endforeach;

			return $new;
		}


		static function json_data($city, $db_cities)
		{

			$json_array = explode('-', $city);

			foreach($json_array as $json) :

				$nd[] =  array_search($json, $db_cities);

			endforeach;
		
			return $nd;

		}

		static function db_data_cities($array_cities, $db_cities, $id_moneda)
		{

		
			foreach($array_cities as $k => $city) :

				
				$city['ingresos']['moneda'] = $id_moneda;

				if(strpos($city['cobertura']['ciudades'],'-') !== false) :

					$city['cobertura']['ciudades'] = self::json_data($city['cobertura']['ciudades'], $db_cities);

				else :

					$city['cobertura']['ciudades'] = array_search($city['cobertura']['ciudades'], $db_cities);

				endif;


				foreach($city as $k1 => $v) :

					if(is_array($v)) :



						$array_cities[$k][$k1] = json_encode($v,JSON_UNESCAPED_UNICODE);

					else :

						$array_cities[$k][$k1] = $v;

					endif;	

				endforeach;




			endforeach;	

		   	return $array_cities;



		}

		static function convert_cities_values($array)
		{


			if(strpos($array,'-') !== false) :

				return explode('-', $array);

				else :

				return $array;

			endif;	

		}


		private static function simple_array_multi($array)
		{
			$count = count($array);
			$i = 0;
			foreach($array as $v) :

				if(is_array($v)) :

					$new_count = count($array[$i]);


					foreach($v as $v1) :

						 $new_array[$i] = $v1;
						 $i++;

					endforeach;


				else :

					$new_array[$i] = $v;
					$i++;

				endif;


			endforeach;


			return $new_array;

		}

		public static  function import()
		{



			$csv = parent::__upload_file(PATH.'assets/upload/', $_FILES['archivo']);

			if ($csv == null) :
				
				$url = URL."admin";
				return parent::url_redirect($url);

			endif;

	

			$keys = array(

				0 => 'id_pais',
				1 => 'nombre',
				2 => 'ciudad',
				3 => 'rector',
				4 => 'presidente',
				5 => 'telefono',
				6 => 'email',
				7 => 'direccion',
				8 => 'tipo',
				9  => array('acreditaciones' => 'nacionales'),
				10 => array('acreditaciones' => 'intrenacionales'),
				11 => array('cobertura'      => 'num_sedes'),
				12 => array('cobertura'      => 'ciudades'),
				13 => array('modalidad'      => 'presencial'),
				14 => array('modalidad'      => 'virtual'),
				15 => array('modalidad'      => 'distancia'),
				16 => array('poblacion'      => 'total'),
				17 => array('poblacion'      => 'posgrado'),
				18 => array('poblacion'      => 'pregrado'),
				19 => array('poblacion_primer_ingreso'      => 'postgrado'),
				20 => array('poblacion_primer_ingreso'      => 'pregrado'),
				21 => array('desercion'  => 'acumulada'),
				22 => array('desercion'  => 'por_periodo'),
				23 => array('personal'   => 'docentes'),
				24 => array('personal'   => 'adtivos'),
				25 => array('ingresos'   => 'moneda'),
				26 => array('ingresos'   => 'matricula_posgrado'),
				27 => array('ingresos'   => 'matricula_pregrado'),
				28 => array('ingresos'   => 'total_ingresos'),
				29 => 'observaciones',


			);


		   $array = parent::import_csv(PATH.'assets/upload/'.$csv);
			
	

		   foreach($array as $k => $v) :
		   	

		   		foreach($v as $k1 => $v1) :

			   			if(is_array($keys[$k1]))  :

			   				$sub_key = key($keys[$k1]);

			   				if($keys[$k1][$sub_key] == 'ciudades') :

			   					$ciudades[$k] = $v1;

			   				endif;	

			   				$new_array[$k][$sub_key][$keys[$k1][$sub_key]] =  $v1;

			   			else :
			   				$new_array[$k][$keys[$k1]] = $v1;

				   		endif;
			   		

		   		endforeach;	
		   		
		   endforeach;

		  // Encuentra los valores unicos - despues converito los que tengan - 
		   $insert_cities = array_unique(
		   self::simple_array_multi(array_map('self::convert_cities_values', array_unique($ciudades))));


		   // Organizando array para insertar

		   	$i = 0;
		 	foreach($insert_cities as $r) :

		    	$insert[$i]['id_pais'] = $new_array[0]['id_pais'];
		    	$insert[$i]['nombre'] = $r;


		   		$i++;
		    endforeach;

		    // Inserto las ciudades y moneda

		   CityModel::save($insert, true);
		   $moneda = CurrencyModel::save(array('id_pais' => $new_array[0]['id_pais'], 'nombre' => $new_array[0]['ingresos']['moneda']));
		   $id_moneda = $moneda['db']->insert_id;

		    //  Obtengo las ciudades agregadas
			$db_cities = CityModel::find_by_attr(array('id_pais' => $new_array[0]['id_pais']));
			$db_cities = self::order_cities_db($db_cities);
		    $new_array  = self::db_data_cities($new_array, $db_cities, $id_moneda);


		    UniversityModel::save($new_array, true);

		    $_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> se importaron las universidades');

		    $url = URL."admin";
			return parent::url_redirect($url);



		}


}


?>