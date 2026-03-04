<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WebApplication2.Contact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rescue Med - Contact Us</title>
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

        .contact-section {
            padding: 100px 20px 50px;
            text-align: center;
            background-color: white;
        }

        .contact-section h2 {
            color: #e74c3c; /* Red color */
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        .contact-section p {
            color: #333;
            font-size: 1.1em;
            max-width: 800px;
            margin: 0 auto 50px;
        }

        .contact-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .contact-form {
            flex: 1;
            min-width: 300px;
            max-width: 500px;
            text-align: left;
        }

        .contact-form .form-group {
            margin-bottom: 20px;
        }

        .contact-form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .contact-form input,
        .contact-form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
            transition: border-color 0.3s ease;
        }

        .contact-form input:focus,
        .contact-form textarea:focus {
            border-color: #e74c3c; /* Red color */
            outline: none;
            box-shadow: 0 0 5px rgba(231, 76, 60, 0.3); /* Red shadow */
        }

        .contact-form textarea {
            resize: vertical;
            height: 150px;
        }

        .btn-submit {
            background-color: #e74c3c; /* Red color */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #c0392b; /* Darker red */
        }

        .contact-info {
            flex: 1;
            min-width: 300px;
            max-width: 500px;
            text-align: left;
        }

        .contact-info h3 {
            color: #e74c3c; /* Red color */
            font-size: 1.5em;
            margin-bottom: 20px;
        }

        .contact-info p {
            color: #333;
            font-size: 1em;
            margin-bottom: 10px;
        }

        .contact-info i {
            color: #e74c3c; /* Red color */
            margin-right: 10px;
        }

        .map-container {
            margin-top: 50px;
            width: 100%;
            height: 400px;
            background-color: #f4f4f4;
            border-radius: 10px;
            overflow: hidden;
        }

        .map-container iframe {
            width: 100%;
            height: 100%;
            border: none;
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
                <a href="About us.aspx" class="nav-link">About</a>
                <a href="Contact.aspx" class="nav-link">Contact</a>
            </div>
        </div>
    </nav>

    <section class="contact-section">

        <h2>Contact Us</h2>
        <p>Have questions or feedback? We'd love to hear from you! Reach out to us using the form below or visit our office.</p>
        <div class="contact-container">
            <div class="contact-form">
                <form id="contactForm" runat="server">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name" required=""></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" required=""></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your message" required=""></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn-submit"  />
                </form>
            </div>
            <div class="contact-info">
                <h3>Contact Information</h3>
                <p><i class="fas fa-map-marker-alt"></i>123 EMS Street, City, Country</p>
                <p><i class="fas fa-phone"></i>+1 (123) 456-7890</p>
                <p><i class="fas fa-envelope"></i>support@eRescueMed.com</p>
                <p><i class="fas fa-clock"></i>Mon - Fri: 9:00 AM - 5:00 PM</p>
            </div>
        </div>
        <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.8354345093747!2d144.9537353153166!3d-37.816279742021665!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6ad642af0f11fd81%3A0xf577d6d2e2a4b3b5!2s123%20EMS%20Street%2C%20City%2C%20Country!5e0!3m2!1sen!2sus!4v1622549400000!5m2!1sen!2sus" allowfullscreen="" loading="lazy"></iframe>
        </div>
    </section>

    <footer class="footer">
        <p>&copy; Rescue Med. All rights reserved.</p>
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
