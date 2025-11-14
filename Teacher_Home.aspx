<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher_Home.aspx.cs" Inherits="CollegeProject.Teacher_Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Teacher Home</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .module-card {
            border-radius: 15px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }

            .module-card:hover {
                transform: translateY(-5px);
            }

        .module-icon {
            font-size: 50px;
            color: #0d6efd;
        }

        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-danger logout-btn" Text="Log Out" OnClick="btnLogout_Click" />
        <div class="container py-5">
            <h2 class="text-center mb-5">👩‍🏫 Teacher Dashboard</h2>
            <div class="row g-4">

                <!-- Assignment Management -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">📘</div>
                            <h5 class="card-title mt-3">Assignment Management</h5>
                            <p class="card-text">Create topics, deadlines & check submissions.</p>
                            <asp:Button ID="btnAssignments" runat="server" CssClass="btn btn-primary"
                                Text="Manage" OnClick="btnAssignments_Click" />
                        </div>
                    </div>
                </div>

                <!-- Lecture & Information -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">🎓</div>
                            <h5 class="card-title mt-3">Lecture & Information</h5>
                            <p class="card-text">Cancel/update lectures & share info.</p>
                            <asp:Button ID="btnLecture" runat="server" CssClass="btn btn-success"
                                Text="Manage" OnClick="btnLecture_Click" />
                        </div>
                    </div>
                </div>

                <!-- Events & Notifications -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">📢</div>
                            <h5 class="card-title mt-3">Events & Notifications</h5>
                            <p class="card-text">Post announcements & notify students.</p>
                            <asp:Button ID="btnEvents" runat="server" CssClass="btn btn-warning"
                                Text="Manage" OnClick="btnEvents_Click" />
                        </div>
                    </div>
                </div>

                <!-- Academic & Exam Timetable -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">🗓</div>
                            <h5 class="card-title mt-3">Academic & Exam Timetable</h5>
                            <p class="card-text">Upload and edit Acedamic & Exam Timetable.</p>
                            <asp:Button ID="btnTimetable" runat="server" CssClass="btn btn-danger"
                                Text="Manage" OnClick="btnTimetable_Click" />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
