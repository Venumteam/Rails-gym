angular.module('app').controller('ProfileCtrl', function($scope, Restangular, $timeout) {
  $scope.planFields = [
    {
      day: 'Понедельник',
      body: 'Спина, Трапеция и Бицепс'
    },
    {
      day: 'Вторник',
      body: 'Плечи, Грудь и Трицепс'
    },
    {
      day: 'Среда',
      body: 'Отдых'
    },
    {
      day: 'Четверг',
      body: 'Бицепс, Пресс и спина'
    },
    {
      day: 'Пятница',
      body: 'Плечи, Ноги и Пресс'
    },
    {
      day: 'Суббота',
      body: 'Кардио'
    },
    {
      day: 'Воскресенье',
      body: 'Отдых'
    }
  ];

  $scope.successfulAvatarCropHandler = successfulAvatarCropHandler;

  function successfulAvatarCropHandler(responce) {
    var currentUser = $scope.currentUser;
    currentUser.customPUT(_.extend(currentUser, {avatar_data_uri: responce})).then(function(responce) {
      currentUser.avatar_url = responce.avatar_url
    });

    return currentUser;
  }

  $scope.labels = ["Download Sales", "In-Store Sales", "Mail-Order Sales", "Tele Sales", "Corporate Sales"];
  $scope.series = ['Series A', 'Series B'];
  $scope.data =  [65, 59, 80, 81, 56, 55, 40];
  $scope.lineData = [
    [65, 59, 80, 81, 56, 55, 40],
    [28, 48, 40, 19, 86, 27, 90]
  ];
  $scope.type = 'PolarArea';

});
