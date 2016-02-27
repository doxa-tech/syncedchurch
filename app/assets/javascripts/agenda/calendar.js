/* global angular */
"use strict";

var module = angular.module("services");

module.factory("Calendar", ["$http", function($http) {

  var Calendar = function(categories) {

    var dateKey = function(day) {
      return day.getFullYear() + "-" + (day.getMonth() + 1) + "-" + day.getDate();
    };

    var loadEvents = function(callback, from, to) {
      var options = { params: { "from": from, "to": to, "categories[]": categories }}
      $http.get("api/events.json", options).then(function(response) {
        callback(response.data);
      });
    };

    this.loadPreviousEvents = function(callback, n) {
      n = n || -4;
      var to = dateKey(angular.copy(firstMonday).add(6).days()),
          from = dateKey(angular.copy(firstMonday).add(n + 1).weeks());

      firstMonday.add(n).weeks();
      loadEvents(function(events) {
        calendar.weeks = events.concat(calendar.weeks);
        callback();
      }, from, to);
    };

    this.loadNextEvents = function(callback, n) {
      n = n || 4;
      var from = dateKey(lastMonday),
          to = dateKey(angular.copy(lastMonday).add(n*7 - 1).days());

      lastMonday.add(n).weeks();
      loadEvents(function(events) {
        calendar.weeks = calendar.weeks.concat(events);
        callback();
      }, from, to);
    };

    this.generateFirstMonth = function(callback) {
      this.loadNextEvents(function() {
        callback();
        angular.element(document).ready(function () {
          document.getElementById("fixed").dispatchEvent(new Event("scroll"));
        });
      }, 6);
    };

    var today = Date.today();

    var firstDay = new Date(today.getFullYear(), today.getMonth(), 1),
        lastMonday = firstDay.is().monday() ? firstDay : firstDay.last().monday(),
        firstMonday = angular.copy(lastMonday).add(-1).weeks();

    var events = [];
    var calendar = this;

    this.weeks = [];
    this.todayKey = dateKey(today);

    var monthNames = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
      "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

    this.currentMonth = monthNames[today.getMonth()];
    this.currentYear = today.getFullYear();
  };
  return Calendar;
}]);
