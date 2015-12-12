/* global angular */
"use strict";

var module = angular.module("directives");

module.directive("monthAttributes", function() {

  return function(scope, element, attrs) {
    if(attrs.monthAttributes !== "") {
      element[0].classList.add("has-month");
    }
    if(attrs.monthAttributes === scope.currentMonth) {
      element[0].id = "current-month";
    }
  };

});