using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CollegeProject
{
    public partial class Teacher_Timetable : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["Role"].ToString() != "Teacher")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindTimetables();
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!fuTimetable.HasFile)
            {
                Response.Write("<script>alert('Please select a file');</script>");
                return;
            }

            string semester = ddlSemester.SelectedValue;
            string type = ddlType.SelectedValue;

            if (string.IsNullOrEmpty(semester) || string.IsNullOrEmpty(type))
            {
                Response.Write("<script>alert('Please select both semester and type');</script>");
                return;
            }

            string folderPath = Server.MapPath("~/Uploads/Timetables/");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string fileName = Path.GetFileName(fuTimetable.FileName);
            string filePath = "~/Uploads/Timetables/" + DateTime.Now.Ticks + "_" + fileName;
            fuTimetable.SaveAs(Server.MapPath(filePath));

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "INSERT INTO Timetables (Semester, Type, FilePath, UploadedBy) VALUES (@Semester, @Type, @FilePath, @UploadedBy)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Semester", semester);
                cmd.Parameters.AddWithValue("@Type", type);
                cmd.Parameters.AddWithValue("@FilePath", filePath);
                cmd.Parameters.AddWithValue("@UploadedBy", Session["Username"].ToString());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Write("<script>alert('Timetable uploaded successfully!');</script>");
            BindTimetables();
        }

        private void BindTimetables()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Timetables WHERE UploadedBy=@User ORDER BY UploadedOn DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@User", Session["Username"].ToString());
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvTimetables.DataSource = dt;
                gvTimetables.DataBind();
            }
        }

        protected void gvTimetables_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvTimetables.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand getCmd = new SqlCommand("SELECT FilePath FROM Timetables WHERE TimetableID=@ID", con);
                getCmd.Parameters.AddWithValue("@ID", id);
                string filePath = Convert.ToString(getCmd.ExecuteScalar());

                if (File.Exists(Server.MapPath(filePath)))
                    File.Delete(Server.MapPath(filePath));

                SqlCommand delCmd = new SqlCommand("DELETE FROM Timetables WHERE TimetableID=@ID AND UploadedBy=@User", con);
                delCmd.Parameters.AddWithValue("@ID", id);
                delCmd.Parameters.AddWithValue("@User", Session["Username"].ToString());
                delCmd.ExecuteNonQuery();
            }

            Response.Write("<script>alert('Timetable deleted successfully');</script>");
            BindTimetables();
        }
    }
}