<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="web_login" %>

<!DOCTYPE html>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Sign In</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">  
	<script type="text/javascript" src="/js/jQuery/jquery-1.11.1.js"></script>
	<style type="text/css" src="/js/bootstrap/css/bootstrap.min.css"></style>
	<style type="text/css" src="/js/bootstrap/css/bootstrap-theme.min.css"></style>
	<script type="text/javascript" src="/js/bootstrap/js/bootstrap.min.js"></script>  
    
    <link href=/js/bootsex/dist/css/bootstrap.min.css rel="stylesheet">
    <link href=/js/bootsex/signin.css rel="stylesheet"> 
    <script src="/js/bootsex/assets/js/ie-emulation-modes-warning.js"></script> 
    <script src="/js/bootsex/assets/js/ie10-viewport-bug-workaround.js"></script> 
  
<%--    <script src="/js/ajax.js"></script>
    <script src="/js/gloalvar.js"></script>--%>
    <script> 
        function login() {
            var params = {};
            params.name = $("#username").val();
            params.password = $("#password").val();
            $.ajax({
                url: "process-login.aspx",
                data: params,
                dataType: 'json',
                type: 'POST',
                success: function(data) {
                    if (data[0].IsLogin) {
                        location = "home.aspx";
                    }
                }
            });
            event.preventDefault();
        }

        function register() {
            location = "register.aspx";
            event.preventDefault();
        }
    </script>
</head>
<body>
    <div class="container" > 
      <form class="form-signin" role="form">
        <h2 class="form-signin-heading">Please sign in</h2>
        <div id="usernameDiv"> 
        	<input id="username" type="text" class="form-control" placeholder="Username" name="username" required autofocus> 
        </div>
        <div id="passwordDiv"> 
        	<input id="password" type="password" class="form-control" placeholder="Password" name="password" required> 
        </div>
        <div class="checkbox"  onclick="remember();">
          <label>
            <input type="checkbox" value="remember-me" name="rememberme" value=1> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" onclick="login()">Sign in</button>  
        <button class="btn btn-lg btn-primary btn-block" onclick="register();">Register</button>  
      </form> 
    </div>
</body>
     
</html>

