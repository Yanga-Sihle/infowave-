<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2.WebForm1" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Patient Homepage - Request a Ride
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Page-specific styles for patient homepage */
        h1 {
            color: #0288d1; /* Blue for patient theme */
        }
        body {
            /* Background color handled by master page for consistency, but can be overridden here if needed */
            /* background-color: #e0f2f7; */ 
        }
        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        .input-group input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }
        button {
            background-color: #0288d1; /* Blue */
            color: white;
            width: 100%;
        }
        button:hover {
            background-color: #0277bd;
        }
        .map-instructions {
            font-size: 0.9em;
            color: #666;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Request a Ride</h1>

    <div class="container">
        <div class="input-group">
            <label for="currentLocationInput">Your Current Location:</label>
            <input type="text" id="currentLocationInput" placeholder="Click on map to set or enter address" readonly>
            <div class="map-instructions">Click on the map to set your current location.</div>
        </div>

        <div id="map-home" class="map-container"></div>

        <button id="requestRideBtn">Request Ride</button>
        <div id="statusMessage" class="message info">Please set your location on the map.</div>
    </div>

    <script>
        let homeMap;
        let currentLocationMarker;
        let currentLat, currentLng;

        const currentLocationInput = document.getElementById('currentLocationInput');
        const requestRideBtn = document.getElementById('requestRideBtn');
        const statusMessage = document.getElementById('statusMessage');

        document.addEventListener('DOMContentLoaded', () => {
            homeMap = L.map('map-home').setView([-29.8587, 31.0218], 13); // Durban coordinates
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors'
            }).addTo(homeMap);

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        const { latitude, longitude } = position.coords;
                        homeMap.setView([latitude, longitude], 15);
                        displayMessage('Got your current location.', 'info');
                    },
                    (error) => {
                        console.warn("Could not get initial user location:", error);
                        displayMessage('Could not get your current location. Please manually select on map.', 'error');
                    },
                    { enableHighAccuracy: true, timeout: 5000, maximumAge: 0 }
                );
            } else {
                displayMessage('Geolocation is not supported by your browser. Please manually select on map.', 'error');
            }

            homeMap.on('click', function (e) {
                const { lat, lng } = e.latlng;
                currentLat = lat;
                currentLng = lng;

                if (currentLocationMarker) {
                    currentLocationMarker.setLatLng([lat, lng]);
                } else {
                    currentLocationMarker = L.marker([lat, lng], {
                        icon: L.icon({
                            iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png', // Red marker for patient
                            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                            iconSize: [25, 41],
                            iconAnchor: [12, 41],
                            popupAnchor: [1, -34]
                        })
                    }).addTo(homeMap);
                    currentLocationMarker.bindPopup("Your selected location").openPopup();
                }

                fetch(`https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${lat}&lon=${lng}`)
                    .then(response => response.json())
                    .then(data => {
                        const address = data.display_name || `Lat: ${lat.toFixed(6)}, Lng: ${lng.toFixed(6)}`;
                        currentLocationInput.value = address;
                        displayMessage('Location set. Click "Request Ride" when ready.', 'info');
                    })
                    .catch(error => {
                        console.error("Error during reverse geocoding:", error);
                        currentLocationInput.value = `Lat: ${lat.toFixed(6)}, Lng: ${lng.toFixed(6)}`;
                        displayMessage('Location set (address lookup failed). Click "Request Ride" when ready.', 'info');
                    });
            });
        });

        requestRideBtn.addEventListener('click', () => {
            if (currentLat && currentLng) {
                // Simulated destination, replace with actual patient input if needed
                const simulatedDestinationLat = -29.865;
                const simulatedDestinationLng = 30.985;
                const simulatedDestinationAddress = "Example Hospital, Durban";

                const queryString = new URLSearchParams({
                    lat: simulatedDestinationLat,
                    lng: simulatedDestinationLng,
                    address: simulatedDestinationAddress
                }).toString();

                window.location.href = `DriverDash.aspx?${queryString}`;
            } else {
                displayMessage('Please click on the map to set your current location first.', 'error');
            }
        });

        function displayMessage(msg, type) {
            statusMessage.textContent = msg;
            statusMessage.className = `message ${type}`;
        }
    </script>
</asp:Content>