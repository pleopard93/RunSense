var data = {
  // A labels array that can contain any sort of values
  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
  // Our series array that contains series objects or in this case series data arrays
  series: [
    [5, 2, 4, 2, 0]
  ]
};

// Create a new line chart object where as first parameter we pass in a selector
// that is resolving to our chart container element. The Second parameter
// is the actual data object.
new Chartist.Line('.ct-chart', data);

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

