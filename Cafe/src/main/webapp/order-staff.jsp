<%@page import="DAO.CustomerDAO"%>
<%@page import="DAO.OrderDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.StaffDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CAFE</title>

        <!-- link css -->
        <link rel="stylesheet" href="asset/css/base.css">
        <link rel="stylesheet" href="asset/css/grid.css">
        <link rel="stylesheet" href="asset/css/style_order-staff.css">
        <link rel="stylesheet" href="asset/font/fontawesome-free-6.4.2-web/css/all.min.css">

        <!-- link logo -->
        <link rel="icon" href="./asset/img/img_admin/img_Order/logo-symbol.png" type="image/x-icon">

        <!-- link js -->
        <script src="./asset/js/js_order-staff.js" defer></script>
    </head>

    <body>
        <div class="app">

            <!-- Nav -->
            <div class="nav">
                <div class="nav-container">
                    <i class="fa-solid fa-bars"></i>
                    <img src="../asset/img/img_admin/img_Order/logo.png" alt="" class="nav-logo">
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
                                        <img src="../asset/img/img_admin/img_Order/logo.png" alt="" class="logo-img">
                                    </div>
                                    <i class="fa-solid fa-xmark nav-icon"></i>
                                </div>
                            </div>

                        </div>

                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link">ORDER</a>
                    </div>

                    <!-- account -->
                    <div class="staff-container">
                        <%
                            StaffDAO staffDAO = new StaffDAO();
                            String id = (String) request.getAttribute("id");
                            ResultSet rs = staffDAO.getStaffById(id);
                            String staffname = "";
                            while (rs.next()) {
                                staffname = rs.getString("Staff_name");
                        %>
                        <img src="<%= rs.getString("Staff_pic")%>" alt="" class="staff-img">
                        <h2 class="staff-name"><%= rs.getString("Staff_name")%></h2>
                        <%};%>
                        <a href="signout" class="staff-signout-btn">Sign Out</a>
                    </div>
                </div>
            </div>

            <!-- Order -->
            <div class="order">
                <div class="order-container grid wide">

                    <div class="row">

                        <div class="order-content col l-12">
                            <div class="row">

                                <%
                                    OrderDAO orderDAO = new OrderDAO();
                                    ResultSet listCustomer = orderDAO.getAllOrderBillZero();
                                    while (listCustomer.next()) {
                                        rs = orderDAO.getAlltOrderByCusId(listCustomer.getString("Customer_id"));
                                        String date = "";
                                        String time = "";
                                        while (rs.next()) {
                                            String datetime = rs.getString("Order_date");
                                            String[] arr = datetime.split("\\s+");
                                            String[] arrDate = arr[0].split("-");
                                            date = arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0];
                                            time = arr[1].substring(0, 5);
                                %>

                                <div class="order-item col l-12">
                                    <div class="row">

                                        <div class="order-status col l-1 c-1">
                                            <div class="order-circle red"></div>
                                        </div>

                                        <div class="order-information col l-3 c-5">
                                            <%
                                                CustomerDAO customerDAO = new CustomerDAO();
                                                ResultSet cusInfo = customerDAO.getAllCustomerById(rs.getString("Customer_id"));
                                                while (cusInfo.next()) {
                                            %>
                                            <div class="order-name"> <span>Customer </span> <%=cusInfo.getString("Customer_name")%></div>
                                            <div class="order-table"> <span>Table </span> <%=cusInfo.getString("Customer_table")%></div>
                                            <%};%>
                                        </div>

                                        <div class="order-date col l-3 c-6">
                                            <div class="order-time"><span>Order time </span><%= time%></div>
                                            <div class="order-day"><span>Date </span><%= date%></div>
                                        </div>

                                        <div class="order-responsible col l-3 c-6">
                                            <span>Responsible</span> <%= rs.getString("Order_responsive")%>
                                        </div>

                                        <div class="order-btn-container col l-2 c-6">
                                            <a style="text-decoration: none" href="staff?cusID=<%=rs.getString("Customer_id")%> <%=staffname%> <%=id%>">
                                                <button class="order-btn">
                                                    TAKE
                                                </button>
                                            </a>
                                        </div>

                                    </div>


                                </div>
                                <%};
                                    };%>

                                <%
                                    orderDAO = new OrderDAO();
                                    listCustomer = orderDAO.getAllOrderBillOne();
                                    while (listCustomer.next()) {
                                        rs = orderDAO.getAlltOrderByCusId(listCustomer.getString("Customer_id"));
                                        String date = "";
                                        String time = "";
                                        while (rs.next()) {
                                            String datetime = rs.getString("Order_date");
                                            String[] arr = datetime.split("\\s+");
                                            String[] arrDate = arr[0].split("-");
                                            date = arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0];
                                            time = arr[1].substring(0, 5);
                                %>

                                <div class="order-item col l-12">
                                    <div class="row">

                                        <div class="order-status col l-1 c-1">
                                            <div class="order-circle green"></div>
                                        </div>

                                        <div class="order-information col l-3 c-5">
                                            <%
                                                CustomerDAO customerDAO = new CustomerDAO();
                                                ResultSet cusInfo = customerDAO.getAllCustomerById(rs.getString("Customer_id"));
                                                while (cusInfo.next()) {
                                            %>
                                            <div class="order-name"> <span>Customer </span> <%=cusInfo.getString("Customer_name")%></div>
                                            <div class="order-table"> <span>Table </span> <%=cusInfo.getString("Customer_table")%></div>
                                            <%};%>
                                        </div>

                                        <div class="order-date col l-3 c-6">
                                            <div class="order-time"><span>Order time </span><%= time%></div>
                                            <div class="order-day"><span>Date </span><%= date%></div>
                                        </div>

                                        <div class="order-responsible col l-3 c-6">
                                            <span>Responsible</span> <%= rs.getString("Order_responsive")%>
                                        </div>

                                        <div class="order-btn-container col l-2 c-6 isTaken">
                                            <a style="text-decoration: none">
                                                <button class="order-btn">
                                                    TAKE
                                                </button>
                                            </a>
                                        </div>

                                    </div>
                                </div>
                                <%};
                                    };%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
