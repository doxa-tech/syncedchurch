/* global angular */
"use strict";

var app = angular.module("Agenda", []);

app.filter("dayFromDate", function() {
  return function(input) {
    return input.split("-")[2];
  };
});

app.controller("MainController", ["$scope", function($scope) {

  $scope.events = {
    "2015-11-16": { "description": "Soirée vision" },
    "2015-11-22": { "description": "Conseil d'église" }
  };

  var today = Date.today();
  $scope.previousWeeks = [];
  $scope.nextWeeks = [];

  generateMonth();

  console.log($scope.nextWeeks);

  function generateMonth() {
    $scope.nextMonday = new Date(today.getFullYear(), today.getMonth(), 1).last().monday();
    $scope.lastMonday = angular.copy($scope.nextMonday).last().monday();
    for(var i=0;i<5;i++) {
      nextWeek();
    }
  }

  function generateWeek(day) {
    var week = {},
        day = angular.copy(day);
    for(var i=1; i <= 7; i++) {
      var key = day.getFullYear() + "-" + (day.getMonth() + 1) + "-" + day.getDate();
      if($scope.events[key] === undefined) {
        week[key] = null;
      } else {
        week[key] = $scope.events[key];
      }
      day.next().day()
    }
    return week
  }

  function nextWeek() {
    $scope.nextWeeks.push(generateWeek($scope.nextMonday));
    $scope.nextMonday.next().monday()
  }

  function previousWeek() {
    $scope.previousWeeks.push(generateWeek($scope.lastMonday));
    $scope.lastMonday.last().monday();
  }

}]);