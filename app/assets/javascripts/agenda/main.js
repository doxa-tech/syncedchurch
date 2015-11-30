/* global angular */
"use strict";

var app = angular.module("Agenda", ["filters"]);

angular.module("filters", []);

app.directive('infiniteScrollDown', function() {
  return function(scope, element, attr) {
    var $element = element[0]
    element.bind('scroll', function() {
      if ($element.scrollTop + $element.offsetHeight >= $element.scrollHeight - 150) {
        scope.$apply(attr.infiniteScrollDown);
      }
    });
  };
});

app.directive('infiniteScrollUp', ["$timeout", function($timeout) {
  return function(scope, element, attr) {
    //scope.$eval(attr.infiniteScrollUp);

    var $element = element[0]
    $timeout(function() {
      $element.scrollTop = $element.scrollHeight;          
    });  

    element.bind('scroll', function() {
      if ($element.scrollTop <= 150) {
        var scrollHeight = $element.scrollHeight
        scope.$apply(attr.infiniteScrollUp);
        $element.scrollTop = $element.scrollHeight - scrollHeight;
      }
    });
  };
}]);

app.controller("MainController", ["$scope", "$http", function($scope, $http) {

  $scope.nextWeek = function() { nextWeek(); };
  $scope.previousWeek = function() { previousWeek(); };

  // $scope.events = {
  //   "2015-11-2": [{ "description": "Groupe de maison" }],
  //   "2015-11-13": [{ "description": "Séminaire prophétique" }, {"description": "Groupe de maison"}],
  //   "2015-11-16": [{ "description": "Soirée vision" }],
  //   "2015-11-22": [{ "description": "Conseil d'église" }]
  // };

  var today = Date.today(),
      lastMonday = null,
      firstMonday = null;

  $scope.weeks = [];

  $http.get("api/events.json").success(function(events) {
    $scope.events = events;

    generateMonth();
  });

  function generateMonth() {
    var firstOfTheMonth = new Date(today.getFullYear(), today.getMonth(), 1);
    if(firstOfTheMonth.is().monday()) { 
      lastMonday = firstOfTheMonth;
    } else {
      lastMonday = firstOfTheMonth.last().monday();
    }

    firstMonday = angular.copy(lastMonday).last().monday();

    while(lastMonday.getMonth() !== today.getMonth() + 1) {
      nextWeek();
      try {
        $scope.weeks[$scope.weeks.length - 1][dateKey(today)]["current_day"] = "true";
      } catch(err) {}
    }
  }

  function generateWeek(day) {
    var week = {},
        day = angular.copy(day);
    for(var i=1; i <= 7; i++) {
      var key = dateKey(day);
      week[key] = {};
      if($scope.events[key] === undefined) {
        week[key]["events"] = [];
      } else {
        week[key]["events"] = $scope.events[key];
      }
      day.next().day();
    }
    return week;
  }

  function nextWeek() {
    $scope.weeks.push(generateWeek(lastMonday));
    lastMonday.next().monday();
  }

  function previousWeek() {
    $scope.weeks.unshift(generateWeek(firstMonday));
    firstMonday.last().monday();
  }

  function dateKey(day) {
    return day.getFullYear() + "-" + (day.getMonth() + 1) + "-" + day.getDate();
  }

}]);