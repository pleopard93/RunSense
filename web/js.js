console.log("in js");

	var js = {
    "name":"zach",
    "email":"zaaaaach",
    "password":"pass2"
};
/*
	$.ajax({
        type: "POST",
        url: '/api/index.php/newUser',
        dataType: "json",
        data: js,
        success: function (result) {
        	console.log(result);
          },
        error: function(jqXHR, textStatus, errorThrown){
           console.log(jqXHR, textStatus, errorThrown);
      }});

var newRun = {
  "UserID":"2"
};


    $.ajax({
        type: "POST",
        url: '/api/index.php/newRun',
        dataType: "json",
        data: newRun,
        success: function (result) {
          console.log(result);
          },
        error: function(jqXHR, textStatus, errorThrown){
           console.log(jqXHR, textStatus, errorThrown);
      }});



var newSteps = {
    "RunID": 1,
    "stepList": [
    {
            "stepNumber": 1,
            "foot": "L",
            "metrics": "1234"
        },
        {
            "stepNumber": 2,
            "foot": "R",
            "metrics": "1234"
        }
    ]
};

    $.ajax({
        type: "GET",
        url: '/api/index.php/addSteps',
        dataType: "json",
        data: newSteps,
        success: function (result) {
          console.log(result);
          },
        error: function(jqXHR, textStatus, errorThrown){
           console.log(jqXHR, textStatus, errorThrown);
      }});
*/


 $.ajax({
        type: "POST",
        url: '/api/index.php/getAllRuns',
        dataType: "json",
        data: {
          "UserID": 2
        },
        success: function (result) {
          console.log(result);
          },
        error: function(jqXHR, textStatus, errorThrown){
           console.log(jqXHR, textStatus, errorThrown);
      }});

/*

 $.ajax({
        type: "POST",
        url: '/api/index.php/getRun',
        dataType: "json",
        data: {
          "UserID": 2,
        },
        success: function (result) {
          console.log(result);
          },
        error: function(jqXHR, textStatus, errorThrown){
           console.log(jqXHR, textStatus, errorThrown);
      }});

*/

function hello(){
  alert("hey");
}