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
    public partial class UpdateSemester : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
                LoadCurrentSemester();
        }

        private void LoadCurrentSemester()
        {
            
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT Semester FROM Students WHERE Username=@u", con);
                cmd.Parameters.AddWithValue("@u", Session["Username"].ToString());

                con.Open();
                lblCurrentSem.Text = cmd.ExecuteScalar().ToString();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlNewSemester.SelectedValue == "")
            {
                lblMessage.Text = "Please select a semester.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            //string conStr = ConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Students SET Semester=@s WHERE Username=@u", con);
                cmd.Parameters.AddWithValue("@s", ddlNewSemester.SelectedValue);
                cmd.Parameters.AddWithValue("@u", Session["Username"].ToString());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Semester updated successfully!";
            lblMessage.CssClass = "text-success";
            LoadCurrentSemester();
        }
    }
}