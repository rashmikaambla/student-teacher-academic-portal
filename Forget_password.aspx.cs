using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CollegeProject
{
    public partial class Forget_password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(newPassword))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please fill all required fields.');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                // Check if email exists
                string checkQuery = "SELECT COUNT(*) FROM Students WHERE Email = @Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Email", email);

                con.Open();
                int count = (int)checkCmd.ExecuteScalar();

                if (count == 0)
                {
                    // Email not found
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This email is not registered.');", true);
                }
                else
                {
                    // Update password
                    string updateQuery = "UPDATE Students SET Password = @Password WHERE Email = @Email";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@Password", newPassword);
                    updateCmd.Parameters.AddWithValue("@Email", email);

                    updateCmd.ExecuteNonQuery();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Password updated successfully!'); window.location='Login.aspx';", true);
                }

                con.Close();
            }
        }
    }
}