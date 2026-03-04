using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO; // Required for file operations
using System.Security.AccessControl;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class train : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No specific logic needed here on initial load, as client-side JS handles UI state
        }

        protected void btnRegisterSubmit_Click(object sender, EventArgs e)
        {
            string role = hfSelectedRole.Value; // "Admin" or "First Responder"
            string fullName = txtFullName.Text;
            string email = txtEmail.Text;
            string passwordHash = txtPassword.Text.Trim(); // Your custom method
            string contact = txtContact.Text;
            string baseLocation = locationTextbox.Text.Trim();
            string profilePicturePath = SaveFile(fuProfilePicture); // Optional
            string adminType = ddlAdminType.SelectedValue; // Only needed if Admin

            // Add extra fields for First Responders
            string carMake = txtCarMake.Text.Trim();
            string carModel = txtCarModel.Text.Trim();
            string licensePlate = txtLicensePlate.Text.Trim();
            string carType = txtCarType.Text.Trim();
            string carPicturePath = SaveFile(fuCarPicture);

            string connStr = ConfigurationManager.ConnectionStrings["RescueMedDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlTransaction trans = conn.BeginTransaction();

                try
                {
                    // 1. Insert into Users table
                    string insertUserQuery = @"
                        INSERT INTO Users (Role, FullName, Email, PasswordHash, Contact, BaseLocation, ProfilePicturePath)
                        VALUES (@Role, @FullName, @Email, @PasswordHash, @Contact, @BaseLocation, @ProfilePicturePath);
                        SELECT SCOPE_IDENTITY();
                    ";

                    SqlCommand cmdUser = new SqlCommand(insertUserQuery, conn, trans);
                    cmdUser.Parameters.AddWithValue("@Role", role);
                    cmdUser.Parameters.AddWithValue("@FullName", fullName);
                    cmdUser.Parameters.AddWithValue("@Email", email);
                    cmdUser.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    cmdUser.Parameters.AddWithValue("@Contact", contact);
                    cmdUser.Parameters.AddWithValue("@BaseLocation", baseLocation);
                    cmdUser.Parameters.AddWithValue("@ProfilePicturePath", profilePicturePath ?? (object)DBNull.Value);

                    int newUserId = Convert.ToInt32(cmdUser.ExecuteScalar());

                    string insertVehicleQuery = @"
                   INSERT INTO ResponderVehicles (UserID, CarMake, CarModel, LicensePlate, CarType, CarPicturePath)
                   VALUES (@UserID, @CarMake, @CarModel, @LicensePlate, @CarType, @CarPicturePath)";

                    SqlCommand cmdVehicle = new SqlCommand(insertVehicleQuery, conn, trans);
                    cmdVehicle.Parameters.AddWithValue("@UserID", newUserId);
                    cmdVehicle.Parameters.AddWithValue("@CarMake", carMake);
                    cmdVehicle.Parameters.AddWithValue("@CarModel", carModel);
                    cmdVehicle.Parameters.AddWithValue("@LicensePlate", licensePlate);
                    cmdVehicle.Parameters.AddWithValue("@CarType", carType);
                    cmdVehicle.Parameters.AddWithValue("@CarPicturePath", carPicturePath ?? (object)DBNull.Value);

                    cmdVehicle.ExecuteNonQuery();

                    // 2. If Admin, insert into Admin table


                    string insertAdminsQuery = "INSERT INTO Admins (UserID, AdminType, AdminName) VALUES (@UserID, @AdminType,@AdminName)";
                        SqlCommand cmdAdmin = new SqlCommand(insertAdminsQuery, conn, trans);
                        cmdAdmin.Parameters.AddWithValue("@UserID", newUserId);
                        cmdAdmin.Parameters.AddWithValue("@AdminType", adminType);
                        cmdAdmin.Parameters.AddWithValue("@AdminName", fullName);
                    cmdAdmin.ExecuteNonQuery();
                    

                    trans.Commit();
                    lblMessage.Text = "Registration successful!";
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }

        private string SaveFile(System.Web.UI.WebControls.FileUpload upload)
        {
            if (upload.HasFile)
            {
                string folder = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folder))
                {
                    Directory.CreateDirectory(folder);
                }

                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(upload.FileName);
                string path = Path.Combine(folder, fileName);
                upload.SaveAs(path);

                return "~/Uploads/" + fileName;
            }
            return null;
        }
    }
}