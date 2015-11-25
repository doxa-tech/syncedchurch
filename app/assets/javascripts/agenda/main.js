/* global angular */
"use strict";

var app = angular.module("Agenda", []);

app.filter("range", function() {
  return function(input, min, max) {
    min = parseInt(min);
    max = parseInt(max) + 1;
    for (var i=min; i<max; i++)
      input.push(i);
    return input;
  };
});

app.controller("MainController", ["$scope", function($scope) {

  var currentDate = new Date(),
      currentYear = currentDate.getFullYear(),
      currentMonth = currentDate.getMonth();

  var events = {
    "2015-11-16": { "description": "Soirée vision" },
    "2015-11-22": { "description": "Conseil d'église" }
  };

  $scope.events = {};

  var week = 1;
  $scope.events[week] = {};

  var weekModulo = (9 - new Date(currentYear, currentMonth, 1).getDay()) % 7;
  for(var iDay=1; iDay <= daysInMonth(currentMonth, currentYear); iDay ++) {

    if(iDay % 7 === weekModulo) { 
      week++; 
      $scope.events[week] = {};
    }

    var day = String(iDay);
    day = day.length < 2 ? "0" + day : day;
    var key = currentYear + "-" + (currentMonth + 1) + "-" + day;

    if(events[key] === undefined) {
      $scope.events[week][key] = null;
    } else {
      $scope.events[week][key] = events[key];
    }
  }

  $scope.weeksNumber = Object.keys($scope.events).length

  console.log($scope.events)

}]);

function daysInMonth(month, year) {
  return new Date(year, month, 0).getDate();
}