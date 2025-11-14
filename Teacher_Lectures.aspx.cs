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
    public partial class Teacher_Lectures : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TeacherID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
                LoadLectures();
        }

        protected void btnPostLecture_Click(object sender, EventArgs e)
        {
            if (ddlSemester.SelectedValue == "")
            {
                Response.Write("<script>alert('Please select a semester.');</script>");
                return;
            }

            if (string.IsNullOrEmpty(txtDate.Text))
            {
                Response.Write("<script>alert('Please select a lecture date.');</script>");
                return;
            }

            DateTime lectureDate = Convert.ToDateTime(txtDate.Text);

            // 🔹 Allow only current or future dates
            if (lectureDate < DateTime.Now)
            {
                Response.Write("<script>alert('You cannot select a past date. Please choose current or future date.');</script>");
                return;
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = "INSERT INTO Lectures (TeacherID, Subject, Date, Status, Semester) VALUES (@TeacherID, @Subject, @Date, @Status, @Semester)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@TeacherID", Session["TeacherID"]);
                cmd.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                cmd.Parameters.AddWithValue("@Date", lectureDate);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@Semester", ddlSemester.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            txtSubject.Text = "";
            txtDate.Text = "";
            ddlSemester.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;

            LoadLectures();
        }

        private void LoadLectures()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = "SELECT Subject, Semester, Date, Status FROM Lectures WHERE TeacherID = @TeacherID ORDER BY Date DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@TeacherID", Session["TeacherID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvLectures.DataSource = dt;
                gvLectures.DataBind();
            }
        }
    }
}