<%@page import="Models.Staff"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--staff-admin.jsp-->
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CAFE</title>

        <!-- link css -->
        <link rel="stylesheet" href="asset/css/base.css">
        <link rel="stylesheet" href="asset/css/grid.css">
        <link rel="stylesheet" href="asset/css/style_staff-admin.css">
        <link rel="stylesheet" href="asset/font/fontawesome-free-6.4.2-web/css/all.min.css">

        <!-- link logo -->
        <link rel="icon" href="./asset/img/img_admin/img_Order/logo-symbol.png" type="image/x-icon">

        <!-- link js -->
        <script src="./asset/js/js_staff-admin.js" defer></script>
    </head>

    <body>

        <div class="app">
            <!-- Nav -->
            <div class="nav">
                <div class="nav-container">
                    <i class="fa-solid fa-bars"></i>
                    <img src="./asset/img/img_admin/img_Order/logo.png" alt="" class="nav-logo">
                </div>
            </div>

            <!-- Menu -->
            <div class="menu">

                <!-- Header -->
                <div class="menu-content">

                    <div class="header-container">
                        <div class="row">

                            <!-- Clock -->
                            <div class="clock-container col l-12 c-12">
                                <span class="hour">00</span>
                                <span class="dot">:</span>
                                <span class="min">00</span>
                                <span class="dot">:</span>
                                <span class="sec">00</span>

                                <div class="date-container">
                                    Date:
                                    <span class="day">18</span>
                                    <span class="">-</span>
                                    <span class="month">06</span>
                                    <span class="">-</span>
                                    <span class="year">2024</span>
                                </div>

                            </div>

                            <!-- Menu nav -->
                            <div class="menu-nav col l-12 c-12">
                                <div class="row">
                                    <div class="logo-container ">
                                        <img src="./asset/img/img_admin/img_Order/logo.png" alt="" class="logo-img">
                                    </div>
                                    <i class="fa-solid fa-xmark nav-icon"></i>
                                </div>
                            </div>

                        </div>

                    </div>


                    <div class="menu-item">
                        <a href="/order-admin" class="menu-link">ORDER</a>
                    </div>

                    <div class="menu-item">
                        <a href="/staff-admin" class="menu-link">STAFF</a>
                    </div>

                    <div class="menu-item">
                        <a href="/listItem-admin" class="menu-link">PRODUCTS</a>
                    </div>

                    <!-- account -->
                    <div class="account-container">
                        <img src="./asset/img/img_admin/img_Information/avt.jpg" alt="" class="account-img">
                        <h2 class="account-name">${sessionScope.managerName}</h2>
                        <a href="${pageContext.request.contextPath}/signout" class="account-signout-btn">Sign Out</a>
                    </div>

                </div>
            </div>
            <!-- Body -->

            <!-- Update Staff -->
            <div class="grid wide">
                <button class="staff-update-btn">
                    Update Staff
                </button>
            </div>

            <div class="staff-update-contain">
                <form action="${pageContext.request.contextPath}/staff-admin" method="post" enctype="multipart/form-data" class="staff-update-form">
                    <div class="row">
                        <h1 class="staff-update-title col l-6">Update Staff</h1>
                        <div class="staff-update-icon col l-6">
                            <i class="fa-solid fa-xmark"></i>
                        </div>
                        <div class="staff-update-input-container col l-12">
                            <input type="text" class="staff-update-input" required="required" name="Staff_id">
                            <div class="label-title">ID</div>
                        </div>
                        <div class="staff-update-input-container col l-6">
                            <input type="text" class="staff-update-input" required="required" name="Staff_name">
                            <div class="label-title">Name</div>
                        </div>
                        <div class="staff-update-input-container col l-6">
                            <input type="text" class="staff-update-input" required="required" name="Staff_phoneNum" onblur="validatePhoneNumber(this)">
                            <div class="label-title">Phone</div>
                        </div>
                        <div class="staff-update-input-container col l-12">
                            <input type="text" class="staff-update-input" required="required" name="Staff_role">
                            <div class="label-title">Role</div>
                        </div>
                        <div class="staff-update-input-container col l-4">
                            <input type="file" class="staff-update-input" id="uploadBtn" accept="image/*" required="required" name="Staff_pic">
                            <label style="position: relative;" for="uploadBtn" class="label-title">
                                <i class="fa-solid fa-upload"></i>
                                Upload Picture
                            </label>
                            <span id="uploadStatus" style="font-size: 20px">(Empty)</span>
                            <img id="imagePreview" src="" alt="Preview" style="display: none; vertical-align: middle; margin-left: 10px; width: 30px; height: 30px; object-fit: cover;">
                        </div>
                        <div class="staff-update-input-container col l-4">
                            <input type="text" class="staff-update-input" required="required" name="Staff_user">
                            <div class="label-title">User</div>
                        </div>
                        <div class="staff-update-input-container col l-4">
                            <input type="text" class="staff-update-input" required="required" name="Staff_pass">
                            <div class="label-title">Pass</div>
                        </div>

                        <div class="staff-update-submit col l-12">
                            <button type="submit" class="btn-add" name="action" value="add">Add</button>
                            <button type="submit" class="btn-Update" name="action" value="update">Update</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- STAFF SECTION -->
            <div class="staff-container">
                <div class="grid wide">
                    <div class="row">
                        <%
                            List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");
                            if (staffList != null) {
                                for (Staff staff : staffList) {
                        %>
                        <div class="staff-item">
                            <div class="row">
                                <div class="staff-status col l-1 c-4">
                                    <img src="${pageContext.request.contextPath}/<%= staff.getStaff_pic()%>" alt="" class="staff-img">
                                </div>
                                <div class="staff-information col l-10 c-8">
                                    <div class="row">
                                        <div class="staff-name col l-6 c-12"><span>Name </span> <%= staff.getStaff_name()%></div>
                                        <div class="staff-time col l-4 c-12"><span>Role </span><%= staff.getStaff_role()%></div>
                                        <div class="staff-phonenum col l-2 c-12"><span>Phone</span><%= staff.getStaff_phoneNum()%></div>
                                    </div>
                                </div>
                                <form id="deleteForm<%= staff.getStaff_id()%>" action="${pageContext.request.contextPath}/staff-admin" method="post">
                                    <input type="hidden" name="Staff_id" value="<%= staff.getStaff_id()%>">
                                    <input type="hidden" name="action" value="delete">
                                    <div class="staff-icon col l-1">
                                        <button type="button" class="btn-remove" onclick="confirmDelete('<%= staff.getStaff_id()%>', '<%= staff.getStaff_name()%>')">Remove</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>

        </div>
        <div id="alertOverlay" class="alert-overlay">
            <div class="alert-content">
                <p id="alertMessage"></p>
                <button onclick="closeAlert()">Close</button>
            </div>
        </div>
        <script>
            function showAlert(message) {
                document.getElementById('alertMessage').innerText = message;
                document.getElementById('alertOverlay').style.display = 'block';
            }

            function closeAlert() {
                document.getElementById('alertOverlay').style.display = 'none';
            }

            <%
                String alertMessage = (String) session.getAttribute("alertMessage");
                if (alertMessage != null) {
            %>
            showAlert("<%= alertMessage%>");
            <%
                    session.removeAttribute("alertMessage");
                }
            %>

            function showAlert(message, callback) {
                document.getElementById('alertMessage').innerText = message;
                document.getElementById('alertOverlay').style.display = 'block';
                if (callback) {
                    document.querySelector('#alertOverlay button').onclick = function () {
                        closeAlert();
                        callback();
                    };
                }
            }

            function closeAlert() {
                document.getElementById('alertOverlay').style.display = 'none';
            }

            function confirmDelete(staffId, staffName) {
                if (confirm(`Are you sure you want to delete ${staffName}?`)) {
                    document.getElementById('deleteForm' + staffId).submit();
                }
            }
            document.getElementById('uploadBtn').addEventListener('change', function (event) {
                var file = event.target.files[0];
                var reader = new FileReader();
                var uploadStatus = document.getElementById('uploadStatus');

                reader.onload = function (e) {
                    var img = document.getElementById('imagePreview');
                    img.src = e.target.result;
                    img.style.display = 'block';
                    uploadStatus.textContent = 'Picture uploaded';
                };

                if (file) {
                    reader.readAsDataURL(file);
                } else {
                    uploadStatus.textContent = 'upload picture (empty)';
                    document.getElementById('imagePreview').style.display = 'none';
                }
            });
        </script>
    </body> 
</html>
