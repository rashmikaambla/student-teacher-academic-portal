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
    public partial class Timetable : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["Role"].ToString() != "Student")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindStudentTimetable();
            }
        }

        private void BindStudentTimetable()
        {
            int semester = Convert.ToInt32(Session["Semester"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Timetables WHERE Semester=@Sem ORDER BY UploadedOn DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@Sem", semester);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvStudentTimetables.DataSource = dt;
                gvStudentTimetables.DataBind();
            }
        }
    }
}