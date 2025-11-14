<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="CollegeProject.Events" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>College Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .completed {
            color: red;
            font-weight: bold;
        }
        .upcoming {
            color: green;
            font-weight: bold;
        }
    </style>
</head>
<body class="bg-light">
    <form id="form1" runat="server" class="container mt-5 bg-white p-4 rounded shadow">
        <h2 class="text-center text-primary mb-4">College Events</h2>

        <asp:Repeater ID="RepeaterEvents" runat="server">
            <ItemTemplate>
                <div class="card mb-3 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title text-success"><%# Eval("Title") %></h5>
                        <p class="card-text"><%# Eval("Description") %></p>
                        <p>
                            <strong>Event Date:</strong>
                            <%# Eval("EventDate", "{0:dd MMM yyyy}") %>
                            <span class='<%# Convert.ToDateTime(Eval("EventDate")) < DateTime.Now ? "completed" : "upcoming" %>'>
                                (<%# Convert.ToDateTime(Eval("EventDate")) < DateTime.Now ? "Completed" : "Upcoming" %>)
                            </span>
                        </p>
                        <p class="text-secondary">
                            <small>Uploaded By: <%# Eval("UploadedBy") %> on <%# Eval("UploadedOn", "{0:dd MMM yyyy HH:mm}") %></small>
                        </p>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:Button ID="btnBack" runat="server" Text="Back to Home" CssClass="btn btn-primary w-100 mt-3" OnClick="btnBack_Click" />
    </form>
</body>
</html>
