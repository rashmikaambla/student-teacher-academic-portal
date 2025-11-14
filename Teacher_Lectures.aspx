<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher_Lectures.aspx.cs" Inherits="CollegeProject.Teacher_Lectures" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Lecture Management - Teacher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .lecture-card {
            max-width: 750px;
            margin: 40px auto;
            background: #fff;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- 🔙 Back Button -->
        <div class="container mt-3">
            <a href="Teacher_Home.aspx" class="btn btn-secondary">← Back to Home</a>
        </div>

        <div class="lecture-card">
            <h3 class="text-center mb-4">Post Lecture Notification</h3>

            <div class="mb-3">
                <label class="form-label">Subject</label>
                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" Placeholder="Enter subject name"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label">Semester</label>
                <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Select Semester" Value="" />
                    <asp:ListItem Text="1st Semester" Value="1" />
                    <asp:ListItem Text="2nd Semester" Value="2" />
                    <asp:ListItem Text="3rd Semester" Value="3" />
                    <asp:ListItem Text="4th Semester" Value="4" />
                    <asp:ListItem Text="5th Semester" Value="5" />
                    <asp:ListItem Text="6th Semester" Value="6" />
                </asp:DropDownList>
            </div>

            <div class="mb-3">
                <label class="form-label">Date</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label">Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Scheduled" Value="Scheduled" />
                    <asp:ListItem Text="Cancelled" Value="Cancelled" />
                    <asp:ListItem Text="Rescheduled" Value="Rescheduled" />
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnPostLecture" runat="server" Text="Post Notification" CssClass="btn btn-primary w-100" OnClick="btnPostLecture_Click" />
        </div>

        <div class="container mt-5">
            <h4 class="mb-3">📋 My Lecture Notifications</h4>
            <asp:GridView ID="gvLectures" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover">
                <Columns>
                    <asp:BoundField DataField="Subject" HeaderText="Subject" />
                    <asp:BoundField DataField="Semester" HeaderText="Semester" />
                    <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy HH:mm}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>
    </form>

    <!-- 🔹 Prevent past dates in date picker -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var dateInput = document.getElementById("<%= txtDate.ClientID %>");
            var now = new Date();
            var local = new Date(now.getTime() - now.getTimezoneOffset() * 60000)
                .toISOString().slice(0, 16);
            dateInput.min = local; // ✅ Prevent past dates
        });
    </script>

</body>
</html>