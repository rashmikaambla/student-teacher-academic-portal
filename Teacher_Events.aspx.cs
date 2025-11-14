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
    public partial class Teacher_Events : System.Web.UI.Page
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
                BindEvents();
            }
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtEventDate.Text))
            {
                Response.Write("<script>alert('Please select a date');</script>");
                return;
            }

            DateTime eventDate = DateTime.Parse(txtEventDate.Text);
            if (eventDate < DateTime.Today)
            {
                Response.Write("<script>alert('Event date must be today or future.');</script>");
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "INSERT INTO Events (Title, Description, EventDate, UploadedBy) VALUES (@Title, @Desc, @Date, @UploadedBy)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Date", eventDate);
                cmd.Parameters.AddWithValue("@UploadedBy", Session["Username"].ToString());
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Write("<script>alert('Event added successfully!');</script>");
            ClearFields();
            BindEvents();
        }

        private void BindEvents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Events WHERE UploadedBy=@User ORDER BY EventDate ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@User", Session["Username"].ToString());
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewEvents.DataSource = dt;
                GridViewEvents.DataBind();
            }
        }

        protected void GridViewEvents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewEvents.EditIndex = e.NewEditIndex;
            BindEvents();
        }

        protected void GridViewEvents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewEvents.EditIndex = -1;
            BindEvents();
        }

        protected void GridViewEvents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int eventID = Convert.ToInt32(GridViewEvents.DataKeys[e.RowIndex].Value);
            string title = ((TextBox)GridViewEvents.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string desc = ((TextBox)GridViewEvents.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            string dateText = ((TextBox)GridViewEvents.Rows[e.RowIndex].Cells[3].Controls[0]).Text;

            if (!DateTime.TryParse(dateText, out DateTime newDate))
            {
                Response.Write("<script>alert('Invalid date format!');</script>");
                return;
            }

            if (newDate < DateTime.Today)
            {
                Response.Write("<script>alert('Event date must be current or future.');</script>");
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE Events SET Title=@Title, Description=@Desc, EventDate=@Date WHERE EventID=@ID AND UploadedBy=@User";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Desc", desc);
                cmd.Parameters.AddWithValue("@Date", newDate);
                cmd.Parameters.AddWithValue("@ID", eventID);
                cmd.Parameters.AddWithValue("@User", Session["Username"].ToString());
                con.Open();
                cmd.ExecuteNonQuery();
            }

            GridViewEvents.EditIndex = -1;
            BindEvents();
            Response.Write("<script>alert('Event updated successfully!');</script>");
        }

        protected void GridViewEvents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int eventID = Convert.ToInt32(GridViewEvents.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM Events WHERE EventID=@ID AND UploadedBy=@User";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", eventID);
                cmd.Parameters.AddWithValue("@User", Session["Username"].ToString());
                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindEvents();
            Response.Write("<script>alert('Event deleted successfully!');</script>");
        }

        private void ClearFields()
        {
            txtTitle.Text = txtDescription.Text = txtEventDate.Text = "";
        }
    }
}