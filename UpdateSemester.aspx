<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateSemester.aspx.cs" Inherits="CollegeProject.UpdateSemester" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Update Semester</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="container mt-5">

        <a href="Student_Home.aspx" class="btn btn-secondary mb-3">← Back</a>

        <div class="card p-4 shadow">
            <h3 class="text-center">Update My Semester</h3>

            <div class="mb-3">
                <label class="form-label">Current Semester:</label>
                <asp:Label ID="lblCurrentSem" runat="server" CssClass="fw-bold"></asp:Label>
            </div>

            <div class="mb-3">
                <label class="form-label">Select New Semester</label>
                <asp:DropDownList ID="ddlNewSemester" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Select Semester</asp:ListItem>
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem>4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>6</asp:ListItem>
                    <asp:ListItem>7</asp:ListItem>
                    <asp:ListItem>8</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnSave" runat="server" Text="Update Semester"
                CssClass="btn btn-primary w-100" OnClick="btnSave_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="text-success mt-3 d-block"></asp:Label>
        </div>
    </form>
</body>
</html>
