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
    public partial class Student_Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();
            Response.Cache.SetRevalidation(System.Web.HttpCacheRevalidation.AllCaches);

            if (Session["Username"] == null || Session["Role"].ToString() != "Student")
            {
                Response.Redirect("Login.aspx",true);
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            string username = Session["Username"]?.ToString();
            string role = Session["Role"]?.ToString();
            int auditID = Convert.ToInt32(Session["AuditID"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                con.Open();

                //  Update LogoutTime based on AuditID (unique record)
                SqlCommand cmd = new SqlCommand(
                    "UPDATE AuditLog SET LogoutTime = @LogoutTime WHERE AuditID = @AuditID", con);

                cmd.Parameters.AddWithValue("@LogoutTime", DateTime.Now);
                cmd.Parameters.AddWithValue("@AuditID", auditID);

                cmd.ExecuteNonQuery();
                con.Close();
            }


            // Clear session and redirect
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btnAssignments_Click(object sender, EventArgs e)
        {
            Response.Redirect("Assignments.aspx");
        }

        protected void btnLecture_Click(object sender, EventArgs e)
        {
            Response.Redirect("Lectures.aspx");
        }

        protected void btnEvents_Click(object sender, EventArgs e)
        {
            Response.Redirect("Events.aspx");
        }

        protected void btnTimetable_Click(object sender, EventArgs e)
        {
            Response.Redirect("Timetable.aspx");
        }
        protected void btnUpdateSemester_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateSemester.aspx");
        }
    }
}
