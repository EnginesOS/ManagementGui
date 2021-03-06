$.ajaxSetup({
    timeout: 45000 // 45 second timeout -- note that application server has up to 30 second timeouts on some system api calls.
});

$(document).ajaxError(function(event, request, settings, error) {
  var remotipart_submitted, response;
  response = request.responseText;
  console.log("------error.status: " + error.status);
  console.log("------request.status: " + request.status);
  console.log("------event.status: " + event.status);
  console.log("------settings.async: " + settings.async);
  console.log('------ready state: ' + request.readyState);
  console.log('------settings data: ' + settings.data);
  console.log('------settings data not undefined: ' + (settings.data !== 'undefined'));

  if (request.status === 401 || request.status === 500 || request.status === 404) {
    if (request.status === 401) {
      alert(response);
      location.reload();
    } else {
      alert_modal('Application error', error + ". " + response);
    };
  } else if ((typeof settings.data !== 'undefined') && (request.status === 0)) {
    if ((settings.data !== null) && (settings.data.constructor.name === 'Array')) {
      remotipart_submitted = settings.data.find(function(datum) {
        return datum.name === 'remotipart_submitted';
      });
      if (remotipart_submitted.constructor.name === 'Object') {
        if (remotipart_submitted.value === true) {
          console.log('Ajax error thrown. Ajax status 0. Data constructor: Array. Remotipart submitted.');
        } else {
          console.log('Ajax error thrown. Ajax status 0. Data constructor: Array. Remotipart not submitted');
        };
      } else {
        console.log('Ajax error thrown. Ajax status 0. Data constructor not Array.');
      };
    } else {
      console.log('Undefined communication error.');
      alert_modal('Communication error', "There was a communication error.\n\nBrowser client failed to connect to the management application server.");
    };
  } else {
    if (request.status === 200) {
      console.log('Ajax error thrown on 200 status.');
    } else {
      console.log("Unhandled application error", "Request status: " + request.status + "\nRequest: " + JSON.stringify(request) + "\nSettings: " + JSON.stringify(settings) + "\nError: " + error);
    };
  };
});
