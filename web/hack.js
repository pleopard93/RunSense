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
	//CHECK USERNAME AND PASSWORD WITH DB
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
      title: 'Severity'
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

  var data_points = [];
  var first_point = 50;
  var second_point = 60;
  for (var i = 0; i < 300; i++) {
    var data_point = [];
    data_point.push(i);
    first_point -= (Math.random()*5)-(Math.random()*5.1)
    data_point.push(first_point);
    second_point -= (Math.random()*4)-(Math.random()*4.1)
    data_point.push(second_point);
    data_points.push(data_point);
  }

  run_data.addRows(data_points);
  chart.draw(run_data, options);

  //TOTAL RUNS

  var chart2 = new google.visualization.LineChart(document.getElementById('ex2'));
  chart2.draw(all_data, options);

  data_points = [];
  first_point = 50;
  second_point = 60;
  for (var i = 0; i < 1500; i++) {
    var data_point = [];
    data_point.push(i);
    first_point -= (Math.random()*10)-(Math.random()*10.1)
    data_point.push(first_point);
    second_point -= (Math.random()*14)-(Math.random()*14.1)
    data_point.push(second_point);
    data_points.push(data_point);
  }

  all_data.addRows(data_points);
  chart2.draw(all_data, options);
}

google.load('visualization', '1', {packages: ['corechart']});
google.setOnLoadCallback(drawChart);
