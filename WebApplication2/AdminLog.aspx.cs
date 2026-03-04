using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class AdminLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnlogin_Click1(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtpass.Text;

            string connStr = ConfigurationManager.ConnectionStrings["RescueMedDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string query = @"
        SELECT Email, PasswordHash
        FROM Users
        WHERE LTRIM(RTRIM(Email)) = LTRIM(RTRIM(@Email)) 
          AND (Role = 'SysAdmin' OR Role = 'RegionalManager');
    ";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string storedHash = reader["PasswordHash"] != DBNull.Value
                        ? reader["PasswordHash"].ToString()
                        : string.Empty;

                    if (storedHash == password) // Note: ideally compare hashed password
                    {
                        Session["Email"] = email;
                        lblMessage.Text = "Admin login successful.";
                        Response.Redirect("AdminDash.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Incorrect password.";
                    }
                }
                else
                {
                    lblMessage.Text = "Admin with this email not found.";
                }
            }


        }

    }
    
}
