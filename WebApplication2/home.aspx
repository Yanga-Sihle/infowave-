<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="WebApplication2.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Rescue Med - Your lifeline in emergencies. Quick medical response for remote areas."/>
    <title>Rescue Med - Emergency Medical Response</title>
    
    <!-- Preload critical resources -->
    <link rel="preload" href="css/style1.css" as="style"/>
    <link rel="preload" href="healthcare.png" as="image"/>
    
    <!-- External stylesheets -->
    <link href="css/style1.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet"/>
    
    <style>
        /* CSS Reset and Base Styles */
        *, *::before, *::after {
            box-sizing: border-box;
        }
        
        body, html {
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            scroll-behavior: smooth;
            line-height: 1.6;
        }

        /* Navigation Styles - Mobile First Approach */
        .nav-container {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            padding: 12px 0;
            transition: all 0.3s ease;
            background-color: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(10px);
        }

        .nav-container.scrolled {
            background-color: rgba(231, 76, 60, 0.95);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
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
            font-size: clamp(1.2rem, 2.5vw, 1.8rem);
            font-weight: 700;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-logo img {
            height: clamp(35px, 5vw, 50px);
            width: auto;
        }

        /* Mobile Menu */
        .mobile-menu-toggle {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            padding: 5px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: clamp(15px, 3vw, 30px);
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
            font-size: clamp(0.9rem, 1.8vw, 1.1rem);
            transition: all 0.3s ease;
            position: relative;
            padding: 5px 0;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -5px;
            left: 0;
            background-color: white;
            transition: width 0.3s ease;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        /* Button Styles */
        .nav-button {
            padding: clamp(8px, 1.5vw, 12px) clamp(16px, 3vw, 24px);
            border-radius: 25px;
            font-weight: 600;
            font-size: clamp(0.8rem, 1.5vw, 0.95rem);
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .nav-button.login {
            background-color: transparent;
            border: 2px solid white;
            color: white;
        }

        .nav-button.login:hover {
            background-color: white;
            color: #e74c3c;
            transform: translateY(-1px);
        }

        .nav-button.register {
            background-color: #e74c3c;
            border: 2px solid #e74c3c;
            color: white;
        }

        .nav-button.register:hover {
            background-color: #c0392b;
            border-color: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
        }

        /* Header/Hero Section */
        .header {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                        url('https://images.unsplash.com/photo-1587745416684-47953f16f02f?auto=format&fit=crop&w=2000&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            padding: 80px 20px 20px;
        }

        .tagline {
            font-size: clamp(1.2rem, 4vw, 2rem);
            margin-bottom: clamp(20px, 4vw, 40px);
            font-weight: 300;
            max-width: 600px;
        }

        .emergency-button {
            padding: clamp(15px, 3vw, 20px) clamp(25px, 5vw, 40px);
            font-size: clamp(1rem, 2.5vw, 1.4rem);
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 1px;
            box-shadow: 0 4px 20px rgba(231, 76, 60, 0.4);
            min-width: 280px;
        }

        .emergency-button:hover {
            background-color: #c0392b;
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(231, 76, 60, 0.6);
        }

        /* Features Section */
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: clamp(20px, 4vw, 40px);
            padding: clamp(40px, 8vw, 80px) clamp(20px, 4vw, 40px);
            background-color: #f8f9fa;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature {
            text-align: center;
            padding: clamp(25px, 4vw, 40px);
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .feature:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        }

        .feature i {
            font-size: clamp(2.5rem, 5vw, 4rem);
            color: #e74c3c;
            margin-bottom: 20px;
            display: block;
        }

        .feature h2 {
            font-size: clamp(1.2rem, 2.5vw, 1.5rem);
            margin-bottom: 15px;
            color: #2c3e50;
            font-weight: 600;
        }

        .feature p {
            font-size: clamp(0.9rem, 1.8vw, 1rem);
            color: #666;
            line-height: 1.6;
        }

        /* About Section */
        .about {
            padding: clamp(40px, 8vw, 80px) clamp(20px, 4vw, 40px);
            text-align: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .about h2 {
            font-size: clamp(1.8rem, 4vw, 2.5rem);
            margin-bottom: clamp(20px, 4vw, 30px);
            font-weight: 300;
        }

        .about p {
            font-size: clamp(1rem, 2vw, 1.2rem);
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.7;
        }

        /* Footer */
        .footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: clamp(20px, 4vw, 30px);
            font-size: clamp(0.9rem, 1.5vw, 1rem);
        }

        /* Mobile Responsive Design */
        @media (max-width: 768px) {
            body {
                padding-top: 60px;
            }
            
            .mobile-menu-toggle {
                display: block;
            }
            
            .nav-links {
                position: fixed;
                top: 60px;
                left: -100%;
                width: 100%;
                height: calc(100vh - 60px);
                background-color: rgba(44, 62, 80, 0.98);
                flex-direction: column;
                justify-content: flex-start;
                align-items: center;
                gap: 30px;
                padding-top: 50px;
                transition: left 0.3s ease;
                backdrop-filter: blur(10px);
            }
            
            .nav-links.active {
                left: 0;
            }
            
            .nav-link {
                font-size: 1.2rem;
                padding: 10px 0;
            }
            
            .nav-button {
                margin: 10px 0;
                min-width: 200px;
            }
            
            .header {
                background-attachment: scroll;
                padding-top: 100px;
            }
            
            .emergency-button {
                min-width: 90%;
                max-width: 350px;
            }
        }

        @media (max-width: 480px) {
            .nav-content {
                padding: 0 15px;
            }
            
            .features {
                padding: 30px 15px;
                gap: 20px;
            }
            
            .feature {
                padding: 20px;
            }
        }

        /* Performance Optimizations */
        .header {
            will-change: transform;
        }
        
        .nav-container {
            will-change: background-color, box-shadow;
        }
        
        /* Accessibility Improvements */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
            
            .header {
                background-attachment: scroll;
            }
        }
        
        /* Focus styles for accessibility */
        .nav-button:focus,
        .nav-link:focus,
        .emergency-button:focus {
            outline: 2px solid #fff;
            outline-offset: 2px;
        }
    </style>
</head>
<body>
    <form runat="server" id="form1">
        <nav class="nav-container" id="navbar">
            <div class="nav-content">
                <a href="home.aspx" class="nav-logo">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/healthcare.png" alt="Rescue Med Logo" loading="eager" />
                    <span>Rescue Med</span> 
                </a>
                
                <button class="mobile-menu-toggle" type="button" id="mobileMenuToggle" aria-label="Toggle navigation menu">
                    <i class="bi bi-list"></i>
                </button>
                
                <div class="nav-links" id="navLinks">
                    <a href="Features.aspx" class="nav-link">Features</a>
                    <a href="AdminLog.aspx" class="nav-link">Admin</a>
                    <a href="About us.aspx" class="nav-link">About</a>
                    
                    <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="nav-button login" OnClick="btnLogin_Click" />
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="nav-button register" PostBackUrl="~/Register.aspx" />
                </div>
            </div>
        </nav>

        <header class="header">
            <div class="tagline">Your Lifeline in Emergencies</div>
            <asp:Button ID="btnEmergncy" CssClass="emergency-button" runat="server" 
                       PostBackUrl="~/Ringing.aspx" Text="🚨 Emergency Ambulance" 
                       aria-label="Call Emergency Ambulance" />
        </header>

        <section class="features">
            <div class="feature">
                <i class="bi bi-lightning-charge-fill" aria-hidden="true"></i>
                <h2>Quick Response</h2>
                <p>Get immediate assistance with our rapid emergency response system designed for critical situations.</p>
            </div>
            <div class="feature">
                <i class="bi bi-geo-alt-fill" aria-hidden="true"></i>
                <h2>Real-Time Tracking</h2>
                <p>Track ambulances and responders in real-time with precise GPS location for faster, more efficient help.</p>
            </div>
            <div class="feature">
                <i class="bi bi-people-fill" aria-hidden="true"></i>
                <h2>Community Network</h2>
                <p>Connect with trained local first responders and medical professionals in your immediate area.</p>
            </div>
        </section>

        <section class="about">
            <h2>About Rescue Med</h2>
            <p>Rescue Med is dedicated to saving lives by ensuring timely medical response in remote and underserved areas. By leveraging cutting-edge technology and fostering community involvement, we bridge the critical gap between medical emergencies and professional healthcare assistance.</p>
        </section>

        <footer class="footer">
            <p>&copy; 2024 Rescue Med. All rights reserved. | Emergency Medical Response Platform</p>
        </footer>
    </form>

    <script>
        // Performance optimized JavaScript
        (function () {
            'use strict';

            // Throttle function for performance
            function throttle(func, limit) {
                let inThrottle;
                return function () {
                    const args = arguments;
                    const context = this;
                    if (!inThrottle) {
                        func.apply(context, args);
                        inThrottle = true;
                        setTimeout(() => inThrottle = false, limit);
                    }
                }
            }

            // Navbar scroll effect with throttling
            const navbar = document.getElementById('navbar');
            const handleScroll = throttle(function () {
                if (window.pageYOffset > 50) {
                    navbar.classList.add('scrolled');
                } else {
                    navbar.classList.remove('scrolled');
                }
            }, 16); // ~60fps

            window.addEventListener('scroll', handleScroll, { passive: true });

            // Mobile menu toggle
            const mobileMenuToggle = document.getElementById('mobileMenuToggle');
            const navLinks = document.getElementById('navLinks');
            const toggleIcon = mobileMenuToggle.querySelector('i');

            mobileMenuToggle.addEventListener('click', function () {
                navLinks.classList.toggle('active');
                toggleIcon.classList.toggle('bi-list');
                toggleIcon.classList.toggle('bi-x');
            });

            // Close mobile menu when clicking on a link
            navLinks.addEventListener('click', function (e) {
                if (e.target.classList.contains('nav-link')) {
                    navLinks.classList.remove('active');
                    toggleIcon.classList.add('bi-list');
                    toggleIcon.classList.remove('bi-x');
                }
            });

            // Close mobile menu when clicking outside
            document.addEventListener('click', function (e) {
                if (!navbar.contains(e.target) && navLinks.classList.contains('active')) {
                    navLinks.classList.remove('active');
                    toggleIcon.classList.add('bi-list');
                    toggleIcon.classList.remove('bi-x');
                }
            });

            // Smooth scroll for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });

        })();
    </script>

    <!-- Tawk.to Chat Widget -->
    <script type="text/javascript">
        var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
        (function () {
            var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
            s1.async = true;
            s1.src = 'https://embed.tawk.to/67df65bd48d5101912fd9250/1in0aardv';
            s1.charset = 'UTF-8';
            s1.setAttribute('crossorigin', '*');
            s0.parentNode.insertBefore(s1, s0);
        })();
    </script>
</body>
</html>