<%-- 
    Document   : order-customer
    Created on : Jul 2, 2024, 2:13:01 PM
    Author     : Le Huu Khoa - CE181099
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ItemDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CAFE</title>

        <!-- link css -->
        <link rel="stylesheet" href="./asset/css/style_order_customer.css">
        <link rel="stylesheet" href="asset/css/base.css" />
        <link rel="stylesheet" href="asset/css/grid.css">
        <link rel="stylesheet" href="asset/font/fontawesome-free-6.4.2-web/css/all.min.css" />

        <!-- link logo -->
        <link rel="icon" href="./asset/img/img_admin/img_Order/logo-symbol.png" type="image/x-icon">

        <!-- link js -->
        <script src="/asset/js/js_order-customer.js" defer></script>

    </head>

    <body>
        <!-- nav -->
        <nav id="desktop-nav">
            <div class="logo-and-name-container hide-on-moblile">
                <a href="${pageContext.request.contextPath}/signout">
                    <h1 class="logo-and-name">
                        <img src="./asset/img/img_admin/img_Order/logo.png" alt="" class="logo" />
                    </h1>
                </a>
            </div>
            <div class="nav-links-container">
                <ul class="nav-links">

                    <li>
                        <%
                            String id = (String) request.getAttribute("id");
                        %>
                        <a href="cart?idFromOrder=<%=id%>">
                            <div class="nav-links-title">HOME</div>
                        </a>
                    </li>

                    <li>
                        <a href="#drink-container">
                            <i class="fa-solid fa-bag-shopping"></i>
                            <div class="nav-links-title">ORDER</div>
                        </a>
                    </li>

                </ul>
            </div>
            <div class="cart-container">
                <i class="fa-solid fa-cart-shopping icon-cart"></i>
            </div>
        </nav>

        <!-- CART  -->
        <div class="cart-list-container">
            <div class="cart-header">YOUR CART</div>

            <div class="row">

                <div class="cart-title col l-12 hide-on-moblile">
                    <div class="row">

                        <div class="cart-product col l-5 l-2">Item</div>
                        <div class="cart-price col l-2">Unit Price</div>
                        <div class="cart-quantity col l-2">Quantity</div>
                        <div class="cart-product col l-2">Final Price</div>
                        <div class="cart-remove col l-1">Remove</div>

                    </div>
                </div>

                <form action="cart" method="post" class="cartForm  col l-12">
                    <input type="hidden" name="idCus" value="<%= id%>">
                    <div class="cart-list">

                    </div>
                    <button class="cart-submit">ORDER</button>
                </form>

            </div>
        </div>


        <!-- Drink section -->
        <div id="order-container">
            <div class="title">Drink</div>
        </div>
        <div class="item-container">

            <div class="row">

                <%                ItemDAO itemDAO = new ItemDAO();
                    ResultSet rs = itemDAO.getAllDrink();
                    while (rs.next()) {
                %>

                <div class="item-order col l-2 m-3 c-6">
                    <div class="item-content">
                        <input type="hidden" name="idItem" value="<%= rs.getString("Item_id")%>">
                        <img src="<%= rs.getString("Item_picture")%>" alt="" class="item-img" />

                        <div class="item-description">
                            <div class="item-rating">
                                <img src="./asset/img/img_customer/order/star.png" alt="" class="icon-star" />
                                10
                            </div>
                            <div class="item-name"><%= rs.getString("Item_name")%></div>
                            <div class="item-price"><%= rs.getString("Item_price")%> VND</div>
                        </div>
                        <button class="orderBtn">Add</button>
                    </div>
                </div>
                <%};%>
            </div>
        </div>

        <!-- Food section -->
        <div id="order-container">
            <div class="title">Food</div>
        </div>
        <div class="item-container">

            <div class="row">

                <%
                    rs = itemDAO.getAllFood();
                    while (rs.next()) {
                %>

                <div class="item-order col l-2 m-3 c-6">
                    <div class="item-content">
                        <input type="hidden" name="idItem" value="<%= rs.getString("Item_id")%>">
                        <img src="<%= rs.getString("Item_picture")%>" alt="" class="item-img" />

                        <div class="item-description">
                            <div class="item-rating">
                                <img src="./asset/img/img_customer/order/star.png" alt="" class="icon-star" />
                                10
                            </div>
                            <div class="item-name"><%= rs.getString("Item_name")%></div>
                            <div class="item-price"><%= rs.getString("Item_price")%> VND</div>
                        </div>
                        <button class="orderBtn">Add</button>
                    </div>
                </div>

                <%};%>
            </div>
        </div>

        <!-- Dessert section -->
        <div id="order-container">
            <div class="title">Dessert</div>
        </div>
        <div class="item-container">
            <div class="row">
                <%
                    rs = itemDAO.getAllDessert();
                    while (rs.next()) {
                %>

                <div class="item-order col l-2 m-3 c-6">
                    <div class="item-content">
                        <input type="hidden" name="idItem" value="<%= rs.getString("Item_id")%>">
                        <img src="<%= rs.getString("Item_picture")%>" alt="" class="item-img" />

                        <div class="item-description">
                            <div class="item-rating">
                                <img src="./asset/img/img_customer/order/star.png" alt="" class="icon-star" />
                                10
                            </div>
                            <div class="item-name"><%= rs.getString("Item_name")%></div>
                            <div class="item-price"><%= rs.getString("Item_price")%> VND</div>
                        </div>
                        <button class="orderBtn">Add</button>
                    </div>
                </div>

                <%};%>
            </div>
        </div>
        <script>
            let cartSubmit = document.querySelector('.cart-submit');
            cartSubmit.onclick = () => {
                let cartForm = document.querySelectorAll('.cartForm');
                cartForm.forEach((e) => {
                    e.submit();
                });
            };
        </script>
    </body>
</html>
