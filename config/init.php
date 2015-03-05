<?php

/*
|--------------------------------------------------------------------------
| Configuracion General
|--------------------------------------------------------------------------
|
|
 */


define('URL', 'http://192.168.1.126:8888/ilumno_app/');
define('PATH', $_SERVER['DOCUMENT_ROOT'] . '/ilumno_app/');
// LOCAL variable que define si el sitio esta local o en linea, si esta en linea el valor debe ser null sino debe ser /sitio/
define('LOCAL', '/ilumno_app/');
define('SITENAME', '.::ILUMNO APP::.');
define('ERROR', true);
define('DBNAME', 'ilumno_app');
define('HOST', 'localhost');
define('USER', 'root');
define('PASSWORD', 'root');
define('SESSION', true);
define('LANG', 'es');

?>