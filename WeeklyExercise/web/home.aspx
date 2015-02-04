<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="web_home" %>

 <html>
<head id="Head1" runat="server">
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
<body style="position: relative;top:-40px">
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
	         <li><a href="record.aspx">Add Record</a></li> 
	         <li><a href="friends.aspx">Friends</a></li> 
	      </ul>
	   </div>
	</nav>
    
    <div style="position: relative;top:-20px" ng-app="RecordDisplayApp" ng-controller="RecordDisplayCtrl">
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
    
    <script>
        var RecordDisplayApp = angular.module("RecordDisplayApp", []);
        RecordDisplayApp.controller("RecordDisplayCtrl", function ($scope, $http) {
            $http.get("process-record.aspx?action=readForHomeDisplay").success(
            function(response) {
                $scope.records = response;
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

            $scope.getClassName = function(param) {
                if (param)
                    return "alert alert-warning";
                return "alert alert-success";
            }
        });
    </script>
</body>
</html>