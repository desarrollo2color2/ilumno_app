<?php


	use App\Controller  as controller;

	Class CountryController extends controller
	{

		public static function all_countries()
		{



			$countries = CountryModel::find_by_attr();
			parent::view()->create('admin_countries:admin_layout', $countries);	


		}

		public static function insert_country()
		{

			$is_exist = CountryModel::find_by_attr(array('nombre' => $_POST['nombre']));

			$img = ($is_exist  == false) ? parent::__upload_file(PATH.'assets/upload/', $_FILES['img']) : null;
			if ($img != null): $_POST['img'] = $img;  endif;

   			if($is_exist  == false && CountryModel::save($_POST) ) :

				$_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> al crear el pais');
				$url = URL."admin/countries";
				parent::url_redirect($url);

			elseif($is_exist) :

				$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> el pais ya existe');
				$url = URL."admin/countries";
				parent::url_redirect($url);

			else :

				$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> al crear el pais');
				$url = URL."admin/countries";
				parent::url_redirect($url);

			endif;


		}


		public static function update_country($array)
		{

			 $country = CountryModel::find_by_attr(array('id' => $array['id']));

			 if($country) :
			 	$country = $country[0];
			 	$country['action'] = URL.'admin/update_by_country';

			 	else :

			 	parent::url_redirect(URL.'admin/country');

			 endif;

			parent::view()->create('admin_country:admin_layout', $country);


		}

		public static function update_by_country ()
		{
			
			if (!isset($_POST['img'])):
				$img = parent::__upload_file(PATH.'assets/upload/', $_FILES['img']);
				if ($img != null): $_POST['img'] = $img; endif;
			endif;


			if(isset($_POST['id']) && CountryModel::update($_POST, ' WHERE id = '.$_POST['id'].' ')) :

				$url = URL."admin/countries";
				parent::url_redirect($url);

			endif;


		}

		public static function delete_country()
		{

			if( isset($_POST['id']) &&  CountryModel::delete_by_id($_POST['id'])) :
				$_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> pais eliminado');
			endif;


		}


}


?>