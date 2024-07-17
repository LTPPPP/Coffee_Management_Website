<%@page import="DAO.CustomerDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="Models.Item"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="DAO.OrderDAO" %>
<%@ page import="Models.Order" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CAFE</title>

        <!-- link css -->
        <link rel="stylesheet" href="asset/css/base.css">
        <link rel="stylesheet" href="asset/css/grid.css">
        <link rel="stylesheet" href="asset/css/style_order-admin.css">
        <link rel="stylesheet" href="asset/font/fontawesome-free-6.4.2-web/css/all.min.css">

        <!-- link logo -->
        <link rel="icon" href="./asset/img/img_admin/img_Order/logo-symbol.png" type="image/x-icon">

        <!-- link js -->
        <script src="./asset/js/js_order-admin.js" defer></script>

    </head>

    <body>

        <div class="app">

            <!-- Header -->

            <div class="header-container grid">
                <div class="row">

                    <div class="clock-container col l-12">
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
                    <div class="nav col l-2">
                        <div class="row">
                            <i class="fa-solid fa-bars nav-icon"></i>
                            <div class="logo-container ">
                                <img src="./asset/img/img_admin/img_Order/logo.png" alt="" class="logo-img">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Body -->

            <!-- Menu -->
            <div class="menu">

                <div class="menu-content">

                    <div class="menu-nav">
                        <div class="row">
                            <i class="fa-solid fa-xmark nav-icon"></i>
                            <div class="logo-container ">
                                <img src="./asset/img/img_admin/img_Order/logo.png" alt="" class="logo-img">
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

                    <!-- Admin -->
                    <div class="admin-container">
                        <img src="./asset/img/img_admin/img_Information/avt.jpg" alt="" class="admin-img">
                        <h2 class="admin-name">${sessionScope.managerName}</h2>
                        <a href="${pageContext.request.contextPath}/signout" class="admin-signout-btn">Sign Out</a>
                    </div>
                </div>
            </div>
            <!-- Retrieve and display total customers -->
            <div class="customer-count-container">
                <%
                    CustomerDAO customerDAO = new CustomerDAO();
                    int totalCustomers = customerDAO.getTotalCustomers();
                    request.setAttribute("totalCustomers", totalCustomers);
                %>
                <h2>Total Customers: ${totalCustomers}</h2>
            </div>
            <!-- Order -->
            <div class="order">
                <div class="order-container grid wide">
                    <div class="row">
                        <%
                            OrderDAO orderDAO = new OrderDAO();
                            List<Order> listOrders = orderDAO.getAllOrders();
                            Map<String, List<Order>> groupedOrders = new LinkedHashMap<>();

                            for (Order order : listOrders) {
                                String key = order.getCustomer_id() + "_" + order.getCustomer().getCustomer_table();
                                if (!groupedOrders.containsKey(key)) {
                                    groupedOrders.put(key, new ArrayList<Order>());
                                }
                                groupedOrders.get(key).add(order);
                            }

                            request.setAttribute("groupedOrders", groupedOrders);
                        %>
                        <c:choose>
                            <c:when test="${empty groupedOrders}">
                                <div class="col l-12 null_order">
                                    <h2>NO ORDER YET</h2>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="entry" items="${groupedOrders}">
                                    <c:set var="firstOrder" value="${entry.value[0]}" />
                                    <div class="order-content col l-12">
                                        <div class="row">
                                            <div class="order-item col l-12">
                                                <div class="row">
                                                    <div class="order-status col l-1">
                                                        <div class="order-circle ${firstOrder.order_billStatus==1 ? 'green' : 'red'}"></div>
                                                    </div>
                                                    <div class="order-information col l-3">
                                                        <div class="order-name"><span>Customer </span>${firstOrder.customer.customer_name}</div>
                                                        <div class="order-table"><span>Table </span>${firstOrder.customer.customer_table}</div>
                                                    </div>
                                                    <div class="order-date col l-3">
                                                        <div class="order-time"><span>Order time </span>${firstOrder.order_date.substring(11, 19)}</div>
                                                        <div class="order-day"><span>Date </span>${firstOrder.order_date.substring(0, 10)}</div>
                                                    </div>
                                                    <div class="order-responsible col l-3">
                                                        <span>Responsible: </span>${firstOrder.order_responsive}
                                                    </div>
                                                    <div class="order-icon col l-2">
                                                        <i class="fa-solid fa-caret-down"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="bill col l-12">
                                                <div class="bill-container">
                                                    <table class="bill-table">
                                                        <tr class="bill-row row">
                                                            <th class="bill-title col l-3">Name</th>
                                                            <th class="bill-title col l-3">Quantity</th>
                                                            <th class="bill-title col l-3">Price</th>
                                                            <th class="bill-title col l-3">Total</th>
                                                        </tr>
                                                        <c:forEach var="order" items="${entry.value}">
                                                            <c:set var="item" value="${order.item}" />
                                                            <tr class="bill-row row">
                                                                <th class="bill-item col l-3">${item.item_name}</th>
                                                                <th class="bill-item col l-3">${order.order_quantity}</th>
                                                                <th class="bill-item col l-3">${item.item_price}0 VND</th>
                                                                <th class="bill-item col l-3">${item.item_price * order.order_quantity}0 VND</th>
                                                            </tr>
                                                        </c:forEach>
                                                        <tr class="total-row row">
                                                            <th class="total-title col l-6">Total</th>
                                                            <th class="total-title col l-6">
                                                                <c:set var="total" value="0" />
                                                                <c:forEach var="order" items="${entry.value}">
                                                                    <c:set var="total" value="${total + order.item.item_price * order.order_quantity}" />
                                                                </c:forEach>
                                                                ${total}0 VND
                                                            </th>
                                                            <th class="bill-item col l-3">
                                                                <button onclick="showConfirm('${firstOrder.customer_id}', '${firstOrder.customer.customer_table}', '${firstOrder.customer.customer_name}')" class="remove-btn">Remove</button>
                                                            </th>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>                 
                    </div>
                </div>
            </div>
        </div>
        <div id="confirmOverlay" class="confirm-overlay" style="display:none;">
            <div class="confirm-content">
                <p id="confirmMessage"></p>
                <button onclick="confirmRemove(true)">YES</button>
                <button onclick="confirmRemove(false)">NO</button>
            </div>
        </div>
        <script>
            let orderToRemove = null;

            function showConfirm(customerId, customerTable, customerName) {
                orderToRemove = {customerId, customerTable};
                document.getElementById('confirmMessage').innerText = `Do you want to remove the order for ${firstOrder.customer.customer_name}?`;
                document.getElementById('confirmOverlay').style.display = 'flex';
            }

            function confirmRemove(confirmed) {
                document.getElementById('confirmOverlay').style.display = 'none';
                if (confirmed && orderToRemove) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/removeOrder';

                    const customerIdInput = document.createElement('input');
                    customerIdInput.type = 'hidden';
                    customerIdInput.name = 'customerId';
                    customerIdInput.value = orderToRemove.customerId;

                    const customerTableInput = document.createElement('input');
                    customerTableInput.type = 'hidden';
                    customerTableInput.name = 'customerTable';
                    customerTableInput.value = orderToRemove.customerTable;

                    form.appendChild(customerIdInput);
                    form.appendChild(customerTableInput);
                    document.body.appendChild(form);
                    form.submit();
                }
                orderToRemove = null;
            }
        </script>
    </body>
</html>
