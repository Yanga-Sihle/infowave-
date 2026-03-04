<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Features.aspx.cs" Inherits="WebApplication2.Features" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EMS Connect - Features</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            scroll-behavior: smooth;
            background-color: #f4f4f4;
        }

        .nav-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding: 15px 0;
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

        .features-section {
            padding: 100px 20px 50px;
            text-align: center;
            background-color: white;
        }

        .features-section h2 {
            color: #e74c3c; /* Red color */
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        .features-section p {
            color: #333;
            font-size: 1.1em;
            max-width: 800px;
            margin: 0 auto 50px;
        }

        .features-grid {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
        }

        .feature-card img {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            color: #e74c3c; /* Red color */
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .feature-card p {
            color: #666;
            font-size: 1em;
        }

        .footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: 50px;
        }

        .footer p {
            margin: 0;
        }
    </style>
</head>
<body>
    <nav class="nav-container">
        <div class="nav-content">
            <a href="Default.aspx" class="nav-logo">Rescue Med</a>
            <div class="nav-links">
              <a href="WebForm2.aspx" class="nav-link">Home</a>

<a href="Features.aspx" class="nav-link">Features</a>

<a href="About.aspx" class="nav-link">About</a>

<a href="Contact.aspx" class="nav-link">Contact</a>

            </div>
        </div>
    </nav>

    <section class="features-section">
        <h2>Key Features</h2>
        <p>Discover the powerful features of Rescue Med designed to improve emergency medical response and save lives.</p>
        <div class="features-grid">
            <div class="feature-card">
                <img src="https://via.placeholder.com/80" alt="Quick Response Icon" />
                <h3>Quick Response</h3>
                <p>Get immediate assistance with our rapid emergency response system. Every second counts in saving lives.</p>
            </div>
            <div class="feature-card">
                <img src="https://via.placeholder.com/80" alt="Real-Time Tracking Icon" />
                <h3>Real-Time Tracking</h3>
                <p>Track ambulances and responders in real-time for faster and more efficient emergency response.</p>
            </div>
            <div class="feature-card">
                <img src="https://via.placeholder.com/80" alt="Community Network Icon" />
                <h3>Community Network</h3>
                <p>Connect with trained local first responders and medical professionals in your area.</p>
            </div>
        </div>
    </section>

    <footer class="footer">
        <p>&copy; 2024 Rescue Med All rights reserved.</p>
    </footer>
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