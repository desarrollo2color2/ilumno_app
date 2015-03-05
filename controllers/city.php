<?php


	use App\Controller  as controller;

	Class CityController extends controller
	{

		public static function all_cities()
		{


			$cities = CityModel::find_by_attr();
			parent::view()->create('admin_cities:admin_layout', $cities);	


		}

		public static function insert_city()
		{

			$is_exist = CityModel::find_by_attr(array('id_pais' => $_POST['id_pais'], 'nombre' => $_POST['nombre']));

   			if($is_exist == false && CityModel::save($_POST)) :

				$_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> al crear el ciudad');
				$url = URL."admin/cities";
				parent::url_redirect($url);
			
			elseif($is_exist) :

				$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> la ciudad ya existe');
				$url = URL."admin/cities";
				parent::url_redirect($url);

			else :

				$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> al crear el ciudad');
				$url = URL."admin/cities";
				parent::url_redirect($url);

			endif;


		}

	
		public static function update_city($array)
		{

			 $city = CityModel::find_by_attr(array('id' => $array['id']));

			 if($city) :
			 	$city = $city[0];
			 	$city['paises'] = CountryModel::find_by_attr();
			 	$city['action'] = URL.'admin/update_by_city';

			 	else :

			 	parent::url_redirect(URL.'admin/city');

			 endif;

			parent::view()->create('admin_city:admin_layout', $city);


		}

		public static function update_by_city ()
		{
			
			if(isset($_POST['id']) && CityModel::update($_POST, ' WHERE id = '.$_POST['id'].' ')) :

				$url = URL."admin/cities";
				parent::url_redirect($url);

			endif;


		}

		public static function get_add_form()
		{
			$countries['paises'] = CountryModel::find_by_attr();
			return parent::view()->create('admin_city:admin_layout', $countries);	

		}

		public static function delete_city()
		{

			if( isset($_POST['id']) &&  CityModel::delete_by_id($_POST['id'])) :
				$_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> ciudad eliminado');
			endif;


		}


}


?>