<%@ Page Language="C#" AutoEventWireup="true" CodeFile="friends.aspx.cs" Inherits="web_friends" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1 user-scalable=0">
    <meta name="description" content="">
    <meta name="author" content="">  
	<script type="text/javascript" src="/js/jQuery/jquery-1.11.1.js"></script>
	<link href="/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="/js/bootstrap/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="/js/bootstrap/css/datepicker3.css" rel="stylesheet">
	<script type="text/javascript" src="/js/bootstrap/js/bootstrap.min.js"></script> 
    <script type="text/javascript" src="/js/bootstrap/js/bootstrap-datepicker.js"></script> 
    
    <style type="text/css">
        #otherPageMenu li a{
            color: white;
        } 
    </style>

    <link href=/js/bootsex/dist/css/bootstrap.min.css rel="stylesheet">
    <link href=/js/bootsex/signin.css rel="stylesheet"> 
    <script src="/js/bootsex/assets/js/ie-emulation-modes-warning.js"></script> 
    <script src="/js/bootsex/assets/js/ie10-viewport-bug-workaround.js"></script> 
    <script type="text/javascript" src="/js/bootstrap/js/modal.js"></script> 
    
    <script src="/js/angular.js"></script>  
</head>
<body style="position:relative;top:-40px;">
    <nav class="navbar navbar-default" role="navigation" style="background:#330099">
	   <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" 
	         data-target="#otherPageMenu">
	         <span class="sr-only">Toggle navigation</span>
	         <span class="icon-bar"></span>
	         <span class="icon-bar"></span>
	         <span class="icon-bar"></span>
	      </button> 
	   </div>
	   <div class="collapse navbar-collapse" id="otherPageMenu">
	      <ul class="nav navbar-nav">
	         <li><a href="home.aspx">Home</a></li> 
	         <li><a href="record.aspx">Add Record</a></li> 
	         <li><a href="friends.aspx">Friends</a></li>
	      </ul>
	   </div>
	</nav>
    
    <div ng-app="FriendsListApp" ng-controller="FriendsListCtrl">
        <div id="FriendsList" style="position:relative;top:-20px;"> 
            <div class="panel panel-info" style="margin-bottom:0px" ng-repeat="friend in friends">
                <div id="{{friend.MemberId}}" class="panel-heading" style="padding:20px 15px" ng-click="getFriendRecord(this)">
                    <span class="group">
                        <b>{{friend.Name}}</b>
                    </span> 
                </div> 
            </div> 
        </div> 

        <div id="friendsRecord" style="display: none;position: relative;top: -20px">
            <a class="list-group-item list-group-item-info">
                <div style="display: inline-block;width: 100%">
                <div style="width: 50%;float: left">
                <p class="alert alert-warning" > 
                    <b style="margin-right:20px;">This Week</b><br/> 
                    <b style="margin-right:20px;">Total Running: </b> {{total_running}}km <br/>
                    <b style="margin-right:25px;">Total Pushup:  </b> {{total_pushup}} <br/>
                    <b style="margin-right:40px;">Total Situp:   </b> {{total_situp}} <br/>
                    <b style="margin-right:20px;">Total Reading: </b> {{total_reading}} <br/>
                </p>
                </div>
                <div style="width: 50%;display: inline-block">
                <p class="alert alert-warning" > 
                    <b style="margin-right:20px;">Last Week</b><br/> 
                    <b style="margin-right:20px;">Total Running: </b> {{last_total_running}}km <br/>
                    <b style="margin-right:25px;">Total Pushup:  </b> {{last_total_pushup}} <br/>
                    <b style="margin-right:40px;">Total Situp:   </b> {{last_total_situp}} <br/>
                    <b style="margin-right:20px;">Total Reading: </b> {{last_total_reading}} <br/>
                </p>
                </div>
                </div>
            </a>
            <a class="list-group-item list-group-item-info" ng-repeat="record in records">
                <p class="{{getClassName(record.recordClass)}}" >  
                <b style="margin-right:46px;">Date:    </b> {{record.tstamp}} <br/>  
                <b style="margin-right:20px;">Running: </b> {{record.running.toFixed(1)}}km <br/>
                <b style="margin-right:25px;">Pushup:  </b> {{record.pushup}} <br/>
                <b style="margin-right:40px;">Situp:   </b> {{record.situp}} <br/>
                <b style="margin-right:20px;">Reading: </b> {{record.reading}} <br/>
              </p>
            </a>
        </div> 
    </div>
    
    
    
    <script>
        var FriendsListApp = angular.module("FriendsListApp", []);
        FriendsListApp.controller("FriendsListCtrl", function ($scope, $http) {
            $http.get("friends-data.aspx?why=displayFriendList").success(
            function (response) {
                $scope.friends = response;  
            });

            $scope.getFriendRecord = function () {
                elem = event.srcElement;
                while (!elem.id) {
                    elem = elem.parentNode;
                }
                var id = elem.id;
                $http.get("process-record.aspx?action=readFirendsRecord&friendId="+id).success(
                function (response) {
                    $scope.records = response;
                    $("#friendsRecord").css("display", "block");
                    $("#FriendsList").css("display", "none");
                    $scope.total_running = 0;
                    $scope.total_pushup = 0;
                    $scope.total_situp = 0;
                    $scope.total_reading = 0;
                    for (var i = 0; i < response.length; i++) {
                        $scope.total_running += response[i].running;
                        $scope.total_pushup += response[i].pushup;
                        $scope.total_situp += response[i].situp;
                        $scope.total_reading += response[i].reading;
                    }
                    $scope.total_running = $scope.total_running.toFixed(1);
                });
                $http.get("process-record.aspx?action=readFriendLastWeekTotal&friendId="+id).success(
                function (response) {
                    $scope.last_total_running = 0;
                    $scope.last_total_pushup = 0;
                    $scope.last_total_situp = 0;
                    $scope.last_total_reading = 0;
                    if (response[0].lastweek_total_running)
                        $scope.last_total_running = response[0].lastweek_total_running.toFixed(1);
                    if (response[0].lastweek_total_pushup)
                        $scope.last_total_pushup = response[0].lastweek_total_pushup;
                    if (response[0].lastweek_total_situp)
                        $scope.last_total_situp = response[0].lastweek_total_situp;
                    if (response[0].lastweek_total_reading)
                        $scope.last_total_reading = response[0].lastweek_total_reading;
                });
            }

            $scope.getClassName = function (param) {
                if (param)
                    return "alert alert-warning";
                return "alert alert-success";
            }
        }); 
    </script>
</body>
</html>
