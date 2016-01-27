/* global angular */
"use strict";

var app = angular.module("Agenda", ["filters", "services", "directives","ngDialog"]);

angular.module("filters", []);
angular.module("services", []);
angular.module("directives", []);

app.controller("MainController", ["$scope", "Calendar", "ngDialog", function($scope, Calendar, ngDialog) {

  $scope.calendar = new Calendar();

  $scope.today = $scope.calendar.todayKey;

  $scope.currentMonth = $scope.calendar.currentMonth;
  $scope.currentYear = $scope.calendar.currentYear;

  $scope.calendar.generateFirstMonth(function() {
    $scope.weeks = $scope.calendar.weeks;
  });

  $scope.open = function () {
    ngDialog.open({
        template: '<p>my template</p>',
        plain: true
    });
  };
}]);
