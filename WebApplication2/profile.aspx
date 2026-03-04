<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="WebApplication2.profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EMS Connect - Login</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            height: 100%;
            background-color: #f4f4f4;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        .login-left {
            flex: 1;
            padding: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-right {
            flex: 1;
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                        url('https://images.unsplash.com/photo-1587745416684-47953f16f02f?auto=format&fit=crop&w=2000');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .login-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h1 {
            color: #e74c3c; /* Red color */
            margin-bottom: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        .form-control:focus {
            outline: none;
            border-color: #e74c3c; /* Red color */
            box-shadow: 0 0 0 2px rgba(231, 76, 60, 0.2); /* Red shadow */
        }

        .btn-login {
            width: 100%;
            padding: 0.75rem;
            background-color: #e74c3c; /* Red color */
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-login:hover {
            background-color: #c0392b; /* Darker red */
        }

        .login-footer {
            text-align: center;
            margin-top: 1.5rem;
        }

        .login-footer a {
            color: #e74c3c; /* Red color */
            text-decoration: none;
        }

        .login-footer a:hover {
            text-decoration: underline;
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .remember-me input {
            margin-right: 0.5rem;
        }

        .nav-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding: 1rem 0;
            background-color: rgba(231, 76, 60, 0.9); /* Red color */
        }

        .nav-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .nav-logo {
            color: white;
            font-size: 1.8em;
            font-weight: bold;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
            font-size: 1.1em;
            transition: color 0.3s ease;
            position: relative;
        }

        .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -5px;
            left: 0;
            background-color: white;
            transition: width 0.3s ease;
        }

        .nav-link:hover:after {
            width: 100%;
        }

        .error-message {
            color: #dc3545;
            margin: 10px 0;
            padding: 10px;
            border-radius: 4px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <nav class="nav-container">
        <div class="nav-content">
            <a href="home.aspx" class="nav-logo">Rescue Med</a>
            <div class="nav-links">
                <a href="Features.aspx" class="nav-link">Features</a>
                <a href="About us.aspx" class="nav-link">About</a>
               
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="login-left">
            <div class="login-card">
                <div class="login-header">
                    <h1>Welcome Back</h1>
                    <p>Enter your credentials to access your account</p>
                    <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false" ForeColor="Red"></asp:Label>
                </div>
                <form id="loginForm" runat="server">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" class="form-control" placeholder="Enter your email" required=""></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <asp:TextBox ID="txtpass" runat="server" class="form-control" placeholder="Enter your password" TextMode="Password" required=""></asp:TextBox>
                    </div>

                    <div>
                      <asp:Label ID="lblMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
                    </div>
                    <div class="remember-me">
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                        <label for="remember">Remember me</label>
                    </div>
                    <asp:Button ID="btnlogin" runat="server" Text="Sign In" class="btn-login" OnClick="btnlogin_Click1"  />
                    <div class="login-footer">
                        <p>Don't have an account? <a href="train.aspx">Sign up</a></p>
                        <p><a href="#">Forgot password?</a></p>
                    </div>
                </form>
            </div>
        </div>
        <div class="login-right">
            <h2>Your Lifeline in Emergencies</h2>
            <p>Join our network of first responders and medical professionals to save lives and improve emergency response.</p>
        </div>
    </div>
    <!--Start of Tawk.to Script-->
<script type="text/javascript">
var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/67df65bd48d5101912fd9250/1in0aardv';
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})();
</script>
<!--End of Tawk.to Script-->
</body>
</html>