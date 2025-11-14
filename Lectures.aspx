<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Lectures.aspx.cs" Inherits="CollegeProject.Lectures" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lecture Notifications - Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .lecture-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 2rem;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- 🔙 Back Button -->
        <div class="container mt-3">
            <a href="Student_Home.aspx" class="btn btn-secondary">← Back to Home</a>
        </div>

        <div class="lecture-container">
            <h3 class="text-center mb-4">Lecture Updates for Your Semester</h3>

            <asp:GridView ID="gvLectures" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover">
                <Columns>
                    <asp:BoundField DataField="Subject" HeaderText="Subject" />
                    <asp:BoundField DataField="Semester" HeaderText="Semester" />
                    <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy HH:mm}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="TeacherName" HeaderText="Posted By" />
                </Columns>
            </asp:GridView>
        </div>

    </form>
</body>
</html>