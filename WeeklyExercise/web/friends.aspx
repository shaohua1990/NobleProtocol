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
	      </ul>
	   </div>
	</nav>
    
    <div ng-app="FriendsListApp" ng-controller="FriendsListCtrl">
        <div id="FriendsList" style="position:relative;top:-20px;"> 
            <div class="panel panel-info" style="margin-bottom:0px" ng-repeat="friend in friends">
                <div id="{{friend.MemberID}}" class="panel-heading" style="padding:20px 15px" ng-click="getFriendRecord()">
                    <span class="group">
                        <b>{{friend.Name}}</b>
                    </span> 
                </div> 
            </div> 
        </div> 
        <div id="friendsRecord">
            <a class="list-group-item list-group-item-info">
                <p class="alert alert-warning" >    
                <b style="margin-right:20px;">Total Running: </b> {{total_running}}km <br/>
                <b style="margin-right:25px;">Total Pushup:  </b> {{total_pushup}} <br/>
                <b style="margin-right:40px;">Total Situp:   </b> {{total_situp}} <br/>
                <b style="margin-right:20px;">Total Reading: </b> {{total_reading}} <br/>
                </p>
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
        });

        function triggerAction() {
            
        }
    </script>
</body>
</html>
