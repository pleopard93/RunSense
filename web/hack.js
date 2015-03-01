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
  signUpSubmit();
}

function signUpSubmit(){
  window.location.href = "runSenseHome.html";
  var email = $("#email").val();
  var password = $("#password").val();

  $.ajax({
    type: "POST",
    url: "/api/index.php/newUser",
    dataType: "json",
    data: {"name": email,
           "email": email,
           "password": password
          },
    success: function( data ){
        userId = data["UserId"];
      },
      error: function (jqXHR, textStatus, errorThrown){
        console.log(jqXHR + ", " + textStatus + ", " + errorThrown)
      }
  });
}

function removeSignUpButtons(){
	$('.sign-up').remove();
}

function mergeSort(steps)
{
    if (arr.length < 2)
        return arr;
 
    var middle = parseInt(arr.length / 2);
    var left   = arr.slice(0, middle);
    var right  = arr.slice(middle, arr.length);
 
    return merge(mergeSort(left), mergeSort(right));
}
 
function merge(left, right)
{
    var result = [];
 
    while (left.length && right.length) {
        if (left[0]["StepNumber"] <= right[0]["StepNumber"]) {
            result.push(left.shift());
        } else {
            result.push(right.shift());
        }
    }
 
    while (left.length)
        result.push(left.shift());
 
    while (right.length)
        result.push(right.shift());
 
    return result;
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
  var steps = [];
  $.ajax({
    type: "GET",
    url: "/api/index.php/getRun",
    dataType: "json",
    data: {"UserID": userId},
    success: function( data ){
      steps = mergeSort(data["StepList"]);
      for (var i = 0; i < steps.length; i++){
        var data_point = [];
        data_point.push(i);
        var metrics = steps[i]["Metrics"];
        data_point.push(metrics["d1"]);
        data_point.push(metrics["d2"]);
        data_points.push(data_point);
      }
    },
      error: function (jqXHR, textStatus, errorThrown){
        console.log(jqXHR + ", " + textStatus + ", " + errorThrown)
      }
  });
  run_data.addRows(data_points);
  chart.draw(run_data, options);


  //TOTAL RUNS

  var chart2 = new google.visualization.LineChart(document.getElementById('ex2'));
  chart2.draw(all_data, options);

  //DATA

  data_points = [];
  steps = [];
  $.ajax({
    type: "GET",
    url: "/api/index.php/getAllRuns",
    dataType: "json",
    data: {"UserID": userId},
    success: function( data ){
      steps = mergeSort(data["StepList"]);
      for (var i = 0; i < steps.length; i++){
        var data_point = [];
        data_point.push(i);
        var metrics = steps[i]["Metrics"];
        data_point.push(metrics["d1"]);
        data_point.push(metrics["d2"]);
        data_points.push(data_point);
      }
    },
      error: function (jqXHR, textStatus, errorThrown){
        console.log(jqXHR + ", " + textStatus + ", " + errorThrown)
      }
  });
  run_data.addRows(data_points);
  chart.draw(run_data, options);
}

google.load('visualization', '1', {packages: ['corechart']});
google.setOnLoadCallback(drawChart);
