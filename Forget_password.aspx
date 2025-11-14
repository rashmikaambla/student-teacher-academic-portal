<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forget_password.aspx.cs" Inherits="CollegeProject.Forget_password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Reset Password</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f1f3f4;
            background-image: url('login_img.jpeg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .reset-container {
            max-width: 400px;
            margin: 60px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .reset-header {
            background: url('login-bg.jpg') no-repeat center center;
            background-size: cover;
            height: 80px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .reset-header h3 {
            color: #fff;
            font-weight: bold;
        }

        .btn-reset {
            width: 100%;
            background-color: #28a745;
            color: #fff;
            font-weight: 600;
            border-radius: 25px;
        }

        .btn-reset:hover {
            background-color: #218838;
        }

        .back-login {
            display: block;
            margin-top: 15px;
            text-align: center;
        }

        .validation-error {
            color: red;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="reset-container">
            <!-- Header -->
            <div class="reset-header">
                <h3 class="text-muted" style="text-align: center">Reset Password</h3>
            </div>

            <!-- Body -->
            <div class="p-4">
                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Registered Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="Email is required" CssClass="validation-error" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtNewPassword" class="form-label">New Password</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter new password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ControlToValidate="txtNewPassword"
                        ErrorMessage="New Password is required" CssClass="validation-error" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPass" runat="server" ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Confirm Password is required" CssClass="validation-error" Display="Dynamic" />
                    <asp:CompareValidator ID="cvPasswords" runat="server"
                        ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword"
                        ErrorMessage="Passwords do not match" CssClass="validation-error" Display="Dynamic" />
                </div>

                <asp:Button ID="btnUpdate" runat="server" Text="Update Password" CssClass="btn btn-reset" OnClick="btnUpdate_Click" />

                <%--<a href="Log_in_Page.aspx" class="back-login">Back to Login</a>--%>
            </div>
        </div>
    </form>
</body>
</html>
