function createAccountButton(){
	console.log("create account");
	removeSignUpButtons();
  $('#create-account-hidden-form').fadeTo(100, 0);
	$('#create-account-hidden-form').attr('class', 'create-account-form section-border');
  $('#create-account-hidden-form').fadeTo(1500, 1);
}

function signInButton(){
	console.log("signIn");
	removeSignUpButtons();
  $('#sign-in-hidden-form').fadeTo(100, 0);
	$('#sign-in-hidden-form').attr('class', 'sign-in-form section-border');
  $('#sign-in-hidden-form').fadeTo(1500, 1);
}

function createAccountSubmit(){

}

function removeSignUpButtons(){
	$('.sign-up').remove();
}

function drawChart() {

  var options = {
    width: 800,
    backgroundColor:'transparent',
    height: 492,
    hAxis: {
      textStyle: {
        italic: false,
        fontName: 'Raleway',
        fontSize: '16'
      },
      titleTextStyle: {
        italic: false,
        fontName: 'Raleway',
        fontSize: '26'
      },
      title: 'Step'
    },
    vAxis: {
      textPosition: 'none',
      titleTextStyle: {
        italic: false,
        fontName: 'Raleway',
        fontSize: '26'
      },
      title: 'Magnitude'
    },
    legend: {
      position: 'right',
      textStyle: {
        fontName: 'Raleway',
        fontSize: '16'
      }
    },
    colors: ['#E62225', '#F97866'],
    animation: {
      duration: 3000,
      startup: true,
      easing: 'in'
    }
  };

  var run_data = new google.visualization.DataTable();
  var all_data = new google.visualization.DataTable();

  run_data.addColumn('number', 'X');
  run_data.addColumn('number', 'Heel Strike');
  run_data.addColumn('number', 'Pronation');  
  all_data.addColumn('number', 'X');
  all_data.addColumn('number', 'Heel Strike');
  all_data.addColumn('number', 'Pronation');

  //LAST RUN

  var chart = new google.visualization.LineChart(document.getElementById('ex3'));
  chart.draw(run_data, options);

  //DATA

  var data_points = [];
  $.get("index.php/getRun", function( data ){
    for (var i = 0; i < data.length; i++){
      var data_point = [];
      data_point.push(i);
      first_point = run_data['heelStrike'];
      second_point = run_data['pronate'];
      data_points.push(first_point);
      data_points.push(second_point);
    }
  });
  run_data.addRows(data_points);
  chart.draw(run_data, options);


  //TOTAL RUNS

  var chart2 = new google.visualization.LineChart(document.getElementById('ex2'));
  chart2.draw(all_data, options);

  //DATA

  data_points = [];
  $.get("index.php/getAllRuns", function( data ){
    for (var i = 0; i < data.length; i++){
      var data_point = [];
      data_point.push(i);
      first_point = total_data['heelStrike'];
      second_point = total_data['pronate'];
      data_points.push(first_point);
      data_points.push(second_point);
    }
  });
  run_data.addRows(data_points);
  chart.draw(run_data, options);
}

google.load('visualization', '1', {packages: ['corechart']});
google.setOnLoadCallback(drawChart);
