<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher_Assignments.aspx.cs" Inherits="CollegeProject.Teacher_Assignments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Teacher Assignments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .assignment-card {
            max-width: 600px;
            margin: 30px auto;
            background: #fff;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
        }

        .btn-save {
            width: 100%;
            border-radius: 25px;
        }
    </style>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var dateInput = document.getElementById("<%= txtDeadline.ClientID %>");
        var now = new Date();
        var year = now.getFullYear();
        var month = ("0" + (now.getMonth() + 1)).slice(-2);
        var day = ("0" + now.getDate()).slice(-2);
        var hours = ("0" + now.getHours()).slice(-2);
        var minutes = ("0" + now.getMinutes()).slice(-2);
        var currentDateTime = `${year}-${month}-${day}T${hours}:${minutes}`;
        dateInput.min = currentDateTime;
    });
</script>

</head>
<body>
    <form id="form1" runat="server">

        <!-- ✅ Add ScriptManager -->
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>

        <!-- ✅ Wrap the main content inside UpdatePanel -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <!-- 🔙 Back Button -->
                <div class="container mt-3">
                    <a href="Teacher_Home.aspx" class="btn btn-secondary">
                        ← Back to Home
                    </a>
                </div>

                <!-- Create Assignment Form -->
                <div class="assignment-card">
                    <h3 class="text-center">Create Assignment</h3>

                    <div class="mb-3">
                        <label class="form-label">Topic <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtTopic" runat="server" CssClass="form-control" Placeholder="Enter assignment topic"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTopic" runat="server"
                            ControlToValidate="txtTopic" ErrorMessage="Topic is required"
                            CssClass="text-danger" Display="Dynamic" ValidationGroup="saveassgin" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Description <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" Placeholder="Enter description"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server"
                            ControlToValidate="txtDescription" ErrorMessage="Description is required"
                            CssClass="text-danger" Display="Dynamic" ValidationGroup="saveassgin" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Deadline <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtDeadline" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDeadline" runat="server"
                            ControlToValidate="txtDeadline" ErrorMessage="Deadline is required"
                            CssClass="text-danger" Display="Dynamic" ValidationGroup="saveassgin" />
                    </div>

                    <!-- Semester -->
                    <div class="mb-3">
                        <label class="form-label">Semester <span class="text-danger">*</span></label>
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
                        <asp:RequiredFieldValidator ID="rfvSemester" runat="server"
                            ControlToValidate="ddlSemester" InitialValue=""
                            ErrorMessage="Please select semester"
                            CssClass="text-danger" Display="Dynamic" ValidationGroup="saveassgin" />
                    </div>

                    <asp:Button ID="btnSaveAssignment" runat="server" ValidationGroup="saveassgin"
                        CssClass="btn btn-primary btn-save" Text="Save Assignment" OnClick="btnSaveAssignment_Click" />
                </div>

                <!-- Assignment List -->
                <div class="container mt-5">
                    <h3>📘 My Assignments</h3>
                    <asp:GridView ID="gvAssignments" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-bordered table-hover mt-3"
                        OnRowCommand="gvAssignments_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Topic" HeaderText="Topic" />
                            <asp:BoundField DataField="Deadline" HeaderText="Deadline" DataFormatString="{0:dd-MMM-yyyy}" />
                            <asp:BoundField DataField="SubmittedCount" HeaderText="Submitted" />
                            <asp:BoundField DataField="PendingCount" HeaderText="Pending" />

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <!-- View Students Button -->
                                    <asp:Button ID="btnView" runat="server" Text="View Students"
                                        CommandName="ViewStudents" CommandArgument='<%# Eval("AssignmentID") %>'
                                        CssClass="btn btn-sm btn-primary" />

                                    <!-- Delete Assignment Button -->
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                        CommandName="DeleteAssignment" CommandArgument='<%# Eval("AssignmentID") %>'
                                        CssClass="btn btn-sm btn-danger ms-2"
                                        OnClientClick="return confirm('Are you sure you want to delete this assignment?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- Student Submissions -->
                <div class="container mt-5">
                    <h3>👩‍🎓 Student Submissions</h3>
                    <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-striped mt-3">
                        <Columns>
                            <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:TemplateField HeaderText="File">
                                <ItemTemplate>
                                    <%# Eval("FilePath") != null && Eval("FilePath").ToString() != "" 
                                        ? "<a href='" + Eval("FilePath") + "' target='_blank'>Download</a>" 
                                        : "N/A" %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

    </form>
</body>
</html>
