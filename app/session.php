<?php

namespace app;

Class Session {

	public $user;
	private $authenticated_user = false;

	function __construct() {
		
		session_start();
		session_cache_limiter('private');
		session_cache_expire(30);
		session_name(SITENAME);
		$this->login_verify(); // verificar_logueo()
	}

	public function login_verify() {

		if (isset($_SESSION["user"])) {
			$this->user = $_SESSION["user"]; // $UserGuid
			$this->authenticated_user = true; // No logueado
		} else {
			unset($this->UserGuid); // $UserGuid
			$this->authenticated_user = false; // No logueado
		}

	}

	public function login_authorized() // esta_logueado()
	{
		// Devuelve la bandera de autenticación
		return $this->authenticated_user; // $logueado
	}

}

?>