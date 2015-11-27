/* global angular */
"use strict";

var module = angular.module("filters");

app.filter("dayFromDate", function() {
  return function(input) {
    return input.split("-")[2];
  };
});