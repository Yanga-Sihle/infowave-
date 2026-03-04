<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication2.train" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rescue Med - Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            scroll-behavior: smooth;
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1587745416684-47953f16f02f?auto=format&fit=crop&w=2000');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
        }

        /* Navigation styles matching EMS Connect */
        .nav-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding: 20px 0;
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
            display: flex; /* For image + text logo */
            align-items: center;
            gap: 10px;
        }
        .nav-logo img {
            height: 50px; /* Adjust as needed */
            width: auto;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: #f8f9fa; /* Light gray on hover */
        }

        .container {
            max-width: 800px;
            margin: 120px auto 50px;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
        }

        h2 {
            color: #e74c3c; /* Red color */
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
        }

        .welcome-message {
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.1em;
            color: #333;
        }

        /* Role selector styling */
        .role-selector {
            position: relative;
            width: 100%;
            max-width: 500px;
            height: 60px;
            margin: 0 auto 40px;
            background-color: #f5f5f5;
            border-radius: 30px;
            display: flex;
            padding: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .role-btn {
            flex: 1;
            border: none;
            background: none;
            cursor: pointer;
            position: relative;
            font-size: 16px;
            font-weight: 600;
            color: #666;
            transition: all 0.3s ease;
            z-index: 1;
            padding: 0;
        }

        .role-btn:focus {
            outline: none;
        }

        .role-selector::before {
            content: '';
            position: absolute;
            top: 5px;
            left: 5px;
            width: calc(50% - 5px);
            height: calc(100% - 10px);
            background-color: #e74c3c; /* Red color */
            border-radius: 25px;
            transition: transform 0.3s ease;
        }

        .role-selector.admin-selected::before { /* Changed class name */
            transform: translateX(calc(100% + 5px));
        }

        .role-btn.active {
            color: white;
        }

        .role-btn i {
            margin-right: 8px;
            font-size: 18px;
        }

        /* Role Icons */
        .role-btn::before {
            font-family: 'Font Awesome 5 Free';
            margin-right: 8px;
            font-weight: 900;
        }

        .first-responder-btn::before {
            content: '\f0f0'; /* First responder icon */
        }

        .admin-btn::before { /* Changed class name */
            content: '\f0fa'; /* Medical professional/Admin icon */
        }

        /* Hover effects */
        .role-btn:hover:not(.active) {
            color: #e74c3c; /* Red color */
        }

        /* Form groups */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
            background-color: rgba(255, 255, 255, 0.9);
        }

        .form-control:focus {
            border-color: #e74c3c; /* Red color */
            outline: none;
            box-shadow: 0 0 5px rgba(231, 76, 60, 0.3); /* Red shadow */
        }

        /* Styling for FileUpload control */
        .form-control.file-upload {
            padding: 8px; /* Slightly less padding for file input */
            height: auto; /* Allow height to adjust */
        }


        /* Register button */
        .btn-register {
            background-color: #e74c3c; /* Red color */
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 1.2em;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        .btn-register:hover {
            background-color: #c0392b; /* Darker red */
        }

        /* Messages */
        .error-message {
            color: #ff3333;
            margin-top: 15px;
            text-align: center;
            display: block;
        }

        .sign-in-link {
            text-align: center;
            margin-top: 25px;
            color: black; /* Changed for better contrast against white container */
        }

        .sign-in-link a {
            color: #e74c3c; /* Red color */
            text-decoration: none;
            font-weight: bold;
        }

        .sign-in-link a:hover {
            text-decoration: underline;
        }

        /* Car Registration Section - Initially Hidden */
        .car-registration-section {
            display: none; /* Hidden by default */
            border-top: 1px solid #eee;
            padding-top: 25px;
            margin-top: 25px;
        }

        /* Admin Type Selector - Initially Hidden, renamed for clarity */
        .admin-type-selector { /* Changed from medical-professional-type */
            display: none; /* Hidden by default */
        }

        #ddlAdminType { /* Renamed ID */
            background-color: white;
        }

        /* Styles for location suggestions */
        .suggestions {
            position: absolute;
            background-color: #fff;
            border: 1px solid #ddd;
            max-height: 200px;
            overflow-y: auto;
            width: 100%;
            z-index: 100;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 5px;
            margin-top: 5px;
        }
        .suggestion-item {
            padding: 10px;
            cursor: pointer;
            border-bottom: 1px solid #eee;
        }
        .suggestion-item:last-child {
            border-bottom: none;
        }
        .suggestion-item:hover {
            background-color: #f0f0f0;
        }

        @media (max-width: 768px) {
            .role-selector {
                max-width: 100%;
                height: 50px;
            }

            .role-btn {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <nav class="nav-container">
        <div class="nav-content">
            <a href="home.aspx" class="nav-logo">
                <img src="healthcare.png" alt="Rescue Med Logo" /> <span>Rescue Med</span> 
            </a>
            
            <div class="nav-links">
                <a href="Features.aspx" class="nav-link">Features</a>
                <a href="AdminLog.aspx" class="nav-link">Admin</a>
                <a href="About us.aspx" class="nav-link">About</a>
            </div>
        </div>
    </nav>

    <form id="form1" runat="server">
        <div class="container">
            <h2>Join Rescue Med</h2>
            <p class="welcome-message">Welcome to Rescue Med! We're excited to have you join our network. Let's get started with your registration.</p>
            
            <asp:HiddenField ID="hfSelectedRole" runat="server" />
            <div class="role-selector">
                <asp:Button ID="btnFirstResponder" runat="server" Text="First Responder" CssClass="role-btn first-responder-btn" OnClientClick="setRole(this); return false;" />
                <asp:Button ID="btnAdmin" runat="server" Text="Admin" CssClass="role-btn admin-btn" OnClientClick="setRole(this); return false;" /> </div>

            <div id="adminTypeSelector" class="form-group admin-type-selector">
                <asp:Label ID="lblAdminType" runat="server" AssociatedControlID="ddlAdminType">Admin Type</asp:Label>
                <asp:DropDownList ID="ddlAdminType" runat="server" CssClass="form-control">
                    <asp:ListItem Text="System Admin" Value="SysAdmin"></asp:ListItem>
                    <asp:ListItem Text="Regional Manager" Value="RegionalManager"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <asp:Label ID="lblFullName" runat="server" AssociatedControlID="txtFullName">Full Name</asp:Label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" required=""></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" required=""></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword">Password</asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required=""></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblConfirmPassword" runat="server" AssociatedControlID="txtConfirmPassword">Confirm Password</asp:Label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" required=""></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="lblContact" runat="server" AssociatedControlID="txtContact">Contact</asp:Label>
                <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" Text="" required=""></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblProfilePicture" runat="server" AssociatedControlID="fuProfilePicture">Profile Picture</asp:Label>
                <asp:FileUpload ID="fuProfilePicture" runat="server" CssClass="form-control file-upload" />
            </div>

            <div style="position: relative;" class="form-group">
                <label for="locationTextbox">Enter Base Location</label>
                <asp:TextBox ID="locationTextbox" CssClass="form-control" runat="server" Placeholder="Enter your base location" AutoCompleteType="Disabled" onkeyup="getSuggestions(this.value)" />
                <asp:Panel ID="suggestionPanel" runat="server" CssClass="suggestions" Style="display: none;"></asp:Panel>
            </div>

            <div id="carRegistrationSection" class="car-registration-section">
                <h3>Car Details (For First Responders)</h3>
                <div class="form-group">
                    <asp:Label ID="lblCarMake" runat="server" AssociatedControlID="txtCarMake">Car Make</asp:Label>
                    <asp:TextBox ID="txtCarMake" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblCarModel" runat="server" AssociatedControlID="txtCarModel">Car Model</asp:Label>
                    <asp:TextBox ID="txtCarModel" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblLicensePlate" runat="server" AssociatedControlID="txtLicensePlate">License Plate</asp:Label>
                    <asp:TextBox ID="txtLicensePlate" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblCarType" runat="server" AssociatedControlID="txtCarType">Car Type (e.g., Ambulance, Response Vehicle)</asp:Label>
                    <asp:TextBox ID="txtCarType" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblCarPicture" runat="server" AssociatedControlID="fuCarPicture">Car Picture</asp:Label>
                    <asp:FileUpload ID="fuCarPicture" runat="server" CssClass="form-control file-upload" />
                </div>
            </div>
            
            <asp:Button ID="btnRegisterSubmit" runat="server" Text="Complete Registration" CssClass="btn-register" OnClick="btnRegisterSubmit_Click" />
             
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

            <p class="sign-in-link">Already have an account? <a href="profile.aspx">Sign in</a></p>
        </div>
        <asp:HiddenField ID="hiddenRole" runat="server" />
    </form>

    <script type="text/javascript">
        // Helper function to get client IDs
        function getClientID(id) {
            return document.getElementById(id).id;
        }

        function setRole(button) {
            const roleSelector = document.querySelector('.role-selector');
            const buttons = document.querySelectorAll('.role-btn');
            const hfSelectedRole = document.getElementById('<%= hfSelectedRole.ClientID %>');
            const adminTypeSelector = document.getElementById('adminTypeSelector');
            const carRegistrationSection = document.getElementById('carRegistrationSection');

            buttons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            if (button.id === getClientID('<%= btnAdmin.ClientID %>')) {
                roleSelector.classList.add('admin-selected');
                adminTypeSelector.style.display = 'block';
                carRegistrationSection.style.display = 'none'; // Hide car fields
                hfSelectedRole.value = document.getElementById('<%= ddlAdminType.ClientID %>').value; // Set initial admin type
            } else { // First Responder selected
                roleSelector.classList.remove('admin-selected');
                adminTypeSelector.style.display = 'none';
                carRegistrationSection.style.display = 'block'; // Show car fields
                hfSelectedRole.value = 'First Responder'; // Use a clear string value
            }
        }

        // Set initial state on page load
        window.onload = function () {
            const firstResponderButton = document.getElementById('<%= btnFirstResponder.ClientID %>');
            setRole(firstResponderButton); // Default to First Responder
        };

        // Add event listeners to role buttons
        document.getElementById('<%= btnFirstResponder.ClientID %>').addEventListener('click', function (e) {
            e.preventDefault(); // Prevent postback to handle with JS
            setRole(this);
        });

        document.getElementById('<%= btnAdmin.ClientID %>').addEventListener('click', function (e) {
            e.preventDefault(); // Prevent postback to handle with JS
            setRole(this);
        });

        // Update hidden role value when Admin type changes
        document.getElementById('<%= ddlAdminType.ClientID %>').addEventListener('change', function () {
            const hfSelectedRole = document.getElementById('<%= hfSelectedRole.ClientID %>');
            hfSelectedRole.value = this.value;
        });
    </script>

    <script type="text/javascript">
        // Geoapify API Key (Remember to keep sensitive keys secure in production)
        const GEOAPIFY_API_KEY = "a5165c4d6ecf462bbe999477b59e295c";

        async function getSuggestions(query) {
            const suggestionPanel = document.getElementById("<%= suggestionPanel.ClientID %>");

            if (!query || query.length < 3) { // Only search for 3 or more characters
                suggestionPanel.innerHTML = '';
                suggestionPanel.style.display = "none";
                return;
            }

            // Limit to South Africa (countrycode: za) and bias towards Durban (lon, lat)
            const url = `https://api.geoapify.com/v1/geocode/autocomplete?text=${encodeURIComponent(query)}&lang=en&limit=5&countrycode=za&bias=proximity:31.0218,-29.8587&apiKey=${GEOAPIFY_API_KEY}`;

            try {
                const response = await fetch(url);
                const data = await response.json();

                suggestionPanel.innerHTML = ''; // Clear previous suggestions

                if (data.features && data.features.length > 0) {
                    data.features.forEach(feature => {
                        const suggestion = feature.properties.formatted;
                        const suggestionItem = document.createElement("div");
                        suggestionItem.className = "suggestion-item";
                        suggestionItem.innerText = suggestion;
                        suggestionItem.onclick = () => {
                            document.getElementById("<%= locationTextbox.ClientID %>").value = suggestion;
                            suggestionPanel.style.display = "none";
                        };
                        suggestionPanel.appendChild(suggestionItem);
                    });
                    suggestionPanel.style.display = "block";
                } else {
                    suggestionPanel.style.display = "none";
                }
            } catch (error) {
                console.error("Error fetching location suggestions:", error);
                suggestionPanel.style.display = "none";
            }
        }

        // Close suggestions if clicked outside
        document.addEventListener('click', function (event) {
            const suggestionPanel = document.getElementById("<%= suggestionPanel.ClientID %>");
            const locationTextbox = document.getElementById("<%= locationTextbox.ClientID %>");
            if (!suggestionPanel.contains(event.target) && event.target !== locationTextbox) {
                suggestionPanel.style.display = "none";
            }
        });
    </script>
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