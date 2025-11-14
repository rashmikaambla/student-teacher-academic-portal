<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher_Events.aspx.cs" Inherits="CollegeProject.Teacher_Events" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 40px;
            max-width: 900px;
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
                <h3 class="text-center mb-3">Add New Event</h3>

                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                        ErrorMessage="Enter title" CssClass="text-danger" ValidationGroup="save" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ControlToValidate="txtDescription"
                        ErrorMessage="Enter description" CssClass="text-danger" ValidationGroup="save" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Event Date</label>
                    <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtEventDate"
                        ErrorMessage="Select event date" CssClass="text-danger" ValidationGroup="save" />
                </div>

                <div class="text-center">
                    <asp:Button ID="btnAddEvent" runat="server" Text="Add Event" CssClass="btn btn-primary px-4"
                        ValidationGroup="save" OnClick="btnAddEvent_Click" />
                </div>
            </div>

            <!-- Events Grid -->
            <div class="card p-4">
                <h4 class="text-center mb-3">My Events</h4>
                <asp:GridView ID="GridViewEvents" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-bordered table-hover"
                    DataKeyNames="EventID"
                    OnRowEditing="GridViewEvents_RowEditing"
                    OnRowCancelingEdit="GridViewEvents_RowCancelingEdit"
                    OnRowUpdating="GridViewEvents_RowUpdating"
                    OnRowDeleting="GridViewEvents_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="EventID" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        <asp:BoundField DataField="EventDate" HeaderText="Event Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="UploadedOn" HeaderText="Uploaded On" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <script type="text/javascript">
            // Prevent past date selection
            window.onload = function () {
                var today = new Date().toISOString().split('T')[0];
                document.getElementById('<%= txtEventDate.ClientID %>').setAttribute('min', today);
            };
        </script>
    </form>
</body>
</html>
