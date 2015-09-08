$(document).on("ready page:load", function() {

  $('#selectize-member').selectize({
    valueField: 'id',
    labelField: 'full_name',
    searchField: 'full_name',
    load: function(query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: '/api/members',
        type: 'GET',
        data: 'query=' + query,
        dataType: 'json',
        error: function() {
          callback();
        },
        success: function(res) {
          callback(res);
        }
      });
    }
  });

});