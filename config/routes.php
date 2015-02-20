<?php



return array(

	''                       => array('view' => 'home:layout'),
	'404'                    => array('view' => '404:no_layout'),
	'acceso_denegado'        => array('view' => 'perm:layout'),
	'admin'                  => array('view' => 'dashboard:admin_layout', 'perm' => array('admin')),
	// User urls
	'login_form'             => array('view'       => 'login:no_layout'),
	'login'                  => array('controller' => 'login:user'),
	'logout'                 => array('controller' => 'logout:user'),
	'admin/users'            => array('controller' => 'all_users:user', 'perm' => array('admin')),
	'admin/add_user'         => array('view'       => 'admin_user:admin_layout', 'perm' => array('admin')),
	'admin/insert_user'      => array('controller' => 'insert_user:user',    'perm' => array('admin')),
	'admin/update_user/$1'   => array('controller' => 'update_user:user',    'perm' => array('admin')),
	'admin/delete_user'      => array('controller' => 'delete_user:user',    'perm' => array('admin')),
	'admin/update_by_user'   => array('controller' => 'update_by_user:user', 'perm' => array('admin')),
	

);

?>