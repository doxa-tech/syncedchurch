/* global angular */
"use strict";

var app = angular.module("Agenda", ["filters", "services", "directives"]);

angular.module("filters", []);
angular.module("services", []);
angular.module("directives", []);

app.controller("MainController", ["$scope", "Calendar", "$timeout", function($scope, Calendar, $timeout) {

  $scope.calendar = new Calendar();

  $scope.today = $scope.calendar.todayKey;

  $scope.currentMonth = $scope.calendar.currentMonth;

  $scope.calendar.loadEvents(function() {
    $scope.calendar.generateFirstMonth();
    $scope.weeks = $scope.calendar.weeks;

    $timeout(function() {
      var currentMonth = document.getElementById("current-month");
      nextMonthElement(currentMonth).setAttribute("id", "next-month");
    });

  });
}]);