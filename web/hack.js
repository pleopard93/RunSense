function createAccountButton(){
	console.log("create account");
	removeSignUpButtons();
	$('#create-account-hidden-form').attr('class', 'create-account-form section-border');
}

function signInButton(){
	console.log("signIn");
	removeSignUpButtons();
	$('#sign-in-hidden-form').attr('class', 'sign-in-form section-border');
	//CHECK USERNAME AND PASSWORD WITH DB
}

function removeSignUpButtons(){
	$('.sign-up').remove();
}

    google.load('visualization', '1', {packages: ['corechart']});
    google.setOnLoadCallback(drawChart);

    function drawChart() {

      var run_data = new google.visualization.DataTable();

      //LAST RUN

      run_data.addColumn('number', 'X');
      run_data.addColumn('number', 'Heel Strike');
      run_data.addColumn('number', 'Pronation');

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

      //TOTAL RUNS

      var all_data = new google.visualization.DataTable();
      all_data.addColumn('number', 'X');
      all_data.addColumn('number', 'Heel Strike');
      all_data.addColumn('number', 'Pronation');

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

      var options = {
        width: 800,
        backgroundColor:'transparent',
        height: 492,
        hAxis: {
          title: 'Step'
        },
        vAxis: {
          title: 'Severity'
        },
        colors: ['#55559F', '#F95555']
      };

      var chart = new google.visualization.LineChart(document.getElementById('ex3'));
      var chart2 = new google.visualization.LineChart(document.getElementById('ex2'));

      chart.draw(run_data, options);
      chart2.draw(all_data, options);
    }
