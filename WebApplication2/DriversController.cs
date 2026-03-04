using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Http;
using System.Net;
using System.Net.Http;
// Ensure you have the 'Driver' class and DTOs defined in your project

namespace WebApplication2.Controllers // Adjust namespace as per your project
{
    // Reusing the existing DriversController or creating a new one
    public class DriversController : ApiController
    {
        // ... (Existing GetAvailableDrivers method here) ...

        /// <summary>
        /// Updates a driver's current location in the database.
        /// </summary>
        [HttpPost]
        [Route("api/drivers/updatelocation")]
        public IHttpActionResult UpdateDriverLocation([FromBody] DriverLocationUpdateDto data)
        {
            if (data == null || data.DriverId <= 0)
            {
                return BadRequest("Invalid driver ID or data.");
            }

            string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionStringName"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = @"
                        UPDATE Drivers
                        SET
                            Latitude = @latitude,
                            Longitude = @longitude,
                            Location = GEOGRAPHY::Point(@latitude, @longitude, 4326),
                            LastUpdated = GETUTCDATE()
                        WHERE DriverId = @driverId;";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@driverId", data.DriverId);
                        command.Parameters.AddWithValue("@latitude", data.Latitude);
                        command.Parameters.AddWithValue("@longitude", data.Longitude);
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected == 0)
                        {
                            //return NotFound($"Driver with ID {data.DriverId} not found.");
                        }
                    }
                }
                return Ok(); // Return 200 OK
            }
            catch (Exception ex)
            {
                // Log the exception (e.g., using a logging framework)
                System.Diagnostics.Debug.WriteLine($"Error updating driver location: {ex.Message}");
                return InternalServerError(ex); // Return 500 Internal Server Error
            }
        }

        /// <summary>
        /// Sets a driver's online/offline status.
        /// </summary>
        [HttpPost]
        [Route("api/drivers/setstatus")]
        public IHttpActionResult SetDriverStatus([FromBody] DriverStatusUpdateDto data)
        {
            if (data == null || data.DriverId <= 0)
            {
                return BadRequest("Invalid driver ID or data.");
            }

            string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionStringName"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string newStatusText = data.IsOnline ? "Available" : "Offline";
                    string query = @"
                        UPDATE Drivers
                        SET
                            IsAvailable = @isOnline,
                            Status = @statusText,
                            LastUpdated = GETUTCDATE()
                        WHERE DriverId = @driverId;";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@driverId", data.DriverId);
                        command.Parameters.AddWithValue("@isOnline", data.IsOnline);
                        command.Parameters.AddWithValue("@statusText", newStatusText);
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected == 0)
                        {
                            //return NotFound($"Driver with ID {data.DriverId} not found.");
                        }
                    }
                }
                return Ok(); // Return 200 OK
            }
            catch (Exception ex)
            {
                // Log the exception
                System.Diagnostics.Debug.WriteLine($"Error setting driver status: {ex.Message}");
                return InternalServerError(ex); // Return 500 Internal Server Error
            }
        }
    }
}