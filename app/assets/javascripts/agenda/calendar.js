/* global angular */
"use strict";

var module = angular.module("services");

module.factory("Calendar", ["$http", function($http) {

  var Calendar = function() {

    var dateKey = function(day) {
      return day.getFullYear() + "-" + (day.getMonth() + 1) + "-" + day.getDate();
    };

    var loadEvents = function(callback, from, to) {
      $http.get("api/events.json", { params: { from: from, to: to }}).then(function(response) {
        events = response.data;
        callback();
      });
    };

    this.loadPreviousEvents = function(callback, n) {
      n = n || -4;
      var to = dateKey(angular.copy(firstMonday).add(1).week()),
          from = dateKey(angular.copy(firstMonday).add(n + 1).weeks());
      loadEvents(callback, from, to);
    };

    this.loadNextEvents = function(callback, n) {
      n = n || 4;
      var from = dateKey(lastMonday),
          to = dateKey(angular.copy(lastMonday).add(n).weeks());
      loadEvents(callback, from, to);
    };

    this.generateFirstMonth = function(callback) {
      var calendar = this;
      this.loadNextEvents(function() {
        calendar.nextWeek(6);
        callback();
        angular.element(document).ready(function () {
          document.getElementById("fixed").dispatchEvent(new Event("scroll"));
        });
      }, 6);
    };

    var generateWeek = function(day) {
      var week = {};
      day = angular.copy(day);
      for(var i=1; i <= 7; i++) {
        var key = dateKey(day);
        week[key] = { "number": key.split("-")[2] };
        if(events[key] === undefined) {
          week[key].events = [];
        } else {
          week[key].events = events[key];
        }
        if(day.getDate() <= 7 && day.is().sunday()) {
          week.month = monthNames[day.getMonth()];
        }
        day.next().day();
      }
      return week;
    };

    this.nextWeek = function(n) {
      n = n || 4;
      for(var i=1; i <= n; i++) {
        this.weeks.push(generateWeek(lastMonday));
        lastMonday.add(1).weeks();
      }
    };

    this.previousWeek = function(n) {
      n = n || 4;
      for(var i = 1; i <= n; i++) {
        this.weeks.unshift(generateWeek(firstMonday));
        firstMonday.add(-1).weeks();
      }
    };

    var today = Date.today();

    var firstDay = new Date(today.getFullYear(), today.getMonth(), 1),
        lastMonday = firstDay.is().monday() ? firstDay : firstDay.last().monday(),
        firstMonday = angular.copy(lastMonday).add(-1).weeks();

    var events = [];

    this.weeks = [];
    this.todayKey = dateKey(today);

    var monthNames = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
      "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

    this.currentMonth = monthNames[today.getMonth()];
  };
  return Calendar;
}]);
