<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About us.aspx.cs" Inherits="WebApplication2.About_us" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EMS Connect - About Us</title>
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

        .about-section {
            padding: 100px 20px 50px;
            text-align: center;
            background-color: white;
        }

        .about-section h2 {
            color: #e74c3c; /* Red color */
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        .about-section p {
            color: #333;
            font-size: 1.1em;
            max-width: 800px;
            margin: 0 auto 50px;
        }

        .mission-vision {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .mission-vision-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 45%;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .mission-vision-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
        }

        .mission-vision-card h3 {
            color: #e74c3c; /* Red color */
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .mission-vision-card p {
            color: #666;
            font-size: 1em;
        }

        .team-section {
            padding: 50px 20px;
            background-color: #f9f9f9;
            text-align: center;
        }

        .team-section h2 {
            color: #e74c3c; /* Red color */
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        .team-grid {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .team-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 250px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .team-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
        }

        .team-card img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-bottom: 20px;
        }

        .team-card h3 {
            color: #e74c3c; /* Red color */
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .team-card p {
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
            <a href="WebForm2.aspx" class="nav-logo">Rescue Med</a>
            <div class="nav-links">
                <a href="WebForm2.aspx" class="nav-link">Home</a>
               
                <a href="Features.aspx" class="nav-link">Features</a>
               
                <a href="About.aspx" class="nav-link">About</a>
               
                <a href="Contact.aspx" class="nav-link">Contact</a>
                
            </div>
        </div>
    </nav>

    <section class="about-section">
        <h2>About Us</h2>
        <p>EMS Connect is dedicated to revolutionizing emergency medical response through technology and community engagement. Our mission is to ensure that quality emergency medical care is accessible to everyone, everywhere.</p>
        <div class="mission-vision">
            <div class="mission-vision-card">
                <h3>Our Mission</h3>
                <p>To provide timely and efficient emergency medical services to everyone, regardless of their location.</p>
            </div>
            <div class="mission-vision-card">
                <h3>Our Vision</h3>
                <p>To create a world where no one has to wait for life-saving medical assistance.</p>
            </div>
        </div>
    </section>

    <section class="team-section">
        <h2>Our Team</h2>
        <div class="team-grid">
            <div class="team-card">
                <img src="https://via.placeholder.com/100" alt="Team Member 1" />
                <h3>John Doe</h3>
                <p>CEO & Founder</p>
            </div>
            <div class="team-card">
                <img src="https://via.placeholder.com/100" alt="Team Member 2" />
                <h3>Jane Smith</h3>
                <p>Chief Medical Officer</p>
            </div>
            <div class="team-card">
                <img src="https://via.placeholder.com/100" alt="Team Member 3" />
                <h3>Michael Brown</h3>
                <p>Head of Operations</p>
            </div>
            <div class="team-card">
                <img src="https://via.placeholder.com/100" alt="Team Member 4" />
                <h3>Sarah Johnson</h3>
                <p>Community Engagement Lead</p>
            </div>
        </div>
    </section>

    <footer class="footer">
        <p>&copy; 2024 Rescue Med. All rights reserved.</p>
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