<?php



return array(

	''                       => array(
		'controller'         => 'country_filter:search',
		'perm'               => array('admin', 'registrado')
	),
	'busqueda'               => array(
		'controller'         => 'search_form:search',
		'perm'               => array('admin', 'registrado')
	),
	'404'                    => array('view'       => '404:no_layout'),
	'acceso_denegado'        => array('view'       => 'perm:layout'),
	
	/******************************************************
	                     User urls
	*******************************************************/
	'login_form'      => array('view'       => 'login:no_layout'),
	'login'           => array('controller' => 'login:user'),
	'logout'          => array('controller' => 'logout:user'),
	'admin/users'     => array(
		'controller'  => 'all_users:user',
		'perm'        => array('admin')
	),
	'admin/add_user'  => array(
		'view'        => 'admin_user:admin_layout',
		'perm'        => array('admin')
	),
	'admin/insert_user'  => array(
		'controller'     => 'insert_user:user',
		'perm' => array('admin')
	),
	'admin/update_user/$1' => array(
		'controller'       => 'update_user:user',
		'get_vars'           => array('id'),
		'perm'             => array('admin')
	),
	'admin/delete_user' => array(
		'controller'    => 'delete_user:user',
		'perm'          => array('admin')
	),
	'admin/update_by_user' => array(
		'controller'       => 'update_by_user:user',
		'perm'             => array('admin')
	),
	/******************************************************
	                     Country urls
	*******************************************************/
	'admin/countries'   => array(
		'controller'    => 'all_countries:country',
		'perm'          => array('admin')
	),
	'admin/add_country' => array(
		'view'          => 'admin_country:admin_layout',
		'perm'          => array('admin')
	),
	'admin/insert_country' => array(
		'controller'       => 'insert_country:country',
		'perm'             => array('admin')
	),
	'admin/update_country/$1' => array(
		'controller'          => 'update_country:country',
		'get_vars'            => array('id'),
		'perm'                => array('admin')
	),
	'admin/delete_country'  => array(
		'controller'        => 'delete_country:country',
		'perm'              => array('admin')
	),
	'admin/update_by_country'  => array(
		'controller'           => 'update_by_country:country',
		'perm'                 => array('admin')
	),
	/******************************************************
	                     Currency urls
	*******************************************************/
	'admin/currencies'  => array(
		'controller'    => 'all_currencies:currency',
		'perm'          => array('admin')
	),
	'admin/add_currency' => array(
		'controller'     => 'get_add_form:currency',
		'perm'           => array('admin')
	),
	'admin/insert_currency' => array(
		'controller'        => 'insert_currency:currency',
		'perm'              => array('admin')
	),
	'admin/update_currency/$1' => array(
		'controller'           => 'update_currency:currency',
		'get_vars'             => array('id'),
		'perm'                 => array('admin')
	),
	'admin/delete_currency'    => array(
		'controller'           => 'delete_currency:currency',
		'perm'                 => array('admin')
	),
	'admin/update_by_currency' => array(
		'controller'           => 'update_by_currency:currency',
		'perm' => array('admin')
	),
	/******************************************************
	                     City urls
	*******************************************************/
	'admin/cities'   => array(
		'controller' => 'all_cities:city',
		'perm'       => array('admin')
	),
	'admin/add_city' => array(
		'controller' => 'get_add_form:city',
		'perm'       => array('admin')
	),
	'admin/insert_city' => array(
		'controller'    => 'insert_city:city',
		'perm'          => array('admin')
	),
	'admin/update_city/$1' => array(
		'controller'       => 'update_city:city',
		'get_vars'             => array('id'),
		'perm'             => array('admin')
	),
	'admin/delete_city'   => array(
		'controller'      => 'delete_city:city',
		'perm'            => array('admin')
	),
	'admin/update_by_city' => array(
		'controller'       => 'update_by_city:city',
		'perm'             => array('admin')
	),
	/******************************************************
	                     University urls
	*******************************************************/
	'admin/universities'  => array(
		'controller'      => 'all_universities:university',
		'perm'            => array('admin')
	),
	'admin/add_university' => array(
		'controller'       => 'get_add_form:university',
		'perm'             => array('admin')
	),
	'admin/insert_university'  => array(
		'controller'           => 'insert_university:university',
		'perm'                 => array('admin')
	),
	'admin/update_university/$1' => array(
		'controller'             => 'update_university:university',
		'get_vars'             => array('id'),
		'perm'                   => array('admin')
	),
	'admin/delete_university'    => array(
		'controller'             => 'delete_university:university',
		'perm'                   => array('admin')
	),
	'admin/update_by_university' => array(
		'controller'             => 'update_by_university:university',
		'perm'                   => array('admin')
	),
	'admin/get_ajax_cities_university' => array(
		'controller'                   => 'get_ajax_cities:university',
	),
	'admin/get_ajax_currencies_university' => array(
		'controller'                       => 'get_ajax_currencies:university',
		'perm'                             => array('admin')
	),
	'admin/form_import_university' => array(
		'view'                     => 'admin_import_university:admin_layout',
		'perm'                     => array('admin')
	),
	'admin/import_universidades'  => array(
		'controller'              => 'import:university',
		'perm' => array('admin')
	),
	'admin/import_cities_cobertura' => array(
		'view'                      => 'admin_import_cober:admin_layout',
		'perm'                      => array('admin')
	),
	'import_cobers'  => array(
		'controller' => 'import_cobers:university',
		'perm'       => array('admin')
	),        
	/******************************************************
	                     Search urls
	*******************************************************/
	// 'admin/search'   => array(
	// 	'controller' => 'search_form:search',
	// 	'perm'       => array('admin')
	// ),
	'sedes_ajax'     => array(
		'controller' => 'ajax_sedes_ciudades:search',
	),
	'cobertura_ajax'     => array(
		'controller' => 'cobertura_ajax:search',
	),
	'busqueda_simple'     => array(
		'controller'      => 'ajax_simple_search:search',
	),
	'filtros'            => array(
		'controller'     => 'filtros:search'
	),
	'ordenar'            => array(
		'controller'     => 'order:search'
	),
	/******************************************************
	                     Dashboard urls
	*******************************************************/
	'admin'                  => array(
		'controller'         => 'admin_dashboard:dashboard',
		'perm'               => array('admin')
	),
	'admin/top_pais'         => array(
		'controller'         => 'top_pais:filter',
		'perm'               => array('admin')
	),
	'filter_by_type'         => array(
		'controller'         => 'filter_by_type:filter',
		'perm'               => array('admin')
	),
	
);

?>