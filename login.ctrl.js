angular.module('hg.jobmapping')    
.controller('hg.jobmapping.login.controller', ['$rootScope', '$scope', '$state', 'MasterDataService', 'HG', 'util', 'AuthService',
      'AuthHttp', '$http', 'Channel', 'JobMappingWebService', '$translate', 'PageService',
  function($rootScope, $scope, $state, MasterDataService, HG, util, AuthService, AuthHttp, $http, Channel, JobMappingWebService,
      $translate, PageService){
    
    PageService.navigateAwayEvent();
    
    $scope.loginError = false;
    var authToken = localStorage.getItem(HG.TOKEN_KEY);
    var userId = localStorage.getItem(HG.USERID_KEY);
    $scope.ready = false;
    if(authToken && userId){
      AuthService.token(authToken);

      var url = HG.BASE_API_URL + '/v1/users/' + userId;
      AuthHttp.get(url).success(function(res){
        var data = res.data;
        if(data){
          $state.go('jobmapping.step1');
        }
        else{
          $scope.ready = true;
        }
      }).error(function(){
        $scope.ready = true;
      });
    }
    else{
      $scope.ready = true;
    }
    
    $rootScope.$on('$translateChangeSuccess', function () {
        $scope.ExampleUsername=$translate.instant("ExampleUsername");
        $scope.Password=$translate.instant("Password");
      });
    
    setTimeout(function(){
      $translate.refresh();
    }, 100);

    $scope.submit = function(){
      var baseUrl = HG.BASE_API_URL + '/v1';
      var data = { username: $scope.email,
                   password: $scope.password,
                   checkedStatus: false };
      util.refresh($scope, function(){
        $scope.loggingIn = true;
      });

      MasterDataService.setReupload(false);
      $http.post(baseUrl + '/actions/login', data)
        .success(function(data, status, headers, config){
          $scope.loggingIn = false;
          $scope.loginError = false;
          $translate.refresh();
          if(data.data) data = data.data;
          AuthService.token(data.authToken);
          AuthService.userId(data.userId);
          if(data.clientId){ AuthService.clientId(data.clientId); }
          //AuthService.clientId(17199);
          //AuthService.countryId(225);
					$state.user = {};
					$state.user.username = data.username;
					// set cookie for isRestricted for header.directive
					var
						regex = /^(user|demo)\.(\w|\W)+\@haygroup\.com$/i;
						isRestrictedCookie = document.cookie = "isRestricted=" + regex.test($state.user.username);
            JobMappingWebService.get('subscriptions', AuthService.clientId()).then(function(res){
            MasterDataService.subscriptions = res;
            AuthService.clientId(res.groups[0].clientId);
						AuthService.countryId(res.groups[0].subGroups[0].countryId);
            MasterDataService.loadLocal();
            MasterDataService.getData().then(function(){
              if(MasterDataService.empty()){
                MasterDataService.makeUnreadyIfEmpty();
                $state.go('jobmapping.step' + Channel.uploadPageNumber);
              }
              else{
                if(MasterDataService.data.step > Channel.dashboardPageNumber){
                  MasterDataService.data.step = Channel.dashboardPageNumber
                }
                $state.go('jobmapping.step' + Channel.dashboardPageNumber);
              }
            });
          });
        }).error(function(data, status, headers, config){
          window.err = $scope;
          $scope.responseMessage = data ? data.responseMessage : '';
          util.refresh($scope, function(){
            $scope.loggingIn = false;
          });
          $scope.loginError = true;

          console.log('login error');
        });
    };
    
    $(document).ready(function(){
      $("input").keydown(function(event){
          if(event.keyCode == 13){
              $(".submit").click();
          }
      });
    });

  }
]);