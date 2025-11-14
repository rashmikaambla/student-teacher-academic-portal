using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CollegeProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = ddl_stu_tea.SelectedValue;

            if (string.IsNullOrEmpty(role))
            {
                Response.Write("<script>alert('Please select Student or Teacher.');</script>");
                return;
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd;

                if (role == "Student")
                {
                    cmd = new SqlCommand("SELECT StudentID, Username, Semester FROM Students WHERE Username=@Username AND Password=@Password", con);
                }
                else // Teacher
                {
                    cmd = new SqlCommand("SELECT TeacherID, Username FROM Teachers WHERE Username=@Username AND Password=@Password", con);
                }

                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    // Store session details
                    if (role == "Student")
                    {
                        Session["StudentID"] = dr["StudentID"];
                        Session["Semester"] = dr["Semester"];
                    }
                    else
                    {
                        Session["TeacherID"] = dr["TeacherID"];
                    }

                    Session["Username"] = dr["Username"];
                    Session["Role"] = role;

                    dr.Close();

                    // ✅ Insert login record and return AuditID in one go
                    SqlCommand auditCmd = new SqlCommand(@"
                        INSERT INTO AuditLog (Username, Role, LoginTime)
                        OUTPUT INSERTED.AuditID
                        VALUES (@Username, @Role, @LoginTime)", con);

                    auditCmd.Parameters.AddWithValue("@Username", username);
                    auditCmd.Parameters.AddWithValue("@Role", role);
                    auditCmd.Parameters.AddWithValue("@LoginTime", DateTime.Now);

                    // ✅ Execute once and get AuditID
                    int auditID = Convert.ToInt32(auditCmd.ExecuteScalar());

                    // Store AuditID in session
                    Session["AuditID"] = auditID;

                    // Redirect based on role
                    if (role == "Student")
                        Response.Redirect("Student_Home.aspx");
                    else
                        Response.Redirect("Teacher_Home.aspx");
                }
                else
                {
                    dr.Close();
                    Response.Write("<script>alert('Invalid username or password!');</script>");
                }

                con.Close();
            }
        }

        protected void btncreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}
