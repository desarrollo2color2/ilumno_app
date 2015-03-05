<?php 

	use App\Controller  as controller;


	Class SearchController extends controller
	{

		public static function search_form()
		{

			$data['paises'] = CountryModel::find_by_attr();
			
			parent::view()->create('search_form:admin_layout', $data);

		}

	}

?>