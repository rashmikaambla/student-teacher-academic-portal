<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CollegeProject.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <title>Login Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f1f3f4;
            /*background-image: url('login_img.jpeg');*/
            background-size: cover;
        }

        .login-container {
            max-width: 400px;
            margin: 80px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .login-header {
            background: url('login-bg.jpg') no-repeat center center;
            background-size: cover;
            height: 80px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-header h3 {
            color: gray;
            font-weight: bold;
            margin: 0;
        }

        .form-control {
            border-radius: 0;
            box-shadow: none !important;
        }

        .btn-login {
            width: 100%;
            background-color: #28a745;
            color: #fff;
            font-weight: 600;
            border-radius: 25px;
        }

        .btn-login:hover {
            background-color: #218838;
        }

        .options {
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
        }

        .validation-error {
            color: red;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <!-- Header -->
            <div class="login-header">
                <h3>SIGN IN</h3>
            </div>

            <!-- Body -->
            <div class="p-4">
                <!-- Username -->
                <div class="mb-3">
                    <label for="txtUsername" class="form-label">Username <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" ValidationGroup="LoginGroup"
                        runat="server" ErrorMessage="Username is required"
                        ControlToValidate="txtUsername" CssClass="validation-error" Display="Dynamic" />
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label for="txtPassword" class="form-label">Password <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" ValidationGroup="LoginGroup"
                        runat="server" ErrorMessage="Password is required"
                        ControlToValidate="txtPassword" CssClass="validation-error" Display="Dynamic" />
                </div>

                <!-- User Type -->
                <div class="mb-3">
                    <label for="ddl_stu_tea" class="form-label">Select Type <span class="text-danger">*</span></label>
                    <asp:DropDownList ID="ddl_stu_tea" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">-- Select --</asp:ListItem>
                        <asp:ListItem Text="Teacher" Value="Teacher"></asp:ListItem>
                        <asp:ListItem Text="Student" Value="Student"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvRole" ValidationGroup="LoginGroup"
                        runat="server" ErrorMessage="Please select a role"
                        ControlToValidate="ddl_stu_tea" InitialValue=""
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <!-- Options -->
                <div class="options mb-3">
                   
                    <a href="Forget_password.aspx">Forgot Password?</a>
                </div>

                <!-- Login Button -->
                <asp:Button ID="btnLogin" ValidationGroup="LoginGroup" runat="server"
                    Text="Login" CssClass="btn btn-login" OnClick="btnLogin_Click" />

                <!-- Create Account -->
                <div class="mt-3 text-center">
                    <label class="form-label">Is this your first time here?</label><br />
                    <asp:Button ID="btncreate" runat="server" Text="Create Account"
                        CssClass="btn btn-secondary mt-2" Font-Bold="True" OnClick="btncreate_Click" />
                </div>
            </div>
        </div>
    </form>

</body>
</html>
