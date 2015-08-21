<?php 

	use App\Controller  as controller;


	Class DashboardController extends controller
	{

		public static function admin_dashboard()
		{

			// header('Content-Type: text/html; charset=ISO-8859-15');

			$data = UniversityModel::find_by_attr(
				'',
					'universidades.id_pais,
					universidades.poblacion,
					universidades.ingresos,
					universidades.tier,
					paises.nombre
					',
				'INNER JOIN paises ON universidades.id_pais = paises.id',
				' ORDER BY universidades.id_pais'
			);



			$int_x_pais = array(
				1 => 0,
				2 => 0,
				3 => 0,
				4 => 0,
				5 => 0,
				6 => 0,
				7 => 0,
				8 => 0,
				9 => 0,
				10 => 0,
				11 => 0,
				12 => 0,
				13 => 0,
				14 => 0,
				15 => 0,
				16 => 0,
				17 => 0,
				18 => 0,
			);

			$poblacion_total = array(
				1 => 0,
				2 => 0,
				3 => 0,
				4 => 0,
				5 => 0,
				6 => 0,
				7 => 0,
				8 => 0,
				9 => 0,
				10 => 0,
				11 => 0,
				12 => 0,
				13 => 0,
				14 => 0,
				15 => 0,
				16 => 0,
				17 => 0,
				18 => 0,
			);

			$total_ingresos = array(
				1 => 0,
				2 => 0,
				3 => 0,
				4 => 0,
				5 => 0,
				6 => 0,
				7 => 0,
				8 => 0,
				9 => 0,
				10 => 0,
				11 => 0,
				12 => 0,
				13 => 0,
				14 => 0,
				15 => 0,
				16 => 0,
				17 => 0,
				18 => 0,
			);


			$tier = array(
				1 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				2 =>  array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				3 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				4 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				5 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				6 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				7 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				8 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				9 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				10 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				11 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				12 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				13 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				14 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				15 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				16 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				17 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
				18 => array(
					1 => 0,
					2 => 0,
					3 => 0,
					4 => 0,
					5 => 0,
				),
			);

			foreach($data as $k => $v) :
				
				$poblacion = json_decode($v['poblacion'], true);
				$ingresos  = json_decode($v['ingresos'], true);

				if($v['tier'] != 0) :
					$tier[$v['id_pais']][$v['tier']] += 1;
				endif;

				$poblacion_total[$v['id_pais']] += $poblacion['total'];
				$total_ingresos[$v['id_pais']]  += $ingresos['total_ingresos'];

				$int_x_pais[$v['id_pais']] = $int_x_pais[$v['id_pais']] + 1;
				
				$nombres[$v['id_pais']] = $v['nombre']; 
				
			endforeach;
			
			for ($i=1; $i < 19; $i++) { 
				$tier_order[$i] = array_sum($tier[$i]);
			}


			arsort($int_x_pais, SORT_NUMERIC);
			arsort($poblacion_total	, SORT_NUMERIC);
			arsort($total_ingresos	, SORT_NUMERIC);
			arsort($tier_order);

			foreach($tier_order as $k1 => $v1) :
				$new_tier[$k1] = $tier[$k1];
			endforeach;


			$new_data['int_x_pais']      = $int_x_pais;
			$new_data['poblacion_total'] = $poblacion_total;
			$new_data['total_ingresos']  = $total_ingresos;
			$new_data['tier']            = $new_tier;
			$new_data['nombres']         = $nombres;
			
			// parent::dump($new_data['total_ingresos']);
			
			// die();
			

			return parent::view()->create('dashboard:admin_layout', $new_data);
		}
	}

 ?>