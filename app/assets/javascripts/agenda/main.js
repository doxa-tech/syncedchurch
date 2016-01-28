/* global angular */
"use strict";

var app = angular.module("Agenda", ["filters", "services", "directives"]);

angular.module("filters", []);
angular.module("services", []);
angular.module("directives", []);

app.controller("MainController", ["$scope", "Calendar", function($scope, Calendar) {

  $scope.calendar = new Calendar();

  $scope.today = $scope.calendar.todayKey;

  $scope.currentMonth = $scope.calendar.currentMonth;
  $scope.currentYear = $scope.calendar.currentYear;

  $scope.calendar.generateFirstMonth(function() {
    $scope.weeks = $scope.calendar.weeks;
  });

}]);
