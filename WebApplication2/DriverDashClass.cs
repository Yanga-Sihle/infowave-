using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2
{
    // If you're using a separate Web API project, ensure this model exists
    // If you're using a single project with [WebMethod], you can use anonymous objects directly.
    public class Driver
    {
        public int DriverId { get; set; }
        public string Name { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public bool IsAvailable { get; set; } // Added for online/offline
        public string Status { get; set; }    // e.g., "Available", "On Duty", "Offline"
                                              // Add other properties as needed
    }

    // DTO for location updates
    public class DriverLocationUpdateDto
    {
        public int DriverId { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
    }

    // DTO for status updates
    public class DriverStatusUpdateDto
    {
        public int DriverId { get; set; }
        public bool IsOnline { get; set; }
    }
}