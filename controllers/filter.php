<?php 


	use App\Controller  as controller;


	Class FilterController extends controller
	{


		public static $tipo_pais = array(

			array(
				'before'      => '(',      
				'key'         => 'universidades.tier',
				'value'       =>  '4',
				'condicional' => '=',
				'operador'    => 'OR '
			),
			array(
				'key'         => 'universidades.tier',
				'value'       =>  '3',
				'condicional' => '=',
				'operador'    => ' ',
				'after'      => ')'	
			)
		);


		public static function top_pais()
		{


			unset($_SESSION['filters']);

			$uni = UniversityModel::find_by_attr(
			self::$tipo_pais,
			'paises.nombre as nombre_pais, universidades.*',
			'INNER JOIN paises ON paises.id = universidades.id_pais',
			'ORDER BY paises.nombre, universidades.tier, universidades.nombre '
			);



			foreach ($uni as $k => $v) :
				$new_data[] = array_map('parent::set_json_data',$v);
			endforeach;


			return parent::view()->create('type_pais:admin_layout', $new_data);



		}


		private static function json_filters($post)
		{
			foreach($_SESSION['filters']['json'] as $k1 => $v1) :
				if ($v1['field'] ==  $post['field']) :
					unset($_SESSION['filters']['json'][$k1]);
				endif;	
			endforeach;


			if (is_array($_SESSION['filters']['json'])) :
				$new_post[] = $post ;
				$_SESSION['filters']['json'] = array_merge($_SESSION['filters']['json'], $new_post);
			else :

				$_SESSION['filters']['json'][0] = $post;

			endif;	
			  
		}

		public static function filter_by_type()
		{



			// Si hay mas filtros aplicados
			if(isset($_SESSION['filters'])) :


				// si es un campo a buscar es json
				if(strpos($_POST['field'], ':')) :


					$uni = UniversityModel::find_by_attr(
							$_SESSION['filters']['query'],
							'paises.nombre as nombre_pais, universidades.*',
							'INNER JOIN paises ON paises.id = universidades.id_pais',
							self::get_order_data_simple($_POST['data_form'])
						);

					if($uni) :
						foreach ($uni as $k => $v) :
							$new_data[] = array_map('parent::set_json_data',$v);
						endforeach;
					endif;



					if($_SESSION['filters']['json'] == false) :


						$_SESSION['filters']['json'][0]  = $_POST;

						
						$data = self::get_filter_json_simple($new_data, $_POST);


						self::print_filter($data, $_POST['data_form']);



						else : 
							
							// si es el mismo filtro
							self::json_filters($_POST);
							

							
							$i    = 1; 

							

							foreach($_SESSION['filters']['json'] as $k => $v) :
								
								

								if($i == 1) :
									$data[$i] = self::get_filter_json_simple($new_data, $v);
								else :

									$data[$i] = self::get_filter_json_simple($data[$i-1], $v);
								
								endif;	
								
								

							$i++;	
							endforeach;	

							$new_data = $data[count($data)];


							self::print_filter($new_data, $_POST['data_form']);
							// $data  = self::	

					endif;



				// Si el campo a buscar es un dato normal en la bd 	
				else :
				
					$get_ = self::get_filter_data_simple($_POST);



					
					$uni = UniversityModel::find_by_attr(
						self::construct_query_multiple($_SESSION['filters']['query'], $get_, $_POST),
						'paises.nombre as nombre_pais, universidades.*',
						'INNER JOIN paises ON paises.id = universidades.id_pais',
						self::get_order_data_simple($_POST['data_form'])
					);

					if($uni) :
						foreach ($uni as $k => $v) :
							$new_data[] = array_map('parent::set_json_data',$v);
						endforeach;
					endif;

					$_SESSION['filters']['query'] = self::construct_query_multiple($_SESSION['filters']['query'], $get_, $_POST);


					// parent::dump($new_data);


					if($_SESSION['filters']['json']) :

						$i  = 1; 

						// parent::dump($_SESSION['filters']['json']);

						foreach($_SESSION['filters']['json'] as $k => $v) :
								
							

							if($i == 1) :
								$data[$i] = self::get_filter_json_simple($new_data, $v);
							else :

								$data[$i] = self::get_filter_json_simple($data[$i-1], $v);
							
							endif;	
							
							

						$i++;	
						endforeach;	

						// parent::dump(count($data));

						$new_data = $data[count($data)];



					endif;


					self::print_filter($new_data, $_POST['data_form']);


				endif;	





			// Si el el primer filtro
			else :
				// si es un campo a buscar es json
				if(strpos($_POST['field'], ':')) :
				

					$_SESSION['filters']['query'] = self::$tipo_pais;

					$_SESSION['filters']['json'][0]  = $_POST;


					$uni = UniversityModel::find_by_attr(
						self::$tipo_pais,
						'paises.nombre as nombre_pais, universidades.*',
						'INNER JOIN paises ON paises.id = universidades.id_pais',
						self::get_order_data_simple($_POST['data_form'])
					);

					if($uni) :
						foreach ($uni as $k => $v) :
							$new_data[] = array_map('parent::set_json_data',$v);
						endforeach;
					endif;



					$data = self::get_filter_json_simple($new_data, $_POST);


					self::print_filter($data, $_POST['data_form']);


				 // Si el campo a buscar es un dato normal en la bd 
				else :
					
					$get_ = self::construct_query(self::get_filter_data_simple($_POST), $_POST);



					$uni = UniversityModel::find_by_attr(
						$get_,
						'paises.nombre as nombre_pais, universidades.*',
						'INNER JOIN paises ON paises.id = universidades.id_pais',
						self::get_order_data_simple($_POST['data_form'])
					);

					$_SESSION['filters']['query'] = $get_;
					$_SESSION['filters']['json']  = false;

					if($uni) :
						foreach ($uni as $k => $v) :
							$new_data[] = array_map('parent::set_json_data',$v);
						endforeach;
					endif;

					self::print_filter($new_data, $_POST['data_form']);
				

				endif;	
				

			endif;

			
			

		}


		

		
		private static function multi_query($field, $data_form, $data)
		{
			switch ($data_form) {
				case 'tipo_pais':
					
					if($field == 'tier'):
					
						$data[0]['before'] = ' ( ';	

					endif;

						return $data;

				break;
				
				default:
					# code...
				break;
			}
		}


		private static function construct_query_multiple($session, $new_query_vars, $post)
		{
			// Verificar si el filtro ya existe
			foreach($session as $k => $v) :

				if ($v['key'] ==  'universidades.'.$post['field']) :
					unset($session[$k]);

				endif;	

				
			endforeach;

			$new_query = self::multi_query($post['field'],$post['data_form'],array_merge($session, $new_query_vars));

			return $new_query;
			


		}


		private static function construct_query($data, $post)
		{

			switch ($post['data_form']) {
				case 'tipo_pais':
					
					if($post['field'] != 'tier'):
					
						
						return (strpos($post['field'], ':')) ? self::$$post['data_form'] : array_merge(self::$$post['data_form'], $data );

					else :

						$data[0]['before'] = ' ( ';


						return $data;

					endif;
						
				break;
				
				default:
					# code...
				break;
			}


		}


		private static function get_order_data_simple($data_form)
		{

			switch ($data_form) {
				case 'tipo_pais':
					return 'ORDER BY paises.nombre, universidades.tier, universidades.nombre';
				break;
				
				default:
					# code...
				break;
			}

		}


		private static function is_aviable($filter, $v)
		{

			// parent::dump($v);
			// parent::dump($filter);
			

			switch ($filter['data_type']) {
				case 'rang':
					
					$fil_data = explode(',', $filter['value']);
					$fields   = explode(':', $filter['field']);
					

					$value = (int) $v[$fields[0]][$fields[1]];
					
					if( ($value >= $fil_data[0]) && ($value <= $fil_data[1])  ) :
						return $v;
					endif;


				break;
				
				default:
					# code...
				break;
			}

			return false;
		}	


		private static function get_filter_json_simple($data, $filter)
		{
			
			if($data) :
				foreach($data as $k => $v):

					
					if(self::is_aviable($filter, $v)) :

						$new_array[$k] = $v;

					endif;

				endforeach;
			endif;

			return (isset($new_array)) ? $new_array : false;
			

		}

		private static function get_filter_data_simple($data)
		{

			switch ($data['data_type']) {
				case 'combo':
				
					$fil_data = explode(',', $data['value']);
					$count    = count($fil_data);




					$i = 1;
					foreach($fil_data as $k => $v):

						$operador  = ($i == 1 && $count != 1 ) ? 'OR ' : (($i == $count) ? ' ' : 'OR ');
						$after     = ($i == 1 && $count != 1) ? ' ' : (($i == $count) ? ' ) ' : ' ');
						$before    = ($i == 1 ) ? ' AND ( ' : (($i == $count) ? '  ' : ' ');


						$add_query[] = array(
							'before'        => $before,
							'key'           => 'universidades.'.$data['field'],
							'value'         => $v,
							'condicional'   => '=',
							'operador'      => $operador,
							'after'         => $after
						);



					$i++;	
					endforeach;
					
			
					return $add_query;
					
					



				break;


				case 'like' :


					$operador  = ' ';
					$after     = ' ) ';
					$before    = ' AND ( ';

					$add_query[] = array(
						'like_ini'      => '%', 
						'before'        => $before,
						'key'           => 'universidades.'.$data['field'],
						'value'         => $data['value'],
						'condicional'   => 'like',
						'operador'      => $operador,
						'after'         => $after,
						'like_fin'      => '%'
					);

					return $add_query;

				break;


				case 'rang' :

					$fil_data = explode(',', $data['value']);
					$count    = count($fil_data);




					$i = 1;
					foreach($fil_data as $k => $v):

						$operador     = ($i == 1 && $count != 1 ) ? 'AND ' : (($i == $count) ? ' ' : 'AND ');
						$after        = ($i == 1 && $count != 1) ? ' ' : (($i == $count) ? ' ) ' : ' ');
						$before       = ($i == 1 ) ? ' AND ( ' : (($i == $count) ? '  ' : ' ');
						$condicional  = ($i == 1 ) ? '>='      : '<=' ;	

						$value = (int) $v;

						$add_query[] = array(
							'before'        => $before,
							'key'           => 'universidades.'.$data['field'],
							'value'         => $value,
							'condicional'   => $condicional,
							'operador'      => $operador,
							'after'         => $after,
							'numeric'       => true
						);



					$i++;	
					endforeach;
					
			
					return $add_query;


				break;
				
				default:
					# code...
				break;
			}


		}


		private static function print_filter($data, $form)
		{
			switch ($form) {
				case 'tipo_pais':
					

					$html = '';

					if($data) : 

						

						foreach ($data as $k1 => $v1  ) : ?>
						
							<tr>
								<td> <?php echo $v1['nombre_pais']; ?> </td>
								<td> <?php echo $v1['nombre']; ?></td>
								<td> <?php echo $v1['tier']; ?> </td>
								<td> <?php echo number_format($v1['poblacion']['total']); ?></td>
								<td> <?php echo number_format($v1['ingresos']['total_ingresos']); ?></td>
								<td> <?php echo $v1['rank_nacional']; ?></td>
							</tr>


						<?php endforeach;

					else :
						echo '<tr><td colspan="6">No se encontraron resultados</td></tr>';

					endif;
				break;
				
				default:
					# code...
				break;
			}
		}


	}


 ?>