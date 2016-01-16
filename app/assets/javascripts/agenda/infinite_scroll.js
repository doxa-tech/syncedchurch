/* global angular */
"use strict";

var module = angular.module("directives");

module.directive("infiniteScrollDown", function() {
  return function(scope, element) {
    var $element = element[0];
    element.bind("scroll", function() {
      if(!scope.loading && $element.scrollTop + $element.offsetHeight >= $element.scrollHeight - 150) {
        scope.loading = true;
        scope.calendar.loadNextEvents(function() {
          scope.weeks = scope.calendar.weeks;
          scope.loading = false;
        });
      }
    });
  };
});

module.directive("infiniteScrollUp", function() {
  return function(scope, element) {
    var $element = element[0];
    element.bind("scroll", function() {
      if (!scope.loading && $element.scrollTop <= 150) {
        scope.loading = true;
        scope.calendar.loadPreviousEvents(function() {
          var scrollHeight = $element.scrollHeight,
              scrollTop = $element.scrollTop;
          var watcher = scope.$watch("weeks", function() {
            $element.scrollTop = $element.scrollHeight - scrollHeight + scrollTop;
            scope.loading = false;
            watcher(); // destroy the watch
          });
          scope.weeks = scope.calendar.weeks;
        });
      }
    });
  };
});
