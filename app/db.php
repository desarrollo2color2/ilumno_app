<?php

namespace App;

Class Db {

	protected static $table_name;

	function __construct() {
		// Ejecutar el método que abre la conexión con la BD
		$this->__connect();

	}

	public static function __connect() {

		$connect = mysqli_connect(HOST, USER, PASSWORD, DBNAME, 8889) or die("Error " . mysqli_error($connect));

		return $connect;

	}


	public static function __query($query) {

		$db = static::__connect();
		//echo $query;
		$result = $db->query($query);
		
		while ($row = $result->fetch_assoc()) {

			$results[] = $row;

		}

		$db->close();

		return isset($results) ? $results : false;

	}

	//  (los where, los campos a seleccionar, las uniones con sus on, ordenados o group by)
	public static function find_by_attr($array = '', $res = '*', $union = '', $more = '') {

		$query = 'SELECT ' . $res. ' FROM ' . static::$table_name . ' ' . $union;
		$count = count($array);

		$i = 1;

		if(is_array($array)) :

			$query .= '  WHERE ';

			foreach ($array as $k => $v):

				$query .= ($i == $count) ? $k . ' = "' . $v . '" ' : $k . '= "' . $v . '" AND ';

				$i++;

			endforeach;

			$query = rtrim($query, 'AND');
		
		else : 
			$query .= $array;	 

		endif;
		$query .= $more;

		$result = static::__query($query);


		return $result;

	}


	public static function delete_by_id($id) {

		$query = "DELETE FROM " . static::$table_name . " WHERE id =" . $id . " ";

		$db = static::__connect();

		$result = $db->query($query);

		$db->close();

		return $result;

	}


	public static function delete_by_attr($array)
	{
		$query = "DELETE FROM " . static::$table_name. " WHERE ";

		$db = static::__connect();

		$count = count($array);

		$i = 1;

		foreach ($array as $k => $v):

			$query .= ($i == $count) ? $k . ' = "' . $v . '" ' : $k . '= "' . $v . '" AND ';

			$i++;

		endforeach;

		$query = rtrim($query, 'AND');

		// echo $query.'<br/>';

		$result = $db->query($query);

		$db->close();

		return $result;
	}

	private static function get_multi_key($array)
	{

		$np = '';

		foreach($array as $v) :

			$np.= ' '.$v.',';

		endforeach;	

		return $np;

	}

	public static function save($array, $multiple = false) {

		$query = "INSERT INTO " . static::$table_name . "";
		$keys = ' ( ';
		

		if(!$multiple) :
			$values = ' VALUES (';
			foreach ($array as $k => $v):

				if ($v != ''):

					$keys .= ' '.$k . ',';
					$values .= "'" . $v . "',";

				endif;

			endforeach;
			$values = rtrim($values, ',') . ' )';


		else :

			//  El array debe ser  array(0 => array('key1' => $valor, 'key2' => $valor2))
			$values = ' VALUES ';

			$keys .= self::get_multi_key(array_keys($array[0]));

			
			foreach($array as $k => $v) :


					$values .=  ' (';

					foreach($v as $v1) :

						$values .= "'" . $v1 . "',";

					endforeach;

					$values = rtrim($values, ',');

					$values .= ' ), ';

			endforeach;

			$values = rtrim($values, ', ').';';

		endif;	



		$keys =  rtrim($keys, ',') . ' )';
		

		$nd = $query . $keys . $values;

		//echo $nd.'<br/>';


		$db = static::__connect();
		
		$result = $db->query($nd);

		$res = array('result' => $result, 'db' => $db);

		
		return $res;

	}

	public static function update($array, $where = '') {

		$query = "UPDATE " . static::$table_name . " SET  ";
		$values = "";

		foreach ($array as $k => $v):

			if (gettype($v) == 'string'):

				if ($v != ''):

					$values .= $k . "='" . $v . "',";

				endif;

			else:

				if ($v != 0):

					$values .= $k . '=' . $v . ',';

				endif;

			endif;

		endforeach;

		$values = rtrim($values, ',');

		$nd = $query . $values . $where;

		//echo $nd;

		$db = static::__connect();
		
		$result = $db->query($nd);

		$res = array('result' => $result, 'db' => $db);

		$db->close();

		return $res;

	}

}

?>