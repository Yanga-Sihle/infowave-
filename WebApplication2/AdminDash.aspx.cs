using System;
using System.Collections.Generic;
using System.Configuration; // For ConfigurationManager
using System.Data.SqlClient; // For SQL Database access
using System.Web.Script.Serialization; // For JSON serialization
using System.Web.Services; // For [WebMethod]

namespace WebApplication2
{
    public partial class AdminDash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // This runs on initial page load.
            // No direct driver fetching needed here as it's done via AJAX.
        }

        /// <summary>
        /// Retrieves available drivers within a specified radius of a given latitude/longitude.
        /// </summary>
        /// <param name="latitude">The central latitude for the search.</param>
        /// <param name="longitude">The central longitude for the search.</param>
        /// <param name="radiusMeters">The search radius in meters (defaulting to 5000m if not provided by client).</param>
        /// <returns>A JSON string representing a list of available drivers.</returns>
        [WebMethod]
        public static string GetAvailableDrivers(double latitude, double longitude, int radiusMeters = 5000)
        {
            List<object> availableDrivers = new List<object>();
            string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionStringName"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // SQL Query to find drivers within a radius
                    // This example assumes you have a table named 'Drivers' with
                    // columns 'DriverId', 'Name', 'Latitude', 'Longitude', 'IsAvailable'.
                    // It also assumes your SQL Server supports spatial types (SQL Server 2008 R2+).
                    // If not, you'll need to implement haversine formula in C# or use a less precise bounding box.

                    // For SQL Server with Spatial Types:
                    // Using STDistance() with GEOGRAPHY type for accurate distance on a sphere.
                    string query = @"
                        SELECT
                            DriverId,
                            Name,
                            Latitude,
                            Longitude,
                            Status
                        FROM
                            Drivers
                        WHERE
                            IsAvailable = 1
                            AND GEOGRAPHY::Point(Latitude, Longitude, 4326).STDistance(GEOGRAPHY::Point(@latitude, @longitude, 4326)) <= @radiusMeters;";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@latitude", latitude);
                        command.Parameters.AddWithValue("@longitude", longitude);
                        command.Parameters.AddWithValue("@radiusMeters", radiusMeters); // Radius in meters

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                availableDrivers.Add(new
                                {
                                    DriverId = reader["DriverId"] as int? ?? 0, // Handle DBNull
                                    Name = reader["Name"] as string,
                                    Latitude = reader["Latitude"] as double? ?? 0.0,
                                    Longitude = reader["Longitude"] as double? ?? 0.0,
                                    Status = reader["Status"] as string
                                });
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception (e.g., using a logging framework)
                System.Diagnostics.Debug.WriteLine($"Error in GetAvailableDrivers: {ex.Message}");
                // You might want to return an error status or message to the client
                return new JavaScriptSerializer().Serialize(new { error = true, message = "Server error fetching drivers." });
            }

            return new JavaScriptSerializer().Serialize(availableDrivers);
        }
    }
}