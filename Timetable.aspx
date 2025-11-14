<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Timetable.aspx.cs" Inherits="CollegeProject.Timetable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Timetable</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 40px;
            max-width: 800px;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-3">
            <a href="Student_Home.aspx" class="btn btn-secondary">← Back to Home</a>
        </div>

        <div class="container">
            <div class="card p-4">
                <h3 class="text-center mb-3">📅 My Timetables</h3>
                <asp:GridView ID="gvStudentTimetables" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-bordered table-hover">
                    <Columns>
                        <asp:BoundField DataField="Type" HeaderText="Type" />
                        <asp:BoundField DataField="UploadedBy" HeaderText="Uploaded By" />
                        <asp:BoundField DataField="UploadedOn" HeaderText="Uploaded On" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        <asp:TemplateField HeaderText="File">
                            <ItemTemplate>
                                <a href='<%# ResolveUrl(Eval("FilePath").ToString()) %>' target="_blank" class="btn btn-success btn-sm">View</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
