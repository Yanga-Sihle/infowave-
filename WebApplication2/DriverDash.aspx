<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DriverDash.aspx.cs" Inherits="WebApplication2.DriverDash" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard - RescueMed</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0; /* Remove padding from body as container handles it */
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh; /* Ensure body takes full viewport height */
            
            /* --- PROFESSIONAL BACKGROUND START --- */
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('pexels-mikhail-nilov-28123714.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #333; /* Default text color for elements not in container */
            /* --- PROFESSIONAL BACKGROUND END --- */
        }
        h1 {
            text-align: center;
            color: #4CAF50; /* Green for driver theme */
            margin-top: 40px; /* Space from top for visual balance */
            margin-bottom: 20px;
            font-size: 2.8em;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
            color: white; /* Make heading visible against dark background */
        }
        .container {
            width: 100%;
            max-width: 1000px;
            
            /* --- CONTAINER BACKGROUND START --- */
            background: rgba(255, 255, 255, 0.95); /* Slightly transparent white */
            padding: 30px; /* Increased padding */
            /* --- CONTAINER BACKGROUND END --- */

            border-radius: 12px; /* Slightly more rounded corners */
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3); /* Stronger, more professional shadow */
            display: flex;
            flex-direction: column;
            gap: 25px; /* Increased gap between sections */
            margin-bottom: 40px; /* Space from bottom */
        }
        .status-section {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px; /* Increased gap */
            padding-bottom: 20px; /* Increased padding */
            border-bottom: 1px solid #ddd; /* Lighter border */
        }
        .status-indicator {
            font-size: 1.2em; /* Slightly larger font */
            font-weight: bold;
            color: #555;
            min-width: 150px; /* Give it a minimum width */
            text-align: right; /* Align text to the right for balance */
        }
        .status-indicator.online {
            color: #4CAF50; /* Green */
        }
        .status-indicator.offline {
            color: #f44336; /* Red */
        }
        button {
            padding: 12px 25px; /* More padding */
            border: none;
            border-radius: 6px; /* Slightly more rounded buttons */
            cursor: pointer;
            font-size: 1.05em; /* Slightly larger font */
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease; /* Add transform for hover effect */
            box-shadow: 0 2px 5px rgba(0,0,0,0.2); /* Button shadows */
        }
        button:hover {
            transform: translateY(-2px); /* Lift button on hover */
        }
        button.online-btn {
            background-color: #4CAF50; /* Green */
            color: white;
        }
        button.online-btn:hover {
            background-color: #45a049;
        }
        button.online-btn:disabled {
            background-color: #a5d6a7; /* Lighter green when disabled */
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }
        button.offline-btn {
            background-color: #f44336; /* Red */
            color: white;
        }
        button.offline-btn:hover {
            background-color: #da190b;
        }
        button.offline-btn:disabled {
            background-color: #ef9a9a; /* Lighter red when disabled */
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }
        .info-panel {
            padding: 20px; /* More padding */
            background-color: #e8f5e8; /* Light green background */
            border-left: 6px solid #4CAF50; /* Thicker border */
            border-radius: 8px; /* More rounded */
            font-size: 1em;
            line-height: 1.6; /* Better line spacing */
            color: #333;
        }
        .info-panel div {
            margin-bottom: 8px; /* Space out lines */
        }
        .map-container {
            height: 600px; /* Significantly increased height for better map view */
            width: 100%;
            border-radius: 10px; /* More rounded */
            overflow: hidden;
            margin-top: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2); /* Stronger shadow */
            position: relative;
        }
        #map {
            height: 100%;
            width: 100%;
        }
        #directions {
            margin-top: 25px; /* More space */
            padding: 20px; /* More padding */
            background-color: #fcfcfc; /* Cleaner white background */
            border: 1px solid #eee;
            border-radius: 10px; /* More rounded */
            max-height: 400px; /* Allow more height for directions */
            overflow-y: auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08); /* Subtle shadow */
        }
        #directions h3 {
            color: #333;
            margin-top: 0;
            font-size: 1.6em;
            margin-bottom: 15px;
        }
        #directions ol {
            padding-left: 25px; /* More padding */
            list-style-type: decimal; /* Ensure numbered list */
        }
        #directions li {
            margin-bottom: 8px; /* More space between steps */
            line-height: 1.5;
            color: #555;
        }

        /* Styles for offline state overlay */
        .offline-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.85); /* Darker overlay */
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            color: white;
            font-size: 2.2em; /* Slightly larger text */
            font-weight: bold;
            z-index: 1000;
            border-radius: 10px; /* Match container border-radius */
            text-align: center;
            line-height: 1.4;
            text-shadow: 2px 2px 5px rgba(0,0,0,0.5);
        }
        .offline-overlay p {
            margin: 10px 0;
        }
        .offline-overlay p:first-child {
            font-size: 1.5em; /* Make the "You are OFFLINE" stand out */
            color: #f44336; /* Red for offline status */
            margin-bottom: 15px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            h1 {
                font-size: 2.2em;
                margin-top: 20px;
            }
            .container {
                padding: 15px;
                margin-bottom: 20px;
            }
            .status-section {
                flex-direction: column;
                gap: 10px;
                padding-bottom: 10px;
            }
            .status-indicator {
                text-align: center;
                min-width: unset;
            }
            .status-section button {
                width: 90%;
                padding: 10px 20px;
            }
            .info-panel {
                padding: 15px;
            }
            .map-container {
                height: 400px; /* Adjust height for smaller screens */
            }
            #directions {
                padding: 15px;
            }
            .offline-overlay {
                font-size: 1.8em;
            }
        }
    </style>
</head>
<body>
    <h1>Driver Dashboard</h1>

    <div class="container">
        <div class="status-section">
            <span class="status-indicator" id="driverStatusDisplay">Status: Offline</span>
            <button class="online-btn" id="goOnlineBtn">Go Online</button>
            <button class="offline-btn" id="goOfflineBtn">Go Offline</button>
        </div>

        <div class="info-panel">
            <div id="driverLocationDisplay">Your Location: Fetching...</div>
            <div id="patientInfoDisplay">Patient Info: No patient assigned.</div>
            <div id="statusMessages" style="color: #666; margin-top: 5px;"></div>
        </div>

        <div class="map-container">
            <div id="map"></div>
            <div id="offlineMapOverlay" class="offline-overlay" style="display: none;">
                <p>You are OFFLINE</p>
                <p>Go online to view map and receive assignments.</p>
            </div>
        </div>

        <div id="directions">
            <h3>Directions</h3>
            <p>Route details will appear here once a route is calculated.</p>
        </div>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>

    <script>
        let map;
        let driverMarker;
        let patientMarker;
        let routingControl;
        let locationWatchId; // To store the ID for navigator.geolocation.watchPosition
        let driverIsOnline = false; // Initial status

        // --- Configuration ---
        const DRIVER_ID = 101; // !!! IMPORTANT: Replace with actual driver ID (e.g., from session/login) !!!
        const LOCATION_UPDATE_INTERVAL_MS = 10000; // Update location every 10 seconds
        const API_BASE_URL = ''; // If your API is on the same origin, leave empty or '/'. Otherwise, 'http://your-backend-domain.com'

        // --- Elements ---
        const driverStatusDisplay = document.getElementById('driverStatusDisplay');
        const goOnlineBtn = document.getElementById('goOnlineBtn');
        const goOfflineBtn = document.getElementById('goOfflineBtn');
        const driverLocationDisplay = document.getElementById('driverLocationDisplay');
        const patientInfoDisplay = document.getElementById('patientInfoDisplay');
        const statusMessages = document.getElementById('statusMessages');
        const offlineMapOverlay = document.getElementById('offlineMapOverlay');
        const mapElement = document.getElementById('map'); // Get the map div itself

        // --- Map Initialization ---
        function initializeMap(centerLat, centerLng, zoom = 13) {
            if (!map) {
                map = L.map('map').setView([centerLat, centerLng], zoom);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '© OpenStreetMap contributors'
                }).addTo(map);
            } else {
                map.setView([centerLat, centerLng], zoom);
            }
            if (routingControl) {
                map.removeControl(routingControl);
                routingControl = null;
                document.getElementById('directions').innerHTML = '<h3>Directions</h3><p>Route details will appear here once a route is calculated.</p>';
            }
        }

        // --- Driver Status Management ---
        async function setDriverStatus(isOnline) {
            try {
                // In a real application, you'd send this status to your backend:
                // This AJAX call is commented out for frontend demonstration purposes.
                /*
                const response = await fetch(`${API_BASE_URL}/api/drivers/setstatus`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ driverId: DRIVER_ID, isOnline: isOnline })
                });
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                */

                driverIsOnline = isOnline; // Update the JavaScript state
                updateStatusUI(); // Update the text and button states

                if (isOnline) {
                    startLocationTracking(); // Begin tracking and sending location
                    offlineMapOverlay.style.display = 'none'; // HIDE the offline overlay
                    mapElement.style.display = 'block'; // Ensure map div is visible (if it was hidden, though overlay should handle this)
                    map.invalidateSize(); // Tell Leaflet to re-render, crucial when container display changes

                    // If a patient was assigned (e.g., from URL params on load),
                    // display them now that the driver is online.
                    if (window.patientLocation && !patientMarker) { // Only display if not already displayed
                        displayPatientLocation(window.patientLocation.lat, window.patientLocation.lng, window.patientLocation.address);
                    }
                } else {
                    stopLocationTracking(); // Stop tracking and clear markers/routes
                    offlineMapOverlay.style.display = 'flex'; // SHOW the offline overlay
                    // mapElement.style.display = 'none'; // Optional: You could hide the map element entirely too
                }

            } catch (error) {
                console.error("Error updating driver status:", error);
                statusMessages.textContent = `Failed to update status: ${error.message}`;
            }
        }

        // Updates the text and class of the status indicator, and disables/enables buttons
        function updateStatusUI() {
            driverStatusDisplay.textContent = `Status: ${driverIsOnline ? 'Online' : 'Offline'}`;
            // Add/remove 'online'/'offline' class for styling (green/red text)
            driverStatusDisplay.classList.toggle('online', driverIsOnline);
            driverStatusDisplay.classList.toggle('offline', !driverIsOnline);

            goOnlineBtn.disabled = driverIsOnline;    // Disable "Go Online" if already online
            goOfflineBtn.disabled = !driverIsOnline; // Disable "Go Offline" if already offline
        }

        // --- Geolocation Tracking ---
        function startLocationTracking() {
            if (locationWatchId) {
                navigator.geolocation.clearWatch(locationWatchId); // Clear any existing watch to prevent duplicates
            }

            if (navigator.geolocation) {
                locationWatchId = navigator.geolocation.watchPosition(
                    position => {
                        const { latitude, longitude } = position.coords;
                        // Only update map/send location if driver is actually online
                        if (driverIsOnline) { // This check is a safeguard, but setDriverStatus should ensure this
                            updateDriverLocationOnMap(latitude, longitude);
                            sendDriverLocationToBackend(latitude, longitude);
                        }
                    },
                    error => {
                        console.error("Geolocation error:", error);
                        statusMessages.textContent = `Geolocation error: ${error.message}`;
                        // If persistent critical errors, you might want to auto-go offline:
                        // setDriverStatus(false);
                    },
                    {
                        enableHighAccuracy: true,
                        maximumAge: 0, // No caching of location, always try to get fresh
                        timeout: 5000 // Get a position within 5 seconds
                    }
                );
                statusMessages.textContent = 'Location tracking started.';
            } else {
                statusMessages.textContent = "Geolocation is not supported by this browser. Cannot go online.";
                goOnlineBtn.disabled = true; // Disable online button if no geolocation
            }
        }

        function stopLocationTracking() {
            if (locationWatchId) {
                navigator.geolocation.clearWatch(locationWatchId);
                locationWatchId = null;
                statusMessages.textContent = 'Location tracking stopped.';
            }
            // Clear driver and patient markers from the map when offline
            if (driverMarker) {
                map.removeLayer(driverMarker);
                driverMarker = null;
            }
            if (patientMarker) {
                map.removeLayer(patientMarker);
                patientMarker = null;
            }
            // Remove routing control
            if (routingControl) {
                map.removeControl(routingControl);
                routingControl = null;
                document.getElementById('directions').innerHTML = '<h3>Directions</h3><p>Route details will appear here once a route is calculated.</p>';
            }
            // Update UI panels to reflect offline state
            driverLocationDisplay.textContent = 'Your Location: Offline';
            patientInfoDisplay.textContent = 'Patient Info: Not available offline.';
        }

        // --- Send Driver Location to Backend ---
        async function sendDriverLocationToBackend(lat, lng) {
            // Only send if the driver is truly online
            if (!driverIsOnline) {
                return;
            }
            try {
                // This AJAX call is commented out for frontend demonstration purposes.
                /*
                const response = await fetch(`${API_BASE_URL}/api/drivers/updatelocation`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ driverId: DRIVER_ID, latitude: lat, longitude: lng })
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                */
                // console.log("Driver location updated on backend.");
            } catch (error) {
                console.error("Error sending driver location to backend:", error);
                statusMessages.textContent = `Failed to send location: ${error.message}`;
            }
        }

        // --- Map Marker Updates ---
        function updateDriverLocationOnMap(lat, lng) {
            if (!driverIsOnline) return; // Only update map if online

            driverLocationDisplay.textContent = `Your Location: Lat ${lat.toFixed(6)}, Lng ${lng.toFixed(6)}`;
            if (!driverMarker) {
                driverMarker = L.marker([lat, lng], {
                    icon: L.icon({
                        iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
                        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34]
                    })
                }).addTo(map);
                driverMarker.bindPopup("<b>You are here!</b>").openPopup();
                map.setView([lat, lng], 15); // Center map on driver's initial live location
            } else {
                driverMarker.setLatLng([lat, lng]); // Move the existing marker
                driverMarker.getPopup().setContent("<b>You are here!</b><br>Updated: " + new Date().toLocaleTimeString());
            }

            // If a patient location is set, recalculate the route from the driver's new live position
            if (patientMarker) {
                const patientLatLng = patientMarker.getLatLng();
                calculateAndDisplayRoute(driverMarker.getLatLng(), patientLatLng, "Your Location", "Patient Location");
            }
        }

        function displayPatientLocation(lat, lng, address) {
            if (!driverIsOnline) return; // Only display if online

            patientInfoDisplay.textContent = `Patient Info: ${address || 'Location provided'}`;
            if (patientMarker) {
                map.removeLayer(patientMarker);
            }
            patientMarker = L.marker([lat, lng], {
                icon: L.icon({
                    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
                    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                    iconSize: [25, 41],
                    iconAnchor: [12, 41],
                    popupAnchor: [1, -34]
                })
            }).addTo(map);
            patientMarker.bindPopup(`<b>Patient Location:</b><br>${address || 'Coordinates provided'}`).openPopup();

            // Center map to show both driver and patient if driver location is known
            if (driverMarker) {
                const driverLatLng = driverMarker.getLatLng();
                const bounds = L.latLngBounds([driverLatLng, patientMarker.getLatLng()]);
                map.fitBounds(bounds.pad(0.2));
                calculateAndDisplayRoute(driverLatLng, patientMarker.getLatLng(), "Your Location", "Patient Location");
            } else {
                map.setView([lat, lng], 15); // Center on patient if driver not yet located
            }
        }

        // --- Routing ---
        function calculateAndDisplayRoute(startPoint, endPoint, startName, endName) {
            if (!driverIsOnline) { // Only calculate route if online
                document.getElementById('directions').innerHTML = '<h3>Directions</h3><p>Go online to view routes.</p>';
                return;
            }

            if (routingControl) {
                map.removeControl(routingControl);
            }
            document.getElementById('directions').innerHTML = '<h3>Directions</h3><p>Calculating route...</p>';

            routingControl = L.Routing.control({
                waypoints: [
                    startPoint,
                    endPoint
                ],
                routeWhileDragging: true,
                show: true,
                collapsible: true,
                createMarker: function (i, waypoint, n) {
                    let icon;
                    if (i === 0) { // Start point (Driver)
                        icon = L.icon({
                            iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
                            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                            iconSize: [25, 41],
                            iconAnchor: [12, 41],
                            popupAnchor: [1, -34]
                        });
                    } else if (i === n - 1) { // End point (Patient)
                        icon = L.icon({
                            iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
                            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                            iconSize: [25, 41],
                            iconAnchor: [12, 41],
                            popupAnchor: [1, -34]
                        });
                    }
                    return L.marker(waypoint.latLng, { icon: icon });
                }
            }).addTo(map);

            routingControl.on('routesfound', function (e) {
                const routes = e.routes;
                if (routes.length > 0) {
                    const summary = routes[0].summary;
                    const instructions = routes[0].instructions;

                    let directionsHTML = `<h3>Directions from ${startName} to ${endName}</h3>`;
                    directionsHTML += `<p><b>Total Distance:</b> ${(summary.totalDistance / 1000).toFixed(2)} km</p>`;
                    directionsHTML += `<p><b>Estimated Time:</b> ${Math.round(summary.totalTime / 60)} minutes</p>`;
                    directionsHTML += '<ol>';
                    instructions.forEach(instruction => {
                        directionsHTML += `<li>${instruction.text} (${(instruction.distance / 1000).toFixed(2)} km)</li>`;
                    });
                    directionsHTML += '</ol>';
                    document.getElementById('directions').innerHTML = directionsHTML;
                } else {
                    document.getElementById('directions').innerHTML = '<h3>Directions</h3><p>No route found.</p>';
                }
            });

            routingControl.on('routingerror', function (e) {
                console.error("Routing error:", e.error);
                document.getElementById('directions').innerHTML = `<h3>Directions</h3><p>Error calculating route: ${e.error.message || 'Unknown error'}</p>`;
            });
        }


        // --- Event Listeners and Initial Setup ---
        goOnlineBtn.addEventListener('click', () => setDriverStatus(true));
        goOfflineBtn.addEventListener('click', () => setDriverStatus(false));

        document.addEventListener('DOMContentLoaded', () => {
            // Initialize map to a default location (e.g., Durban, South Africa, as per current context)
            initializeMap(-29.8587, 31.0218, 13); // Coordinates for Durban

            // Set initial status to offline and update UI accordingly
            setDriverStatus(false);

            // --- Patient Location (simulated as passed via URL parameters) ---
            const urlParams = new URLSearchParams(window.location.search);
            const patientLat = parseFloat(urlParams.get('lat'));
            const patientLng = parseFloat(urlParams.get('lng'));
            const patientAddress = urlParams.get('address');

            if (!isNaN(patientLat) && !isNaN(patientLng)) {
                // Store patient location globally so it can be displayed when driver goes online
                window.patientLocation = { lat: patientLat, lng: patientLng, address: patientAddress };
            } else {
                patientInfoDisplay.textContent = 'Patient Info: No specific patient location provided via URL.';
            }

            // Optional: Initially try to get driver's current location once to set map view
            // (but don't start live tracking unless they click "Go Online")
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        // If the driver is initially offline, this just helps set a more accurate initial map center.
                        // The driver marker itself will only appear when they click "Go Online".
                        if (!driverIsOnline) { // Only adjust initial view if not already online
                            map.setView([position.coords.latitude, position.coords.longitude], 13); // Adjust zoom if needed
                        }
                    },
                    (error) => {
                        console.warn("Could not get initial driver location:", error);
                        statusMessages.textContent = `Could not get initial location: ${error.message}. Please go online to start tracking.`;
                    },
                    { enableHighAccuracy: true, timeout: 5000, maximumAge: 60000 }
                );
            }
        });
    </script>
</body>
</html>