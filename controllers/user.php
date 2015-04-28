<?php


	use App\Controller  as controller;
	
	
	Class UserController extends controller
	{


	public static function logout()
	{
		session_destroy();
		parent::url_redirect(URL);
	}


	public static function login()
	{

		$login = UserModel::authenticate_user($_POST['nombre_usuario'],sha1(md5($_POST['pass_usuario'])));

		if($login == false) :

			
			$_SESSION['message'] = parent::mensaje('danger', '<strong>Error</strong> datos erroneos');
			parent::url_redirect(URL.'login_form');

			else :
			
				return ($_SESSION['user']['tipo'] == 'admin') ? parent::url_redirect(URL.'admin') : parent::url_redirect(URL);

		endif;


	}


	public static function all_users()
	{

		$users = UserModel::find_by_attr();
		parent::view()->create('admin_users:admin_layout', $users);	


	}

	public static function insert_user()
	{

		$_POST['pass_usuario'] = sha1(md5($_POST['pass_usuario']));

		if(UserModel::save($_POST)) :

			$_SESSION['message'] = '<div class="alert alert-success" role="alert">Usuario creado</div>';
			$url = URL."admin";
			parent::url_redirect($url);

		else :

			$_SESSION['message'] = '<div class="alert alert-danger" role="alert">No ce puedo crear el usuario</div>';
			$url = URL."admin";
			parent::url_redirect($url);

		endif;


	}

	private static function  random($length = 8) {

	    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	    $charactersLength = strlen($characters);
	    $randomString = '';

	    for ($i = 0; $i < $length; $i++) {
	        $randomString .= $characters[rand(0, $charactersLength - 1)];
	    }

	    return $randomString;
	}

	public static function forgot(){

		if(isset($_POST)) :

			$user = UserModel::find_by_attr(array('email' => $_POST['email']));

			if($user) :

				$email        = $user[0]['email'];
				$new_password = self::random();



				UserModel::update(array('pass_usuario' => sha1(md5($new_password))), 'WHERE email="'.$email.'" ');

				$_SESSION['message'] = '<div class="alert alert-success" role="alert">Contraseña actualizadada '.$new_password.'</div>';
				parent::url_redirect(URL);


			else :
			$_SESSION['message'] = '<div class="alert alert-danger" role="alert">Este correo no esta registrado</div>';
			parent::url_redirect(URL);

			endif;

		endif;
	}

	public static function update_user($array)
	{

		 $user = UserModel::find_by_attr(array('id' => $array['id']));

		 if($user) :
		 	$user = $user[0];
		 	$user['action'] = URL.'admin/update_by_user';

		 	else :

		 	parent::url_redirect(URL.'admin/user');

		 endif;

		parent::view()->create('admin_user:admin_layout', $user);


	}

	public static function update_by_user ()
	{
		if(isset($_POST['pass_usuario']) && $_POST['pass_usuario'] != '') :

			$_POST['pass_usuario'] = sha1(md5($_POST['pass_usuario']));


			else :

			unset($_POST['pass_usuario']);

		endif;

		if(isset($_POST['id']) && UserModel::update($_POST, ' WHERE id = '.$_POST['id'].' ')) :

			$url = URL."admin/users";
			parent::url_redirect($url);

		endif;


	}

	public static function delete_user()
	{

		if( isset($_POST['id']) &&  UserModel::delete_by_id($_POST['id'])) :
			echo 'Usuario eliminado';
		endif;


	}


}


?>