<?php

require_once __DIR__ . '/vendor/autoload.php';
use App\app as app;

if(ERROR) :

	ini_set('display_errors', true);
	error_reporting(E_ALL);

endif;


app::__init();

?>






