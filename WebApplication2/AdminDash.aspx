<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDash.aspx.cs" Inherits="WebApplication2.AdminDash" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
           /* background-color: #f4f4f4;*/
            box-sizing: border-box;
             background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('pexels-marek-piwnicki-3907296-17277448.jpg') no-repeat center center fixed;
            background-size: cover;
             color: #333;
        }
        h1 {
            text-align: center;
            color: #ff4444;
            margin-bottom: 30px;
        }
        .container {
            max-width: 1300px;
            margin: 0 auto;
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            justify-content: center;
        }
        .section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            flex: 1; /* Allows sections to grow and shrink */
            min-width: 350px; /* Minimum width before wrapping */
            max-width: calc(33.333% - 17px); /* Approximately three columns, considering gap */
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
        }

        /* Specific styling for the map section to potentially take more space or align differently */
        #mapSection {
            flex-basis: 100%; /* Map section spans full width */
            min-width: unset; /* Remove min-width constraint */
            max-width: unset; /* Remove max-width constraint */
            height: 450px; /* Give it a fixed height */
            padding: 0; /* Map container handles padding internally */
            overflow: hidden; /* Ensure map doesn't overflow rounded corners */
        }
        #map {
            height: 100%; /* Map fills its container */
            width: 100%;
            border-radius: 10px; /* Match section border-radius */
        }

        @media (max-width: 1200px) { /* Adjust for smaller screens to allow 2 columns */
            .section {
                max-width: calc(50% - 15px); /* Two columns */
            }
            #mapSection {
                max-width: 100%; /* Map still takes full width */
            }
        }

        @media (max-width: 768px) { /* Stack all sections on even smaller screens */
            .section {
                max-width: 100%; /* Stack all sections */
                min-width: unset; /* Remove min-width */
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            flex-grow: 1;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #ff4444;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        button {
            padding: 8px 15px;
            background-color: #ff4444;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            margin-top: 10px;
            transition: background-color 0.2s ease;
        }
        button:hover {
            background-color: #cc0000;
        }
        .filters {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .filters label {
            margin-right: 10px;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 8px;
        }
        .filters input[type="number"],
        .filters input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 10px;
            width: 120px;
            box-sizing: border-box; /* Crucial for input width consistency */
        }
        .filters input[type="text"] {
            width: calc(100% - 20px); /* Adjust width for padding */
            min-width: 250px;
            margin-bottom: 10px;
        }
        .notification {
            background-color: #ff4444;
            color: white;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 25px;
            text-align: center;
            font-weight: bold;
            display: none;
        }
        #directions {
            /* This is now its own section, so some map-container styles move here */
            margin-top: 0px; /* No top margin as it's a new card */
            padding: 25px; /* Match section padding */
            background-color: #f9f9f9; /* Retain background */
            border: 1px solid #ddd; /* Retain border */
            border-radius: 10px; /* Match section border-radius */
            max-height: 400px; /* Limit height for directions panel */
            overflow-y: auto;
            box-sizing: border-box; /* Important for flexbox layout */
        }
        #directions h3 {
            color: #333;
            margin-top: 0;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        #directions ol {
            padding-left: 20px;
            list-style-type: decimal;
        }
        #directions li {
            margin-bottom: 8px;
            line-height: 1.4;
        }
        #patientAddressSuggestion {
            font-size: 0.9em;
            color: #555;
            margin-top: -5px;
            margin-bottom: 15px;
            min-height: 1.2em;
        }
        #map-status {
            margin-top: 15px;
            padding: 10px;
            background-color: #e9e9e9;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1>Admin Dashboard</h1>
    <div class="notification" id="notification">New emergency reported!</div>
    <div class="container">
       <div class="section">
     <h2>Reported Emergencies</h2>
     <div class="filters">
          <label for="emergencyStatusFilter">Filter by Status:</label>
          <select id="emergencyStatusFilter" onchange="fetchEmergencies()">
              <option value="all">All</option>
              <option value="pending">Pending</option>
              <option value="assigned">Assigned</option>
              <option value="resolved">Resolved</option>
          </select>
     </div>
     <table id="emergenciesTable">
          <thead>
              <tr>
                  <th>Emergency ID</th>
                  <th>Location</th>
                  <th>Status</th>
                  <th>Action</th>
              </tr>
          </thead>
          <tbody>
          </tbody>
     </table>
</div>
        <div class="section">
            <h2>Available Volunteers</h2>
            <div class="filters">
                <label for="volunteerStatusFilter">Filter by Status:</label>
                <select id="volunteerStatusFilter" onchange="fetchVolunteers()">
                    <option value="available">Available</option>
                    <option value="assigned">Assigned</option>
                </select>
            </div>
            <table id="volunteersTable">
                <thead>
                    <tr>
                        <th>Volunteer ID</th>
                        <th>Name</th>
                        <th>Location</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    </tbody>
            </table>
        </div>

        <div class="section">
            <h2>Patient Location & Driver Finder</h2>
            <div class="filters">
                <label for="patientAddress">Patient Address:</label>
                <input type="text" id="patientAddress" placeholder="e.g., 123 Main Street, Sandton" oninput="debounceSearch()"><br />
                <div id="patientAddressSuggestion"></div>
                <button onclick="locatePatientAndShowDrivers()">Locate Patient & Show Drivers</button>
                <hr style="margin: 20px 0;" />
                <p style="margin-bottom: 10px; font-weight: bold;">Or manually enter coordinates:</p>
                <div>
                    <label for="centerLatitude">Latitude:</label>
                    <input type="number" id="centerLatitude" value="-26.1061" step="0.0001">
                </div>
                <div style="margin-top: 10px;">
                    <label for="centerLongitude">Longitude:</label>
                    <input type="number" id="centerLongitude" value="28.0556" step="0.0001">
                </div>
                <button onclick="updateMapWithDrivers(true)">Show Drivers at Manual Coords</button>
            </div>
            <div id="map-status" style="margin-top: 10px; font-weight: bold;"></div>
        </div>

        <div class="section" id="mapSection">
            <h2>Map Display</h2>
            <div id="map"></div>
        </div>

        <div class="section">
            <h2>Directions</h2>
            <div id="directions"></div>
        </div>

    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>

    <script>
        let map;
        let driverMarkers = [];
        let emergencyMarkers = [];
        let patientLocationMarker;
        let routingControl;

        const defaultLat = -26.1061; // Sandton Latitude
        const defaultLng = 28.0556; // Sandton Longitude

        let searchTimeout;
        const SEARCH_DELAY = 800;

        function initializeMap(lat = defaultLat, lng = defaultLng, zoom = 13) {
            if (!map) {
                map = L.map('map').setView([lat, lng], zoom);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '© OpenStreetMap contributors'
                }).addTo(map);
            } else {
                map.setView([lat, lng], zoom);
            }
            clearMarkers(driverMarkers);
            clearMarkers(emergencyMarkers);
            if (patientLocationMarker) {
                map.removeLayer(patientLocationMarker);
                patientLocationMarker = null;
            }
            if (routingControl) {
                map.removeControl(routingControl);
                routingControl = null;
                document.getElementById('directions').innerHTML = '';
            }
        }

        function clearMarkers(markerArray) {
            markerArray.forEach(marker => {
                if (map.hasLayer(marker)) {
                    map.removeLayer(marker);
                }
            });
            markerArray.length = 0;
        }

        async function geocodeAddress(address) {
            document.getElementById('map-status').innerHTML = "Locating address...";
            const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(address)}&limit=1`;
            try {
                const response = await fetch(url);
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const data = await response.json();
                if (data && data.length > 0) {
                    const lat = parseFloat(data[0].lat);
                    const lon = parseFloat(data[0].lon);
                    document.getElementById('map-status').innerHTML = `Address found: ${data[0].display_name}`;
                    return { lat, lng: lon, displayName: data[0].display_name };
                } else {
                    document.getElementById('map-status').innerHTML = "Address not found.";
                    return null;
                }
            } catch (error) {
                console.error("Error geocoding address:", error);
                document.getElementById('map-status').innerHTML = `Error locating address: ${error.message}`;
                return null;
            }
        }

        function debounceSearch() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(async () => {
                const address = document.getElementById('patientAddress').value.trim();
                const suggestionDiv = document.getElementById('patientAddressSuggestion');

                if (address.length > 3) {
                    const geocodedLocation = await geocodeAddress(address);

                    if (geocodedLocation) {
                        const { lat, lng, displayName } = geocodedLocation;

                        suggestionDiv.textContent = `Found: ${displayName}`;
                        suggestionDiv.style.color = 'green';

                        document.getElementById('centerLatitude').value = lat;
                        document.getElementById('centerLongitude').value = lng;

                        initializeMap(lat, lng, 15);

                        if (patientLocationMarker) {
                            map.removeLayer(patientLocationMarker);
                            patientLocationMarker = null;
                        }
                        patientLocationMarker = L.marker([lat, lng], {
                            icon: L.icon({
                                iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
                                shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                                iconSize: [25, 41],
                                iconAnchor: [12, 41],
                                popupAnchor: [1, -34]
                            })
                        }).addTo(map);
                        patientLocationMarker.bindPopup(`<b>Patient Location:</b><br>${displayName}`).openPopup();

                        const driversFound = await fetchAvailableDrivers(lat, lng);
                        document.getElementById('map-status').innerHTML = `Address found: ${displayName}<br>`;
                        if (driversFound > 0) {
                            document.getElementById('map-status').innerHTML += `Found ${driversFound} available drivers.`;
                        } else {
                            document.getElementById('map-status').innerHTML += `No available drivers found.`;
                        }

                    } else {
                        if (patientLocationMarker) {
                            map.removeLayer(patientLocationMarker);
                            patientLocationMarker = null;
                        }
                        clearMarkers(driverMarkers);
                        document.getElementById('map-status').innerHTML = "No matching address found.";
                        suggestionDiv.textContent = "No address found for this input.";
                        suggestionDiv.style.color = 'red';
                    }
                } else if (address.length === 0) {
                    initializeMap(defaultLat, defaultLng);
                    updateMapWithDrivers();
                    document.getElementById('map-status').innerHTML = "";
                    suggestionDiv.textContent = "";
                } else {
                    suggestionDiv.textContent = "Keep typing for suggestions...";
                    suggestionDiv.style.color = '#555';
                }
            }, SEARCH_DELAY);
        }

        async function locatePatientAndShowDrivers() {
            const address = document.getElementById('patientAddress').value.trim();
            if (!address) {
                alert("Please enter a patient address.");
                return;
            }

            const geocodedLocation = await geocodeAddress(address);
            const suggestionDiv = document.getElementById('patientAddressSuggestion');

            if (geocodedLocation) {
                const { lat, lng, displayName } = geocodedLocation;

                suggestionDiv.textContent = `Found: ${displayName}`;
                suggestionDiv.style.color = 'green';

                document.getElementById('centerLatitude').value = lat;
                document.getElementById('centerLongitude').value = lng;

                initializeMap(lat, lng, 15);

                if (patientLocationMarker) {
                    map.removeLayer(patientLocationMarker);
                    patientLocationMarker = null;
                }
                patientLocationMarker = L.marker([lat, lng], {
                    icon: L.icon({
                        iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
                        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34]
                    })
                }).addTo(map);
                patientLocationMarker.bindPopup(`<b>Patient Location:</b><br>${displayName}`).openPopup();

                const driversFound = await fetchAvailableDrivers(lat, lng);
                document.getElementById('map-status').innerHTML = `Address found: ${displayName}<br>`;
                if (driversFound > 0) {
                    document.getElementById('map-status').innerHTML += `Found ${driversFound} available drivers.`;
                } else {
                    document.getElementById('map-status').innerHTML += `No available drivers found.`;
                }

            } else {
                suggestionDiv.textContent = "No address found for this input.";
                suggestionDiv.style.color = 'red';
            }
        }

        async function fetchAvailableDrivers(latitude, longitude) {
            document.getElementById('map-status').innerHTML = "Fetching available drivers...";
            try {
                // In a real application, replace this with an actual API call to your backend
                // For demonstration, we'll use dummy data based on proximity to Sandton
                const dummyDrivers = [
                    { DriverId: 'DRV001', Name: 'Sipho Dlamini', Status: 'available', Latitude: -26.1100, Longitude: 28.0550 },
                    { DriverId: 'DRV002', Name: 'Naledi Mokoena', Status: 'available', Latitude: -26.1000, Longitude: 28.0600 },
                    { DriverId: 'DRV003', Name: 'Thabo Ndlovu', Status: 'available', Latitude: -26.1200, Longitude: 28.0450 },
                    { DriverId: 'DRV004', Name: 'Lindiwe Khoza', Status: 'assigned', Latitude: -26.0900, Longitude: 28.0500 },
                    { DriverId: 'DRV005', Name: 'Musa Zulu', Status: 'available', Latitude: -26.1080, Longitude: 28.0580 }
                ];

                // Filter drivers by status and a simulated proximity (e.g., within 0.02 degrees lat/lng)
                const availableNearbyDrivers = dummyDrivers.filter(driver =>
                    driver.Status === 'available' &&
                    Math.abs(driver.Latitude - latitude) < 0.02 &&
                    Math.abs(driver.Longitude - longitude) < 0.02
                );

                addDriverMarkers(availableNearbyDrivers);
                return availableNearbyDrivers.length;

            } catch (error) {
                console.error("Error fetching available drivers:", error);
                document.getElementById('map-status').innerHTML = `Error fetching drivers: ${error.message}`;
                return 0;
            }
        }

        function addDriverMarkers(drivers) {
            clearMarkers(driverMarkers);
            drivers.forEach(driver => {
                if (driver.Latitude && driver.Longitude) {
                    const marker = L.marker([driver.Latitude, driver.Longitude], {
                        icon: L.icon({
                            iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
                            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                            iconSize: [25, 41],
                            iconAnchor: [12, 41],
                            popupAnchor: [1, -34]
                        })
                    }).addTo(map);
                    let popupContent = `<b>Driver ID:</b> ${driver.DriverId || 'N/A'}`;
                    if (driver.Name) {
                        popupContent += `<br><b>Name:</b> ${driver.Name}`;
                    }
                    if (driver.Status) {
                        popupContent += `<br><b>Status:</b> ${driver.Status}`;
                    }
                    if (patientLocationMarker) {
                        const patientLat = patientLocationMarker.getLatLng().lat;
                        const patientLng = patientLocationMarker.getLatLng().lng;
                        popupContent += `<br><button onclick="getDirectionsFromPatientToDriver(${patientLat}, ${patientLng}, ${driver.Latitude}, ${driver.Longitude})">Route Patient to Driver</button>`;
                    } else {
                        popupContent += `<br><button onclick="getDirectionsToDriver(${driver.Latitude}, ${driver.Longitude})">Route from Manual Coords</button>`;
                    }

                    marker.bindPopup(popupContent);
                    driverMarkers.push(marker);
                }
            });
        }

        async function updateMapWithDrivers(fromManualInput = false) {
            const lat = parseFloat(document.getElementById('centerLatitude').value);
            const lng = parseFloat(document.getElementById('centerLongitude').value);

            if (isNaN(lat) || isNaN(lng)) {
                alert("Please enter valid latitude and longitude for the center location.");
                return;
            }

            if (fromManualInput && patientLocationMarker) {
                map.removeLayer(patientLocationMarker);
                patientLocationMarker = null;
                document.getElementById('patientAddress').value = '';
                document.getElementById('patientAddressSuggestion').textContent = '';
            }

            initializeMap(lat, lng);
            const driversFound = await fetchAvailableDrivers(lat, lng);
            if (driversFound > 0) {
                document.getElementById('map-status').innerHTML = `Found ${driversFound} available drivers.`;
            } else {
                document.getElementById('map-status').innerHTML = `No available drivers found.`;
            }
        }

        let emergencies = [
            { id: 1, location: "123 Main St, Sandton", status: "pending", lat: -26.1010, lng: 28.0500 },
            { id: 2, location: "456 Oak Ave, Randburg", status: "assigned", lat: -26.0829, lng: 27.9942 },
            { id: 3, location: "789 Pine Rd, Soweto", status: "resolved", lat: -26.2625, lng: 27.8687 },
            { id: 4, location: "101 Elm Blvd, Johannesburg CBD", status: "pending", lat: -26.2041, lng: 28.0473 }
        ];

        let volunteers = [
            { id: 101, name: "Alice Smith", location: "Sandton", status: "available", lat: -26.1050, lng: 28.0560 },
            { id: 102, name: "Bob Johnson", location: "Randburg", status: "assigned", lat: -26.0750, lng: 27.9900 },
            { id: 103, name: "Charlie Brown", location: "Soweto", status: "available", lat: -26.2700, lng: 27.8700 }
        ];

        function fetchEmergencies() {
            const filter = document.getElementById('emergencyStatusFilter').value;
            const tableBody = document.querySelector('#emergenciesTable tbody');
            tableBody.innerHTML = '';

            clearMarkers(emergencyMarkers);

            emergencies.filter(e => filter === 'all' || e.status === filter).forEach(emergency => {
                const row = tableBody.insertRow();
                row.insertCell(0).textContent = emergency.id;
                row.insertCell(1).textContent = emergency.location;
                row.insertCell(2).textContent = emergency.status;
                const actionCell = row.insertCell(3);

                const assignButton = document.createElement('button');
                assignButton.textContent = 'Assign';
                assignButton.onclick = () => assignEmergency(emergency.id);
                actionCell.appendChild(assignButton);

                const viewMapButton = document.createElement('button');
                viewMapButton.textContent = 'View on Map';
                viewMapButton.onclick = () => viewEmergencyOnMap(emergency.lat, emergency.lng, emergency.location);
                actionCell.appendChild(viewMapButton);

                if (emergency.lat && emergency.lng) {
                    const marker = L.marker([emergency.lat, emergency.lng], {
                        icon: L.icon({
                            iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
                            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                            iconSize: [25, 41],
                            iconAnchor: [12, 41],
                            popupAnchor: [1, -34]
                        })
                    }).addTo(map);
                    marker.bindPopup(`<b>Emergency ID:</b> ${emergency.id}<br><b>Location:</b> ${emergency.location}<br><b>Status:</b> ${emergency.status}`);
                    emergencyMarkers.push(marker);
                }
            });
        }

        function assignEmergency(id) {
            alert(`Assigning emergency ${id}`);
            const emergency = emergencies.find(e => e.id === id);
            if (emergency) {
                emergency.status = 'assigned';
                fetchEmergencies();
            }
        }

        async function viewEmergencyOnMap(lat, lng, locationName) {
            if (patientLocationMarker) {
                map.removeLayer(patientLocationMarker);
                patientLocationMarker = null;
            }
            document.getElementById('patientAddress').value = '';
            document.getElementById('patientAddressSuggestion').textContent = '';

            initializeMap(lat, lng, 15);
            const emergencyLocationMarker = L.marker([lat, lng], {
                icon: L.icon({
                    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
                    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                    iconSize: [25, 41],
                    iconAnchor: [12, 41],
                    popupAnchor: [1, -34]
                })
            }).addTo(map);
            emergencyLocationMarker.bindPopup(`<b>Emergency Location:</b> ${locationName}`).openPopup();
            emergencyMarkers.push(emergencyLocationMarker);

            const driversFound = await fetchAvailableDrivers(lat, lng);
            document.getElementById('map-status').innerHTML = `Emergency location: ${locationName}<br>`;
            if (driversFound > 0) {
                document.getElementById('map-status').innerHTML += `Found ${driversFound} available drivers.`;
            } else {
                document.getElementById('map-status').innerHTML += `No available drivers found.`;
            }
        }

        function fetchVolunteers() {
            const filter = document.getElementById('volunteerStatusFilter').value;
            const tableBody = document.querySelector('#volunteersTable tbody');
            tableBody.innerHTML = '';

            volunteers.filter(v => filter === 'all' || v.status === filter).forEach(volunteer => {
                const row = tableBody.insertRow();
                row.insertCell(0).textContent = volunteer.id;
                row.insertCell(1).textContent = volunteer.name;
                row.insertCell(2).textContent = volunteer.location;
                row.insertCell(3).textContent = volunteer.status;
            });
        }

        function getDirectionsToDriver(driverLat, driverLng) {
            if (routingControl) {
                map.removeControl(routingControl);
            }
            document.getElementById('directions').innerHTML = '';

            const startLat = parseFloat(document.getElementById('centerLatitude').value);
            const startLng = parseFloat(document.getElementById('centerLongitude').value);

            if (isNaN(startLat) || isNaN(startLng)) {
                alert("Please ensure the admin's specified starting location (latitude and longitude) is valid.");
                return;
            }

            const startPoint = L.latLng(startLat, startLng);
            const endPoint = L.latLng(driverLat, driverLng);

            renderRoute(startPoint, endPoint, "Admin Manual Location", "Driver Location");
        }

        function getDirectionsFromPatientToDriver(patientLat, patientLng, driverLat, driverLng) {
            if (routingControl) {
                map.removeControl(routingControl);
            }
            document.getElementById('directions').innerHTML = '';

            const startPoint = L.latLng(patientLat, patientLng);
            const endPoint = L.latLng(driverLat, driverLng);

            renderRoute(startPoint, endPoint, "Patient Location", "Driver Location");
        }

        function renderRoute(startPoint, endPoint, startName, endName) {
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
                    if (i === 0) {
                        icon = L.icon({
                            iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
                            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                            iconSize: [25, 41],
                            iconAnchor: [12, 41],
                            popupAnchor: [1, -34]
                        });
                    } else if (i === n - 1) {
                        icon = L.icon({
                            iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
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
                        directionsHTML += `<li>${instruction.text}</li>`;
                    });
                    directionsHTML += '</ol>';

                    document.getElementById('directions').innerHTML = directionsHTML;
                } else {
                    document.getElementById('directions').innerHTML = 'No route found.';
                }
            });

            routingControl.on('routingerror', function (e) {
                console.error("Routing error:", e.error);
                document.getElementById('directions').innerHTML = `Error calculating route: ${e.error.message || 'Unknown error'}`;
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            initializeMap(defaultLat, defaultLng);
            fetchEmergencies();
            fetchVolunteers();
            updateMapWithDrivers();
        });

        setTimeout(() => {
            document.getElementById('notification').style.display = 'block';
            setTimeout(() => {
                document.getElementById('notification').style.display = 'none';
            }, 5000);
        }, 5000);
    </script>
</body>
</html>