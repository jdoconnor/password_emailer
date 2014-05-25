var noteApp = angular.module('noteApp', []);

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

noteApp.controller('NoteController', function($scope, $http) {

  $scope.notes = [];

  // Get the note by id if id is defined
  id = getParameterByName('id')
  if (id != '') {
    $http.get('/notes/' + id)
      .success(function(notes) {
        $scope.loaded = true;
        $scope.notes = notes;
      }).error(function(err) {
        alert(err);
      });
  }
  $scope.addNote = function(name, secret) {
    $http.post('/notes', {
      name: name,
      secret: secret
    }).success(function(note) {
      $scope.newNoteName = '';
      $scope.newNoteSecret = '';
    }).error(function(err) {
      // Alert if there's an error
      return alert(err.message || "an error occurred");
    });
  };
});
