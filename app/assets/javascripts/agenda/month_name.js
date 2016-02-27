/* global angular */
"use strict";

var module = angular.module("directives");

module.directive("monthName", [function() {

  return function(scope, element) {

    var $ = { "currentMonth": null, "nextMonth": null, "previousMonth": null };

    element.bind("scroll", function() {
      if(scope.ready) {

        $.currentMonth = $.currentMonth || document.getElementById("current-month");
        $.nextMonth = $.nextMonth || document.getElementById("next-month") || nextMonthElement($.currentMonth);
        $.previousMonth = $.previousMonth || document.getElementById("previous-month") || previousMonthElement($.currentMonth);

        if($.nextMonth !== null && offset($.nextMonth).top < 100) {
          updateMonthName(scope, $.nextMonth);
          $ = updateSelectors($, "nextMonth", "previousMonth", nextMonthElement);
        }

        if($.previousMonth !== null && offset($.previousMonth).top > -200) {
          updateMonthName(scope, $.previousMonth);
          $ = updateSelectors($, "previousMonth", "nextMonth", previousMonthElement);
        }

      } else {

        $ = { "currentMonth": null, "nextMonth": null, "previousMonth": null };
        
      }
    });
  };
}]);

function updateMonthName(scope, element) {
  scope.$apply(function() {
    var monthName = element.getElementsByClassName("month-name")[0].innerHTML;
    if(monthName !== scope.currentMonth) {
      updateYear(scope, monthName)
      scope.currentMonth = monthName;
    }
  });
}

function updateYear(scope, monthName) {
  if(monthName === "Janvier" && scope.currentMonth === "Décembre") {
    scope.currentYear++;
  } else if(monthName === "Décembre" && scope.currentMonth === "Janvier") {
    scope.currentYear--;
  }
}

function updateSelectors($, mainSelector, secondSelector, callback) {
  if($[secondSelector] !== null) { $[secondSelector].removeAttribute("id"); }
  $[mainSelector].setAttribute("id", "current-month");
  $.currentMonth.setAttribute("id", "previous-month");
  $.currentMonth = $[mainSelector];
  $[secondSelector] = $.currentMonth;
  $[mainSelector] = callback($[mainSelector]);
  return $;
}

function offset(element) {
  var rect = element.getBoundingClientRect(), bodyElt = document.body;
  return {
    top: rect.top + bodyElt .scrollTop,
    left: rect.left + bodyElt .scrollLeft
  };
}

function nextMonthElement(element) {
  var nextElement = element.nextElementSibling;
  return findMonthElement(nextElement, "next-month", nextMonthElement);
}

function previousMonthElement(element) {
  var previousElement = element.previousElementSibling;
  return findMonthElement(previousElement, "previous-month", previousMonthElement);
}

function findMonthElement(element, id, callback) {
  if(element !== null) {
    if(element.classList.contains("has-month")) {
      element.setAttribute("id", id);
      return element;
    } else {
      return callback(element);
    }
  } else {
    return null;
  }
}
