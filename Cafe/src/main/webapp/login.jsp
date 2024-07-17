<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <!-- link css -->
        <link rel="stylesheet" href="asset/css/style_login.css"/>
        <link rel="stylesheet" href="asset/css/base.css">
        <link rel="stylesheet" href="asset/css/grid.css">
        <link rel="stylesheet" href="asset/css/responsive.css">
        <link rel="stylesheet" href="asset/font/fontawesome-free-6.4.2-web/css/all.min.css">

        <!-- link js -->
        <script src="./asset/js/js_login.js" defer></script>


    </head>

    <body>

        <!-- Login -->
        <div style="background-image: url(./asset/img/img_login/login_bg.jpg);" class="login-container">
            <div class="grid">

                <div class="row">

                    <div class="login-content col l-6 c-12">

                        <div class="row">

                            <h1 class="login-title col l-12 c-12">LOGIN</h1>

                            <!-- Role -->
                            <div class="login-role col l-3">

                                <div class="select-btn">
                                    <span class="select-text">ROLE</span>
                                    <i class="fa-solid fa-angle-down"></i>
                                </div>

                                <ul class="options">
                                    <li class="option">
                                        <i class="fa-solid fa-user"></i>
                                        <span>CUSTOMER</span>
                                    </li>

                                    <li class="option">
                                        <i class="fa-solid fa-users"></i>
                                        <span>STAFF</span>
                                    </li>

                                    <li class="option">
                                        <i class="fa-solid fa-user-tie"></i>
                                        <span>MANAGER</span>
                                    </li>
                                </ul>

                            </div>

                            <!-- Customer -->

                            <form style="display: none;" action="login" method="post" class="login-customer col l-12">
                                <div class="row">

                                    <div class="customer-login-container col l-12">

                                        <input type="text" class="customer-name" name="name" required placeholder="Name: ">

                                        <select name="role-table" class="login-customer-select" required>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                        </select>

                                        <input type="submit" value="Submit" name="LoginCustomer" class="login-customer-submit">


                                    </div>

                                </div>
                            </form>


                            <!-- Staff -->

                            <form style="display: none;" action="login" method="post" class="login-staff col l-12">
                                <div class="row">
                                    <div class="staff-login-container col l-12">
                                        <input type="text" class="staff-name" name="username" placeholder="User Name" required>
                                        <input type="password" class="staff-pass" name="password" placeholder="Password" required>
                                        <input type="submit" value="Submit" name="LoginStaff" class="login-staff-submit">
                                    </div>
                                </div>
                            </form>

                            <!-- Manager -->

                            <form style="display: none;" action="login" method="post" class="login-manager col l-12">
                                <div class="row">
                                    <div class="manager-login-container col l-12">
                                        <input type="text" class="manager-name" name="username" placeholder="User Name">
                                        <input type="password" class="manager-pass" name="password" placeholder="Password">
                                        <input type="submit" value="Submit" name="LoginManager" class="login-manager-submit">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
