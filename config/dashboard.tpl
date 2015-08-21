<?php 
	$america = array(1,2,4,5,7,10,11, 17,18);
	$centro  = array(16,6,12,3,14,13,15);
	$caribe  = array(8,9);


	// parent::dump($params['tier']);
 ?>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
	  google.load("visualization", "1", {packages:["corechart", "geochart", "bar"]});
      google.setOnLoadCallback(drawRegionsMap);
      google.setOnLoadCallback(drawChart2);
      google.setOnLoadCallback(drawChart3);
      google.setOnLoadCallback(drawChart4);
      google.setOnLoadCallback(drawChart5);
      google.setOnLoadCallback(drawChart6);
      google.setOnLoadCallback(drawChart7);
      google.setOnLoadCallback(drawChart8);
      google.setOnLoadCallback(drawChart9);
 


       function drawChart9() {
       		
       		
       		// Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
	         ['Pais', 'Tier 1', 'Tier 2', 'Tier 3', 'Tier 4', 'Tier 5'],
	         

	          <?php foreach($params['tier'] as $k => $tier):
          		

	          	 ?>
	          		['<?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k])); ?>', 
	          		<?php echo $tier[1]; ?>, 
	          		<?php echo $tier[2]; ?>,
	          		<?php echo $tier[3]; ?>,
	          		<?php echo $tier[4]; ?>,
	          		<?php echo $tier[5]; ?>],
	          	<?php  endforeach; ?>
     	 ]);

		    var options = {
		     	
		      backgroundColor: { fill:'transparent' },	
		      seriesType: 'bars',
		    
		      // orientation: 'vertical',
		      series: {5: {type: 'line'}}
		    };

		    var chart = new google.visualization.ComboChart(document.getElementById('tier'));
		    chart.draw(data, options);




    	}


       function drawChart8() {
       		
       		
       		var data = new google.visualization.DataTable();
	          data.addColumn('string', 'Pais');
	          data.addColumn('number', 'Ingresos');

	          data.addRows([
	            <?php foreach($params['total_ingresos'] as $k => $ing):
          		

	          	 ?>
	          		['<?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k])); ?>', <?php echo $ing; ?>],
	          	<?php  endforeach; ?>
	          ]);



       		// var data = google.visualization.arrayToDataTable([
	        //  ['Pais', 'Ingresos'],
	       
  			 	
	        // ]);

	        var options = {
	        backgroundColor: { fill:'transparent' },
	        
         	 // orientation: 'vertical',
         	 legend: { position: 'none' },
         
         	 axes: {
           		 x: {
             		 0: { side: 'bottom'} // Top x-axis.
            	}
          	},
          	bar: { groupWidth: "90%" },
          	hAxis : {format : 'currency'}


	        };

	        options['vAxis'] = {'format': "$ #,###", 'maxValue':1, 'minValue': 0};

  			var formatter = new google.visualization.NumberFormat({pattern:'$ #,###'});
			formatter.format(data, 1); // Apply formatter to second column

	        var chart = new google.visualization.ColumnChart(document.getElementById('ingresos'));
	       


	        chart.draw(data, options);



    	}

       function drawChart7() {
       		
       		
       		var data = new google.visualization.DataTable();
	          data.addColumn('string', 'Pais');
	          data.addColumn('number', 'Ingresos');

	          data.addRows([
	            <?php foreach($params['total_ingresos'] as $k => $ing):
          		

	          	 ?>
	          		['<?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k])); ?>', <?php echo $ing; ?>],
	          	<?php  endforeach; ?>
	          ]);



       		// var data = google.visualization.arrayToDataTable([
	        //  ['Pais', 'Ingresos'],
	       
  			 	
	        // ]);

	        var options = {
	        backgroundColor: { fill:'transparent' },
	        
         	
         	 legend: { position: 'none' },
         
         	 axes: {
           		 x: {
             		 0: { side: 'bottom'} // Top x-axis.
            	}
          	},
          	bar: { groupWidth: "90%" },
          	hAxis : {format : 'currency'}


	        };

	        var chart = new google.visualization.ColumnChart(document.getElementById('ingresos'));

	        chart.draw(data, options);



    	}



       function drawChart4() {
       		
       		

       		var data = google.visualization.arrayToDataTable([
	          ['Pais', 'No de matriculados' ],
	      		
          	<?php foreach($params['poblacion_total'] as $k => $matri):
          			if(in_array($k, $america)):

	           ?>
	          ['<?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k])); ?>', <?php echo $matri; ?>],
	          <?php endif; endforeach; ?>
	        ]);

	        var options = {
	          title: 'Sur America',
	          backgroundColor: { fill:'transparent' },
	          pieHole: 0.4,
	          is3D: true,


	        };

	        var chart = new google.visualization.PieChart(document.getElementById('matriculas_south'));
	        chart.draw(data, options);


    	}


    	 function drawChart5() {
       		
       		

       		var data = google.visualization.arrayToDataTable([
	          ['Pais', 'No de matriculados' ],
	      		
          	<?php foreach($params['poblacion_total'] as $k => $matri):
          			if(in_array($k, $centro)):

	           ?>
	          ['<?php echo utf8_encode($params['nombres'][$k]); ?>', <?php echo $matri; ?>],
	          <?php endif; endforeach; ?>
	        ]);

	        var options = {
	          title: 'Centro America',
	          backgroundColor: { fill:'transparent' },
	          pieHole: 0.4,
	          is3D: true,


	        };

	        var chart = new google.visualization.PieChart(document.getElementById('matriculas_center'));
	        chart.draw(data, options);


    	}


		function drawChart6() {
       		
       		

       		var data = google.visualization.arrayToDataTable([
	          ['Pais', 'No de matriculados' ],
	      		
          	<?php foreach($params['poblacion_total'] as $k => $matri):
          			if(in_array($k, $caribe)):

	           ?>
	          ['<?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k])); ?>', <?php echo $matri; ?>],
	          <?php endif; endforeach; ?>
	        ]);

	        var options = {
	          title: 'Caribe',
	          backgroundColor: { fill:'transparent' },
	          pieHole: 0.4,
	          is3D: true,


	        };

	        var chart = new google.visualization.PieChart(document.getElementById('matriculas_caribe'));
	        chart.draw(data, options);


    	}
  

      function drawRegionsMap() {

        var data = google.visualization.arrayToDataTable([
          ['Country', 'No Instituciones'],
         
          <?php  foreach($params['int_x_pais'] as $k => $country) : 
          			

          			if(in_array($k, $america)):
          				 ?>
        
          			['<?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k])); ?>', <?php echo $country; ?>],

          <?php endif; endforeach; ?>

        ]);

      
        var options = { 
        	title: 'Sur America',
        	region: '005',
        	backgroundColor: { fill:'transparent' },
        	displayMode: 'regions',
        	keepAspectRatio: false,
        	showZoomOut: true,
        	colors: ['#4bb5f3', '#FADC41', '#c44949', '#d74a12', '#0e9a0e', '#55c2ac', '#7c4b91', '#fadc41', '#0d6cca', '#7c4897']   
        
    	};
        var chart = new google.visualization.GeoChart(document.getElementById('south_country'));

        chart.draw(data, options);
      }

    function drawChart2() {

        var data = google.visualization.arrayToDataTable([
          ['Country', 'No Instituciones'],
         
          <?php  foreach($params['int_x_pais'] as $k => $country1) : 
          			if(in_array($k, $centro)):
          				  ?>
        
          			['<?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k])); ?>', <?php echo $country1 ?>],

          <?php endif;
           endforeach; ?>

        ]);

      
        var options = { 
        	region: '013',
        	backgroundColor: { fill:'transparent' },
        	displayMode: 'regions',
        	keepAspectRatio: false,
        	showZoomOut: true,
        	colors: ['#4bb5f3', '#FADC41', '#c44949', '#d74a12', '#0e9a0e', '#55c2ac', '#7c4b91', '#fadc41', '#0d6cca', '#7c4897']   
        
    	};
        var chart = new google.visualization.GeoChart(document.getElementById('center_country'));

        chart.draw(data, options);
  	}


  	 function drawChart3() {
  	 	var data = google.visualization.arrayToDataTable([
          ['Country', 'No Instituciones'],
         
          <?php  foreach($params['int_x_pais'] as $k => $country2) : 
          			if(in_array($k, $caribe)):
          				  ?>
        
          			
          			['<?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k])); ?>', <?php echo $country2 ?>],

          <?php endif; endforeach; ?>

        ]);

      
        var options = { 
        	region: '029',
        	backgroundColor: { fill:'transparent' },
        	displayMode: 'regions',
        	keepAspectRatio: false,
        	showZoomOut: true,
        	colors: ['#4bb5f3', '#FADC41', '#c44949', '#d74a12', '#0e9a0e', '#55c2ac', '#7c4b91', '#fadc41', '#0d6cca', '#7c4897']   
        
    	};
        var chart = new google.visualization.GeoChart(document.getElementById('caribean_country'));

        chart.draw(data, options);
   	 }	



   	 $(document).ready(function(){
   	 
   	 	// $('.panel-default .panel-heading a').trigger('click');
   	 });

</script>

<div id="accordion" class="panel-group" aria-multiselectable="true" role="tablist">
	<!-- Universidades por pais sur amererica -->
	<div class="panel panel-default">
		<div role="tab" class="panel-heading">
	      <h4 class="panel-title">
	        <a aria-controls="tab1" aria-expanded="true" href="#tab1" data-parent="#accordion" data-toggle="collapse" role="button" class="">
	          <i class="fa fa-map"></i> Instituciones por país
	        </a>
	      </h4>
    	</div>

		<div id="tab1" class="panel-collapse collapse in"  style="width:100%">
	   	 	
			<div class="panel-body" style="position:relative;">
				
				<div id="center_country" style="width: 33%; height: 350px;display:inline-block;vertical-align:top;"></div>
			 	<div id="caribean_country" style="width: 33%; height: 350px;display:inline-block;vertical-align:top;"></div>
			 	<div id="south_country" style="width: 33%; height: 350px;display:inline-block;vertical-align:top;"></div> 
				 <div class="data_info">
				 	<ul>
				 		<?php 
				 			

				 			
				 			foreach($params['int_x_pais'] as $k1 => $v1) :  ?>

						<li><?php echo utf8_encode($params['nombres'][$k1]); ?> <strong><?php echo $v1; ?></strong></li>

				 		<?php endforeach; ?>
				 	</ul>
				 	<p style="margin:15px 0; width:100%; background:#333;height:1px;display:block;"></p>
				 	<div class="total">Total <strong><?php echo array_sum($params['int_x_pais']); ?></strong></div>	
				 </div>

			</div>


	   	 	
   		</div>

	</div>


	
	
   <!-- Matricualdos por pais -->
   <div class="panel panel-default">
   		<!-- Head -->
   		<div role="tab" class="panel-heading">
   			 <h4 class="panel-title">
		        <a aria-controls="collapseOne" aria-expanded="true" href="#tab2" data-parent="#accordion" data-toggle="collapse" role="button" class="">
		          <i class="fa fa-map"></i> Matrículas por país
		        </a>
      		</h4>
   		</div>

		<div id="tab2" class="panel-collapse collapse"  style="width:100%">
			
			<div class="panel-body" style="position:relative;">
				<div id="matriculas_south" style="width: 50%; height: 700px;float:left;"></div>
	   			<div id="matriculas_center" style="width: 48%; height: 350px;display:inline-block;vertical-align:top;"></div>
	   			<div id="matriculas_caribe" style="width: 48%; height: 350px;display:inline-block;vertical-align:top;"></div>
		   		<div class="data_info">
				 	<ul>
				 		<?php 
				 			

				 			
				 			foreach($params['poblacion_total'] as $k1 => $v1) :  ?>

						<li><?php echo utf8_encode($params['nombres'][$k1]); ?> <strong><?php echo number_format($v1); ?></strong></li>

				 		<?php endforeach; ?>
				 	</ul>
				 	<p style="margin:15px 0; width:100%; background:#333;height:1px;display:block;"></p>
				 	<div class="total">Total <strong><?php echo number_format(array_sum($params['poblacion_total'])); ?></strong></div>	
			    </div>

			</div>


			
		</div>


   </div>
	

   <!-- Ingresos por pais -->
	<div class="panel panel-default">
		<!-- Head -->
   		<div role="tab" class="panel-heading">
   			 <h4 class="panel-title">
		        <a aria-controls="collapseOne" aria-expanded="true" href="#tab3" data-parent="#accordion" data-toggle="collapse" role="button" class="">
		          <i class="fa fa-map"></i> Ingresos por país
		        </a>
      		</h4>
   		</div>
		
		<div id="tab3" class="panel-collapse collapse"  style="width:100%">
			<div class="panel-body" style="position:relative;">
				<div id="ingresos" style="width: 100%; height: 500px;display:inline-block;vertical-align:top;"></div>
				<div class="data_info">
				 	<ul>
				 		<?php 
				 			

				 			
				 			foreach($params['total_ingresos'] as $k1 => $v1) :  ?>

						<li><?php echo utf8_encode($params['nombres'][$k1]); ?> <strong><?php echo number_format($v1); ?></strong></li>

				 		<?php endforeach; ?>
				 	</ul>
				 	<p style="margin:15px 0; width:100%; background:#333;height:1px;display:block;"></p>
				 	<div class="total">Total <strong><?php echo number_format(array_sum($params['total_ingresos'])); ?></strong></div>	
			    </div>
			</div>
		</div>

	</div>   


	<!-- Tier -->
	
	<div class="panel panel-default">
		<!-- Head -->
   		<div role="tab" class="panel-heading">
   			 <h4 class="panel-title">
		        <a aria-controls="collapseOne" aria-expanded="true" href="#tab4" data-parent="#accordion" data-toggle="collapse" role="button" class="">
		          <i class="fa fa-map"></i> Tier
		        </a>
      		</h4>
   		</div>	

   		<div id="tab4" class="panel-collapse collapse"  style="width:100%">
			
			<div class="panel-body" style="position:relative;">
				<div id="tier" style="width: 100%;height:700px; display:block;vertical-align:top;"></div>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Pais</th>
							<th>Tier 1</th>
							<th>Tier 2</th>
							<th>Tier 3</th>
							<th>Tier 4</th>
							<th>Tier 5</th>
							<th>Total</th>
						</tr>
					</thead>
					<tbody>
						<?php foreach($params['tier'] as $k1 => $tier): ?>
							<tr>
								<td><?php echo self::quitar_tildes(utf8_encode($params['nombres'][$k1])); ?></td>
								<td> <?php echo $tier[1]; ?> </td>
								<td> <?php echo $tier[2]; ?> </td>
								<td> <?php echo $tier[3]; ?> </td>
								<td> <?php echo $tier[4]; ?> </td>
								<td> <?php echo $tier[5]; ?> </td>
								<td> <?php echo array_sum($tier); ?></td>
							</tr>
						<?php endforeach; ?>
					</tbody>
				</table>
			</div>

			
			
   		</div>
	</div>
</div>



   

 
