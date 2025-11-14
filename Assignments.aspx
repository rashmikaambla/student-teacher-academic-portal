<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Assignments.aspx.cs" Inherits="CollegeProject.Assignments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Assignments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .assignments-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 2rem;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
        }

        .gvAssignments th, .gvAssignments td {
            text-align: center;
            vertical-align: middle;
        }

        .btn-upload {
            border-radius: 25px;
        }

        .btn-download {
            border-radius: 25px;
        }
    </style>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".table tr").forEach(function (row) {
            var deadlineText = row.cells[2]?.innerText; // assuming deadline column is 3rd
            if (deadlineText) {
                var deadlineDate = new Date(deadlineText);
                var now = new Date();
                if (deadlineDate < now) {
                    var uploadBtn = row.querySelector(".btn-upload");
                    if (uploadBtn) {
                        uploadBtn.disabled = true;
                        uploadBtn.textContent = "Deadline Passed";
                        uploadBtn.classList.add("btn-secondary");
                    }
                }
            }
        });
    });
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-3">
            <a href="Student_Home.aspx" class="btn btn-secondary">← Back to Home
            </a>
        </div>

        <div class="assignments-container">
            <h3 class="text-center mb-4">Assignments</h3>
            <asp:GridView ID="gvAssignments" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover gvAssignments">
                <Columns>
                    <asp:BoundField DataField="Topic" HeaderText="Topic" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Deadline" HeaderText="Deadline" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                    <asp:TemplateField HeaderText="Download">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkDownload" runat="server" NavigateUrl='<%# Eval("FilePath") %>' Text="Download" CssClass="btn btn-success btn-download" Target="_blank"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Upload">
                        <ItemTemplate>
                            <asp:FileUpload ID="fuSubmit" runat="server" />
                            <asp:Button ID="btnUpload" runat="server" Text="Upload" CommandArgument='<%# Eval("AssignmentID") %>' OnClick="btnUpload_Click" CssClass="btn btn-primary btn-upload mt-1" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
