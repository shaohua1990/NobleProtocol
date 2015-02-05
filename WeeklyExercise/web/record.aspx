<%@ Page Language="C#" AutoEventWireup="true" CodeFile="record.aspx.cs" Inherits="web_record" %>

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
    
    <script>
        function record() {
            var running = $("#running").val();
            var pushup = $("#pushup").val();
            var situp = $("#situp").val();
            var reading = $("#reading").val();
            if (isNaN(parseFloat(running)))
                running = 0;
            if (isNaN(parseFloat(pushup)))
                pushup = 0;
            if (isNaN(parseFloat(situp)))
                situp = 0;
            if (isNaN(parseFloat(reading)))
                reading = 0;
            $.ajax({
                url: "process-record.aspx",
                dataType: "json",
                data: {
                    "action": "write",
                    "running": running,
                    "pushup": pushup,
                    "situp": situp,
                    "reading": reading
                },
                type: 'POST',
                success: function(data) {
                    if (!data[0].IsWrite) {
                        showModal(data[0].Content);
                    } else {
                        $("#running").val("");
                        $("#pushup").val("");
                        $("#situp").val("");
                        $("#reading").val("");
                    }
                },
                error: function() {
                    showModal("Server Error");
                }
            });
            event.preventDefault();
        }

        function showModal(text) {
            $('#post-response-alert-body').html(text);
            $('#postRecordModal').modal('show');
            setTimeout()
        }
    </script>

</head>
<body>
	<nav class="navbar navbar-default" role="navigation" style="background:#330099;position: relative;top:-40px">
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
	         <li><a href="friends.aspx">Friends</a></li> 
	      </ul>
	   </div>
	</nav>
    
    <div class="container"> 
      <form class="form-signin" role="form" method="post" id="form">  
        <div style="margin-bottom:10px;">
            <span class="spanPosition">Running: </span>
            <input id="running" class="form-control inputPosition" placeholder=0 name="running" style="margin-left:20px;"> 
        </div>    
        <div>
            <span class="spanPosition">Push Up: </span> 
        	<input id="pushup" class="form-control inputPosition" placeholder=0 name="pushup" style="margin-left:18px;"> 
        </div>    
         <div> 
        	<span class="spanPosition">Sit Up: </span> 
        	<input id="situp" type="text" class="form-control inputPosition" placeholder=0 name="situp" style="margin-left:40px;"> 
        </div>    
        <div> 
        	<span class="spanPosition">Reading: </span> 
        	<input id="reading" type="text" class="form-control inputPosition" placeholder=0 name="reading" style="margin-left:20px;"> 
        </div>    
        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="record();">Submit</button>
      </form> 
    </div> <!-- /container --> 
    
    <!-- modal to show post reponse after register, indicating to users sucess or failure -->
    <%=PostRecordModal %>
    
    <style>
        .inputPosition {
            float: left;
            width: 150px;
            margin-bottom: 10px !important;
        }

        .spanPosition {
            float: left;
            font-size: 20px;
            padding-top: 5px;
        }
    </style>
</body>
</html>