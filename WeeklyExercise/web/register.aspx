<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="web_register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Exercise</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1 user-scalable=0">
    <meta name="description" content="">
    <meta name="author" content="shaohua">  
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
    <!--asi header-->
    <link href="/js/bootsex/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/js/bootsex/signin.css" rel="stylesheet"> 
    <script src="/js/bootsex/assets/js/ie-emulation-modes-warning.js"></script> 
    <script src="/js/bootsex/assets/js/ie10-viewport-bug-workaround.js"></script> 
    <script type="text/javascript" src="/js/bootstrap/js/modal.js"></script>   
    
    <%--<script src="/js/gloalvar.js"></script>
    <script src="/js/ajax.js"></script> 
    <script src="/js/LoadTemplate.js"></script>
    <script src="/js/EssentialLib.js"></script>
    <script src="/js/generic-gender.js"></script>
    <script src="/js/after-ajax.js"></script> --%>
    <script>
        function register() {
            var name = $('#name').val();
            var password = $('#password').val();
            var confirmPassword = $('#confirmPassword').val(); 

            if (!(name && password && confirmPassword)) {
                var text = "Pleas fill in all information";
                showModal(text);
            } else {
                if (password != confirmPassword) {
                    var text = "Password does not match!";
                    $('#confirmPassword').val("");
                    showModal(text);
                } else {
                    var params = {};
                    params.name = name;
                    params.password = password; 
                    SendRegisterRequest(params);
                }
            }
            event.preventDefault();
            return false;
        }

        function SendRegisterRequest(params) {
            $.ajax({
                url: "process-register.aspx",
                //contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: params,
                success: function (data) { 
                    if (data[0].fail) {
                        showModal(data[0].text);
                    } else {
                        location = "home.aspx";
                    }
                },
                error: function() {
                    showModal("Server Error!");
                },
                type: 'POST'
            });
        }

        function showModal(text) {
            $('#post-register-alert-body').html(text);
            $('#postRegisterModal').modal('show');
        }
    </script>

</head>
<body>  
	<div class="container"> 
      <form class="form-signin" role="form" method="post" id="form"> 
        <h2 class="form-signin-heading">Please Register Here</h2>
        <div> 
        	<input id="name" type="text" class="form-control" placeholder="Name" name="name"> 
        </div>    
        <div> 
        	<input id="password" type="password" class="form-control" placeholder="Password" name="password"> 
        </div>    
         <div> 
        	<input id="confirmPassword" type="password" class="form-control" 
                placeholder="Confirm Password" name="confirmPassword"> 
        </div>       
        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="register();">Submit</button>
      </form> 
    </div> <!-- /container --> 

	<!-- modal to show post reponse after register, indicating to users sucess or failure -->
    <%=PostRegisterModal %>
</body>
</html>

