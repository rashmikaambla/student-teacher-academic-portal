<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher_Timetable.aspx.cs" Inherits="CollegeProject.Teacher_Timetable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Timetable</title>
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

        .btn {
            border-radius: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-3">
            <a href="Student_Home.aspx" class="btn btn-secondary">← Back to Home
            </a>
        </div>
        <div class="container">
            <div class="card p-4 mb-4">
                <h3 class="text-center mb-4">📘 Upload Timetable</h3>

                <div class="mb-3">
                    <label class="form-label">Select Semester</label>
                    <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Select Semester --" Value="" />
                        <asp:ListItem Text="1" Value="1" />
                        <asp:ListItem Text="2" Value="2" />
                        <asp:ListItem Text="3" Value="3" />
                        <asp:ListItem Text="4" Value="4" />
                        <asp:ListItem Text="5" Value="5" />
                        <asp:ListItem Text="6" Value="6" />
                        <asp:ListItem Text="7" Value="7" />
                        <asp:ListItem Text="8" Value="8" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvSemester" runat="server" ControlToValidate="ddlSemester" InitialValue=""
                        ErrorMessage="Please select a semester" CssClass="text-danger" ValidationGroup="save" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Select Type</label>
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Select Type --" Value="" />
                        <asp:ListItem Text="Academic" Value="Academic" />
                        <asp:ListItem Text="Exam" Value="Exam" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType" InitialValue=""
                        ErrorMessage="Please select type" CssClass="text-danger" ValidationGroup="save" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Upload File (PDF/Image)</label>
                    <asp:FileUpload ID="fuTimetable" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvFile" runat="server" ControlToValidate="fuTimetable"
                        ErrorMessage="Please select a file" CssClass="text-danger" ValidationGroup="save" />
                </div>

                <div class="text-center">
                    <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-primary px-4"
                        OnClick="btnUpload_Click" ValidationGroup="save" />
                </div>
            </div>

            <!-- Uploaded Timetables -->
            <div class="card p-4">
                <h4 class="text-center mb-3">My Uploaded Timetables</h4>
                <asp:GridView ID="gvTimetables" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-bordered table-hover"
                    DataKeyNames="TimetableID"
                    OnRowDeleting="gvTimetables_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="TimetableID" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Semester" HeaderText="Semester" />
                        <asp:BoundField DataField="Type" HeaderText="Type" />
                        <asp:BoundField DataField="UploadedOn" HeaderText="Uploaded On" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        <asp:TemplateField HeaderText="File">
                            <ItemTemplate>
                                <a href='<%# ResolveUrl(Eval("FilePath").ToString()) %>' target="_blank" class="btn btn-success btn-sm">View</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
