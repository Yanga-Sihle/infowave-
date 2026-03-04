<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HELPDR.aspx.cs" Inherits="WebApplication2.HELPDR" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emergency Help System</title>
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <!-- Leaflet Routing Machine CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .container {
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        #status {
            margin-top: 20px;
            font-size: 18px;
        }
        #map {
            width: 90%;
            height: 400px;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        #directions {
            margin-top: 20px;
            width: 90%;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Emergency Help System</h1>
        <p>Share your location to find nearby health facilities and get directions.</p>
        <button onclick="shareLocation()">Share My Location</button>
        <div id="status"></div>
    </div>

    <!-- Map Container -->
    <div id="map"></div>

    <!-- Directions Panel -->
    <div id="directions"></div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <!-- Leaflet Routing Machine JS -->
    <script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>
    <script>
        let map;
        let userMarker;
        let healthFacilities = [];
        let routingControl;

        // Function to share user location
        function shareLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(async (position) => {
                    const { latitude, longitude } = position.coords;

                    // Update map
                    if (!map) {
                        map = L.map('map').setView([latitude, longitude], 13);
                        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                            attribution: '© OpenStreetMap contributors'
                        }).addTo(map);
                    } else {
                        map.setView([latitude, longitude], 13);
                    }

                    // Add or update user marker
                    if (userMarker) {
                        userMarker.setLatLng([latitude, longitude]);
                    } else {
                        userMarker = L.marker([latitude, longitude], {
                            icon: L.icon({
                                iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-icon.png',
                                iconSize: [25, 41],
                                iconAnchor: [12, 41],
                            }),
                        }).addTo(map);
                    }

                    // Reverse geocode user location to get city and region
                    const userAddress = await reverseGeocode(latitude, longitude);
                    document.getElementById('status').innerHTML = `Your location: ${userAddress}`;

                    // Fetch nearby health facilities
                    await fetchNearbyHealthFacilities(latitude, longitude);
                }, (error) => {
                    document.getElementById('status').innerHTML = `Error: ${error.message}`;
                });
            } else {
                document.getElementById('status').innerHTML = "Geolocation is not supported by this browser.";
            }
        }

        // Function to fetch nearby health facilities using Overpass API
        async function fetchNearbyHealthFacilities(lat, lng) {
            const radius = 5000; // Search within 5 km
            const overpassUrl = `https://overpass-api.de/api/interpreter?data=[out:json];node[amenity=hospital](around:${radius},${lat},${lng});out;`;

            try {
                const response = await fetch(overpassUrl);
                const data = await response.json();

                // Clear existing health facility markers
                healthFacilities.forEach(marker => map.removeLayer(marker));
                healthFacilities = [];

                // Add new health facility markers
                for (const facility of data.elements) {
                    const { lat: facilityLat, lon: facilityLng, tags } = facility;

                    // Reverse geocode facility location to get city and region
                    const facilityAddress = await reverseGeocode(facilityLat, facilityLng);

                    const marker = L.marker([facilityLat, facilityLng], {
                        icon: L.icon({
                            iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-icon-2x.png',
                            iconSize: [25, 41],
                            iconAnchor: [12, 41],
                        }),
                    }).addTo(map);

                    // Add popup with facility name and address
                    if (tags && tags.name) {
                        marker.bindPopup(`<b>${tags.name}</b><br>${facilityAddress}<br><button onclick="getDirections(${facilityLat}, ${facilityLng})">Get Directions</button>`);
                    } else {
                        marker.bindPopup(`<b>Unknown Facility</b><br>${facilityAddress}<br><button onclick="getDirections(${facilityLat}, ${facilityLng})">Get Directions</button>`);
                    }

                    healthFacilities.push(marker);
                }

                document.getElementById('status').innerHTML += `<br>Found ${data.elements.length} health facilities nearby.`;
            } catch (error) {
                console.error("Error fetching health facilities:", error);
                document.getElementById('status').innerHTML += `<br>Error fetching health facilities.`;
            }
        }

        // Function to get directions to a facility
        function getDirections(facilityLat, facilityLng) {
            if (!userMarker) {
                alert("Please share your location first.");
                return;
            }

            if (routingControl) {
                map.removeControl(routingControl);
            }

            const userLatLng = userMarker.getLatLng();
            routingControl = L.Routing.control({
                waypoints: [
                    L.latLng(userLatLng.lat, userLatLng.lng), // User's location
                    L.latLng(facilityLat, facilityLng) // Facility location
                ],
                routeWhileDragging: true,
                show: true, // Show the directions panel
                collapsible: true,
            }).addTo(map);

            // Display directions in the directions panel
            routingControl.on('routesfound', function (e) {
                const routes = e.routes;
                const summary = routes[0].summary;
                const instructions = routes[0].instructions;

                let directionsHTML = '<h3>Directions</h3>';
                directionsHTML += `<p><b>Total Distance:</b> ${(summary.totalDistance / 1000).toFixed(2)} km</p>`;
                directionsHTML += `<p><b>Estimated Time:</b> ${(summary.totalTime / 60).toFixed(2)} minutes</p>`;
                directionsHTML += '<ol>';
                instructions.forEach(instruction => {
                    directionsHTML += `<li>${instruction.text}</li>`;
                });
                directionsHTML += '</ol>';

                document.getElementById('directions').innerHTML = directionsHTML;
            });
        }

        // Function to reverse geocode coordinates to city and region
        async function reverseGeocode(lat, lng) {
            const url = `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}&zoom=18&addressdetails=1`;

            try {
                const response = await fetch(url, {
                    headers: {
                        'Accept': 'application/json'
                    }
                });
                const data = await response.json();

                if (data && data.display_name) {
                    return data.display_name;
                }
                return "Address not found";
            } catch (error) {
                console.error("Error reverse geocoding:", error);
                return "Address not found";
            }
        }
    </script>
</body>
</html>