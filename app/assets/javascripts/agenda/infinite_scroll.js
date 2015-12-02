/* global angular */
"use strict";

var module = angular.module("directives");

module.directive('infiniteScrollDown', function() {
  return function(scope, element, attr) {
    var $element = element[0]
    element.bind('scroll', function() {
      if ($element.scrollTop + $element.offsetHeight >= $element.scrollHeight - 150) {
        scope.calendar.loadEvents(function() { 
          scope.calendar.nextWeek()
          scope.weeks = scope.calendar.weeks;
        });
      }
    });
  };
});

module.directive('infiniteScrollUp', ["$timeout", function($timeout) {
  return function(scope, element, attr) {
    var $element = element[0];
    element.bind('scroll', function() {
      if ($element.scrollTop <= 150 && !scope.loading) {
        scope.loading = true;        
        scope.calendar.loadEvents(function() {
          var scrollHeight = $element.scrollHeight,
              scrollTop = $element.scrollTop;
          scope.calendar.previousWeek();
          scope.weeks = scope.calendar.weeks;
          $timeout(function() {
            $element.scrollTop = $element.scrollHeight - scrollHeight + scrollTop;
            scope.loading = false;
          });
        });
      }
    });
  };
}]);