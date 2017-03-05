// $(document).ajaxSuccess(function(){
//
//   // Stream the build log on the build show
//   $('[data-behavior~=stream_build_log]').each(function() {
//     if ($("#installer_builder_log").html() == '') {
//       var builder_log_event_source = new EventSource($(this).data('build-log-url'));
//       builder_log_event_source.addEventListener("log_line", process_builder_log_line);
//       builder_log_event_source.addEventListener("log_eof", process_builder_log_eof);
//     };
//   });
//
//   // Live text search/filtering for library
//   if ($("#installer_libarary_apps").length) {
//     var installerLibararyApps = new List( 'installer_libarary_apps', { valueNames: [ 'list_search' ] } );
//     $("#installer_libarary_apps input.search").focus();
//   };
//
// });
//
// // Init the progress bar
// var progressBarWidth = 0;
//
// // Increment the progress bar and add log line to page
// var process_builder_log_line = function(e) {
//   progressBarWidth = progressBarWidth + 1;
//   if ( progressBarWidth > 900 ) { progressBarWidth = 500 };
//   updateProgressBar();
//   new_line = e.data;
//   if (new_line !== '.') {
//     var new_html = ansi_up.ansi_to_html(new_line);
//     $("#installer_builder_log").prepend(new_html + '\n');
//   };
// };
//
// // Hide the progress bar and show complete
// var process_builder_log_eof = function(e) {
//   $('#installer_builder_complete').show();
//   $('#installer_builder_progress_bar').hide();
//   this.close();
// };
//
// // Update the progress bar
// var updateProgressBar = function() {
//   // alert(progressBarWidth);
//   $('#installer_builder_progress_bar').find('.progress-bar').css('width', (progressBarWidth/10).toString() + '%')
// };
