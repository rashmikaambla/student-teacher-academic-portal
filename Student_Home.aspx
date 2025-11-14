<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Home.aspx.cs" Inherits="CollegeProject.Student_Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Home</title>
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
        <!-- Logout Button -->
        <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-danger logout-btn" Text="Log Out" OnClick="btnLogout_Click" />

        <div class="container py-5">
            <h2 class="text-center mb-5">📚 Student Dashboard</h2>
            <div class="row g-4">

                <!-- Assignment Management -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">📘</div>
                            <h5 class="card-title mt-3">Assignment Management</h5>
                            <p class="card-text">View and submit assignments easily.</p>
                            <asp:Button ID="btnAssignments" runat="server" CssClass="btn btn-primary"
                                Text="Go" OnClick="btnAssignments_Click" />
                        </div>
                    </div>
                </div>

                <!-- Lecture & Information -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">🎓</div>
                            <h5 class="card-title mt-3">Lecture & Information</h5>
                            <p class="card-text">Check lecture details and study materials.</p>
                            <asp:Button ID="btnLecture" runat="server" CssClass="btn btn-success"
                                Text="Go" OnClick="btnLecture_Click" />
                        </div>
                    </div>
                </div>

                <!-- Events & Notifications -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">📢</div>
                            <h5 class="card-title mt-3">Events & Notifications</h5>
                            <p class="card-text">Stay updated with latest college news.</p>
                            <asp:Button ID="btnEvents" runat="server" CssClass="btn btn-warning"
                                Text="Go" OnClick="btnEvents_Click" />
                        </div>
                    </div>
                </div>

                <!-- Academic & Exam Timetable -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">🗓</div>
                            <h5 class="card-title mt-3">Academic & Exam Timetable</h5>
                            <p class="card-text">View your class and exam schedules.</p>
                            <asp:Button ID="btnTimetable" runat="server" CssClass="btn btn-danger"
                                Text="Go" OnClick="btnTimetable_Click" />
                        </div>
                    </div>
                </div>
                <!-- Update Semester -->
                <div class="col-md-6 col-lg-3">
                    <div class="card text-center module-card p-3">
                        <div class="card-body">
                            <div class="module-icon">🔄</div>
                            <h5 class="card-title mt-3">Update Semester</h5>
                            <p class="card-text">Change your current semester.</p>
                            <asp:Button ID="btnUpdateSemester" runat="server" CssClass="btn btn-info"
                                Text="Update" OnClick="btnUpdateSemester_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
