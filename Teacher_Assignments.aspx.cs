using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CollegeProject
{
    public partial class Teacher_Assignments : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TeacherID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
                LoadAssignments();
        }

        protected void btnSaveAssignment_Click(object sender, EventArgs e)
        {
            // ✅ Validate deadline before inserting into DB
            DateTime deadline;
            if (!DateTime.TryParse(txtDeadline.Text, out deadline))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Please select a valid deadline date.');", true);
                return;
            }

            if (deadline < DateTime.Now)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Deadline cannot be in the past. Please select today or a future date.');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = "INSERT INTO Assignments (Topic, Description, Deadline, TeacherID, Semester) VALUES (@Topic,@Description,@Deadline,@TeacherID,@Semester)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Topic", txtTopic.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Deadline", deadline);
                cmd.Parameters.AddWithValue("@TeacherID", Session["TeacherID"]);
                cmd.Parameters.AddWithValue("@Semester", ddlSemester.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // ✅ Clear fields
            txtTopic.Text = "";
            txtDescription.Text = "";
            txtDeadline.Text = "";
            ddlSemester.SelectedIndex = 0;

            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Assignment saved successfully!');", true);

            LoadAssignments();
        }

        private void LoadAssignments()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = @"
                    SELECT a.AssignmentID, a.Topic, a.Deadline,
                           COUNT(sub.SubmissionID) AS SubmittedCount,
                           (SELECT COUNT(*) FROM Students s WHERE s.Semester=a.Semester) - COUNT(sub.SubmissionID) AS PendingCount
                    FROM Assignments a
                    LEFT JOIN Assignment_Submissions sub ON a.AssignmentID = sub.AssignmentID
                    WHERE a.TeacherID=@TeacherID
                    GROUP BY a.AssignmentID, a.Topic, a.Deadline, a.Semester
                    ORDER BY a.Deadline ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@TeacherID", Session["TeacherID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAssignments.DataSource = dt;
                gvAssignments.DataBind();
            }
        }

        protected void gvAssignments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int assignmentID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ViewStudents")
            {
                LoadStudentSubmissions(assignmentID);
            }
            else if (e.CommandName == "DeleteAssignment")
            {
                DeleteAssignment(assignmentID);
                LoadAssignments();
            }
        }

        private void LoadStudentSubmissions(int assignmentID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = @"
                    SELECT 
                        s.FirstName + ' ' + s.LastName AS StudentName,
                        CASE 
                            WHEN sub.SubmissionID IS NOT NULL THEN 'Submitted' 
                            ELSE 'Pending' 
                        END AS Status,
                        sub.FilePath
                    FROM Students s
                    INNER JOIN Assignments a ON s.Semester = a.Semester
                    LEFT JOIN Assignment_Submissions sub 
                        ON s.StudentID = sub.StudentID 
                        AND sub.AssignmentID = @AssignmentID
                    WHERE a.AssignmentID = @AssignmentID
                    ORDER BY StudentName ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@AssignmentID", assignmentID);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }

        private void DeleteAssignment(int assignmentID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                con.Open();

                // Delete related submissions first
                string deleteSubmissions = "DELETE FROM Assignment_Submissions WHERE AssignmentID=@AssignmentID";
                SqlCommand cmdSub = new SqlCommand(deleteSubmissions, con);
                cmdSub.Parameters.AddWithValue("@AssignmentID", assignmentID);
                cmdSub.ExecuteNonQuery();

                // Delete the assignment
                string deleteAssignment = "DELETE FROM Assignments WHERE AssignmentID=@AssignmentID";
                SqlCommand cmdAssign = new SqlCommand(deleteAssignment, con);
                cmdAssign.Parameters.AddWithValue("@AssignmentID", assignmentID);
                cmdAssign.ExecuteNonQuery();

                con.Close();
            }
        }
    }
}