<?php


	use App\Controller  as controller;

	Class CurrencyController extends controller
	{

		public static function all_currencies()
		{


			$currencies = CurrencyModel::find_by_attr();
			parent::view()->create('admin_currencies:admin_layout', $currencies);	


		}

		public static function insert_currency()
		{

			$is_exist = CurrencyModel::find_by_attr(array('id_pais' => $_POST['id_pais'], 'nombre' => $_POST['nombre']));

   			if($is_exist == false && CurrencyModel::save($_POST)) :

				$_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> al crear el moneda');
				$url = URL."admin/currencies";
				parent::url_redirect($url);
			
			elseif($is_exist) :

				$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> la moneda ya existe');
				$url = URL."admin/currencies";
				parent::url_redirect($url);

			else :

				$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> al crear el moneda');
				$url = URL."admin/currencies";
				parent::url_redirect($url);

			endif;


		}

	
		public static function update_currency($array)
		{

			 $currency = CurrencyModel::find_by_attr(array('id' => $array['id']));

			 if($currency) :
			 	$currency = $currency[0];
			 	$currency['paises'] = CountryModel::find_by_attr();
			 	$currency['action'] = URL.'admin/update_by_currency';

			 	else :

			 	parent::url_redirect(URL.'admin/currency');

			 endif;

			parent::view()->create('admin_currency:admin_layout', $currency);


		}

		public static function update_by_currency ()
		{
			
			if(isset($_POST['id']) && CurrencyModel::update($_POST, ' WHERE id = '.$_POST['id'].' ')) :

				$url = URL."admin/currencies";
				parent::url_redirect($url);

			endif;


		}

		public static function get_add_form()
		{
			$countries['paises'] = CountryModel::find_by_attr();
			return parent::view()->create('admin_currency:admin_layout', $countries);	

		}

		public static function delete_currency()
		{

			if( isset($_POST['id']) &&  CurrencyModel::delete_by_id($_POST['id'])) :
				$_SESSION['message'] = parent::mensaje('success', '<strong>Exito</strong> moneda eliminado');
			endif;


		}


}


?>