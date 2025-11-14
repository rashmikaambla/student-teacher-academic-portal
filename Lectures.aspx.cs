using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CollegeProject
{
    public partial class Lectures : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["StudentID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
                LoadLectureUpdates();
        }

        private void LoadLectureUpdates()
        {
            // Assuming Student’s semester is stored in Session["Semester"]
            string semester = Session["Semester"].ToString();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = @"
                    SELECT l.Subject, l.Semester, l.Date, l.Status,
                           t.FirstName + ' ' + t.LastName AS TeacherName
                    FROM Lectures l
                    INNER JOIN Teachers t ON l.TeacherID = t.TeacherID
                    WHERE l.Semester = @Semester
                    ORDER BY l.Date DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Semester", semester);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvLectures.DataSource = dt;
                gvLectures.DataBind();
            }
        }
    }
}