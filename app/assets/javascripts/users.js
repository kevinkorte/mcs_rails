$(document).ready(function() {
  var t = $('#trial-time').data('trial');
  var start = moment();
  var end = moment.unix(t);
  var trial_end = end.from(start);
  $('#trial-time').html("<strong>Trial Ends:</strong> " + trial_end );
});
