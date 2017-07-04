alert_modal("Server error", "<%= j @error.to_s %>", 'warning');
# Hide the 'wait for local system modal' in case error thrown when getting blueprint on installing an app
$('#wait_for_local_system_modal').modal('hide');
