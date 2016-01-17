$(document).on("ready page:load", function() {

  dateTimePicker();

});

function dateTimePicker() {
  $(".time.picker").timepicker({
    timeFormat: "H:i"
  });
  var datePicker = $(".date.picker").datepicker({
    language: "fr-CH",
    autoclose: "true"
  });
  datePicker.on("show", function() {
    $(document).on("mousewheel scroll", updateCalendarPosition)
  });
  datePicker.on("hide", function() {
    $(document).off("mousewheel scroll", updateCalendarPosition)
  });

  var picker = document.getElementById("picker");
  if(picker !== null) {
    var datepair = new Datepair(picker);
  }
}

function updateCalendarPosition() {
  $(".date.picker").datepicker("place")
}
