using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CollegeProject
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                // पहले check करेंगे username या email exist करता है या नहीं
                string checkQuery = "SELECT COUNT(*) FROM Students WHERE Username = @Username OR Email = @Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                con.Open();
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    // Username या Email पहले से मौजूद है
                    Response.Write("<script>alert('This Username or Email is already registered!');</script>");
                }
                else
                {
                    // नया account create करेंगे
                    string insertQuery = "INSERT INTO Students (Username, Password, Email, FirstName, LastName, Semester) " +
                                         "VALUES (@Username, @Password, @Email, @FirstName, @LastName, @Semester)";

                    SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                    insertCmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@Semester", ddlSemester.SelectedValue);

                    insertCmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Account created successfully!'); window.location='Login.aspx';</script>");
                }

                con.Close();
            }
        }
    }
}

