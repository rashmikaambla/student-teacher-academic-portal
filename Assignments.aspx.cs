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
    public partial class Assignments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["StudentID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadAssignments();
            }
        }

        private void LoadAssignments()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = @"
            SELECT AssignmentID, Topic, Description, Deadline, '' AS FilePath
            FROM Assignments
            WHERE Semester = @Semester
            ORDER BY Deadline ASC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@Semester", Session["Semester"]);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAssignments.DataSource = dt;
                gvAssignments.DataBind();

                // Disable upload buttons for expired deadlines
                foreach (GridViewRow row in gvAssignments.Rows)
                {
                    // Get deadline from GridView cell (column index 2 is 'Deadline')
                    DateTime deadline = DateTime.Parse(row.Cells[2].Text);
                    Button btnUpload = (Button)row.FindControl("btnUpload");

                    if (btnUpload != null && DateTime.Now > deadline)
                    {
                        btnUpload.Enabled = false;
                        btnUpload.CssClass = "btn btn-secondary btn-upload mt-1 disabled";
                        btnUpload.Text = "Deadline Passed";
                    }
                }
            }
        }


        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            FileUpload fu = (FileUpload)row.FindControl("fuSubmit");
            int assignmentID = Convert.ToInt32(btn.CommandArgument);

            // 🔹 Check if deadline has passed (server-side security)
            DateTime deadline;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                SqlCommand checkCmd = new SqlCommand("SELECT Deadline FROM Assignments WHERE AssignmentID=@AssignmentID", con);
                checkCmd.Parameters.AddWithValue("@AssignmentID", assignmentID);
                con.Open();
                object result = checkCmd.ExecuteScalar();
                con.Close();

                if (result == null || !DateTime.TryParse(result.ToString(), out deadline))
                {
                    Response.Write("<script>alert('Assignment not found.');</script>");
                    return;
                }
            }

            if (DateTime.Now > deadline)
            {
                Response.Write("<script>alert('Deadline has passed. You cannot upload this assignment.');</script>");
                return;
            }

            if (!fu.HasFile)
            {
                Response.Write("<script>alert('Please select a file to upload.');</script>");
                return;
            }

            string extension = Path.GetExtension(fu.FileName).ToLower();
            string allowedExtensions = ".pdf,.doc,.docx,.txt";

            if (!allowedExtensions.Contains(extension))
            {
                Response.Write("<script>alert('Only PDF, DOC, DOCX, TXT files are allowed.');</script>");
                return;
            }

            // 🔹 Save file
            string folderPath = Server.MapPath("~/Assignments_Submitted/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fileName = $"Assignment_{assignmentID}_Student_{Session["StudentID"]}_{fu.FileName}";
            string filePath = Path.Combine(folderPath, fileName);
            fu.SaveAs(filePath);

            // 🔹 Insert submission record
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = @"INSERT INTO Assignment_Submissions (AssignmentID, StudentID, FilePath, SubmissionDate)
                                 VALUES (@AssignmentID, @StudentID, @FilePath, @SubmissionDate)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@AssignmentID", assignmentID);
                cmd.Parameters.AddWithValue("@StudentID", Session["StudentID"]);
                cmd.Parameters.AddWithValue("@FilePath", "/Assignments_Submitted/" + fileName);
                cmd.Parameters.AddWithValue("@SubmissionDate", DateTime.Now);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Write("<script>alert('Assignment uploaded successfully!');</script>");
            }
        }
    }
}