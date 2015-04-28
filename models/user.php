<?php


	use App\model as Model;


	Class UserModel extends model {



		protected static $table_name = 'usuarios';


		public static function authenticate_user($username="", $password="")
		{	// Método que valida el username y la clave de un usuario
		     // Traer el objeto $db_obj al método
			/*echo "<script language = JavaScript> alert (' 1 Clase user \\n Método authenticate_user(\$usuario = {$username}, clave = {$password}) \\n y pasa al método query_prepary()')</script>";*/

			// Crear un alert para verificar la infomación antes de redirigir al usuario
			/*echo "<script language = JavaScript> alert (' 2 Clase user \\n Método authenticate_user() \\n RETORNOS DE query_prepary \\n \$usuario = {$username} \\n \$clave = {$password}')</script>";*/
			$query = "SELECT * FROM ".static::$table_name." WHERE nombre_usuario = '{$username}' AND pass_usuario = '{$password}'";

			$users_array = static::__query($query);



			if($users_array) :

				$user =  $users_array;

				unset($user[0]['pass_usuario']);
				$_SESSION['user'] = $user[0];

				return $user;

				else :

				return false;

			endif;


		} 	// Fin del método authenticate_user()


		

	}

?>