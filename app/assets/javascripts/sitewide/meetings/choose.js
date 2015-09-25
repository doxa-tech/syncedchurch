/* global $ */
"use strict";

$(document).on("ready page:load", function() {
  
  $("#choose-group-meeting").click(function() {
    var id = $("#meeting_group_id").val();
    window.location.href = "/groups/" + id + "/meetings/new";
  });

});