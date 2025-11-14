<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="CollegeProject.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .register-card {
            max-width: 600px;
            margin: 3% auto;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            background: #fff;
        }

        .register-title {
            font-weight: bold;
            margin-bottom: 1.5rem;
        }

        .validation-error {
            color: red;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="register-card">
                <h3 class="register-title">Student Registration</h3>

                <!-- Username -->
                <div class="mb-3">
                    <label class="form-label">Username <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                        ControlToValidate="txtUsername" ErrorMessage="Username is required"
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label class="form-label">Password <span class="text-danger">*</span></label>
                    <small class="form-text text-muted d-block mb-2">The password must have at least 8 characters, 1 digit, 1 lowercase letter,
                        1 uppercase letter, and 1 special character (*, -, or #).
                    </small>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword" ErrorMessage="Password is required"
                        CssClass="validation-error" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password must meet complexity requirements"
                        CssClass="validation-error" Display="Dynamic"
                        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[*\-#]).{8,}$" />
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label class="form-label">Email <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail" ErrorMessage="Email is required"
                        CssClass="validation-error" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Enter a valid email"
                        CssClass="validation-error" Display="Dynamic"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" />
                </div>

                <!-- First and Last Name -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">First name <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                            ControlToValidate="txtFirstName" ErrorMessage="First name is required"
                            CssClass="validation-error" Display="Dynamic" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Last name <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                            ControlToValidate="txtLastName" ErrorMessage="Last name is required"
                            CssClass="validation-error" Display="Dynamic" />
                    </div>
                </div>

                <!-- Semester -->
                <div class="mb-3">
                    <label class="form-label">Semester <span class="text-danger">*</span></label>
                    <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-select">
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
                    <asp:RequiredFieldValidator ID="rfvSemester" runat="server"
                        ControlToValidate="ddlSemester" InitialValue=""
                        ErrorMessage="Please select a semester"
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <!-- Buttons -->
                <div class="d-flex gap-2 mt-4">
                    <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-primary" Text="Create my new account" OnClick="btnRegister_Click" />
                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary" Text="Cancel" CausesValidation="false" />
                </div>


                <p class="mt-3 text-danger">* Required</p>
                <!-- 🔵 Added Back to Login Link -->
                <div class="text-left mt-3">
                    <a href="Login.aspx" class="text-primary">Back to Login</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
