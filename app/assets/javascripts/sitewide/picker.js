$(document).on("ready page:load", function() {
  $('.time.picker').timepicker({
    timeFormat: 'H:i'
  });
  $('.date.picker').datepicker({
    language: 'fr-CH',
    autoclose: 'true'
  });

  var picker = document.getElementById('picker');
  if(picker !== null) {
    var datepair = new Datepair(picker);
  }
});
