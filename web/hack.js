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

      var data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      data.addColumn('number', 'Heel Strike');
      data.addColumn('number', 'Pronation');

      data.addRows([
        [0, 0, 80],   [1, 10, 75],  [2, 23, 72],
        [3, 17, 70],  [4, 18, 69],  [5, 9, 68],
        [6, 11, 67],  [7, 27, 65],  [8, 33, 60],
        [9, 40, 64],  [10, 32, 68], [11, 35, 70],
        [12, 30, 75], [13, 40, 73], [14, 42, 72],
        [15, 47, 71], [16, 44, 70], [17, 48, 67],
        [18, 52, 65], [19, 54, 66], [20, 42, 68],
        [21, 55, 72], [22, 56, 70], [23, 57, 69],
        [24, 60, 69], [25, 50, 67], [26, 52, 66],
        [27, 51, 63], [28, 49, 65], [29, 53, 64],
        [30, 55, 61], [31, 60, 55], [32, 61, 58],
        [33, 59, 62], [34, 62, 65], [35, 65, 62],
        [36, 62, 62], [37, 58, 65], [38, 55, 62],
        [39, 61, 58], [40, 64, 62], [41, 65, 65],
        [42, 63, 62], [43, 66, 59], [44, 67, 61],
        [45, 69, 60], [46, 69, 57], [47, 70, 56],
        [48, 72, 55], [49, 68, 42], [50, 66, 54],
        [51, 65, 52], [52, 67, 48], [53, 70, 44],
        [54, 71, 47], [55, 72, 42], [56, 73, 40],
        [57, 75, 30], [58, 70, 35], [59, 68, 32],
        [60, 64, 40], [61, 60, 33], [62, 65, 27],
        [63, 67, 11], [64, 68, 9], [65, 69, 18],
        [66, 70, 17], [67, 72, 23], [68, 75, 10],
        [69, 80, 0]
      ]);

      var options = {
        width: 800,
        height: 492,
        hAxis: {
          title: 'Step'
        },
        vAxis: {
          title: 'Severity'
        },
        colors: ['#a52714', '#097138']
      };

      var chart = new google.visualization.LineChart(document.getElementById('ex3'));
      var chart2 = new google.visualization.LineChart(document.getElementById('ex2'));

      chart.draw(data, options);
      chart2.draw(data, options);
    }
