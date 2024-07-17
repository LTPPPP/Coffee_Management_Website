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
            document.querySelector('.cart-submit').addEventListener('click', function (e) {
                e.preventDefault();

                let cartItems = document.querySelectorAll('.cart-list .cart-item');

                if (cartItems.length === 0) {
                    // Show notification overlay
                    showNotification("Your cart is empty. Please add items before ordering.");
                    return;
                }

                let cartForm = document.querySelector('.cartForm');

                // Clear any previously added hidden inputs
                cartForm.querySelectorAll('input[name^="itemId"], input[name^="quantity"]').forEach(el => el.remove());

                cartItems.forEach((item, index) => {
                    let itemId = item.querySelector('input[name="idItem"]').value;
                    let quantity = item.querySelector('.cart-quantity-input').value;

                    let itemIdInput = document.createElement('input');
                    itemIdInput.type = 'hidden';
                    itemIdInput.name = 'itemId' + (index + 1);
                    itemIdInput.value = itemId;

                    let quantityInput = document.createElement('input');
                    quantityInput.type = 'hidden';
                    quantityInput.name = 'quantity' + (index + 1);
                    quantityInput.value = quantity;

                    cartForm.appendChild(itemIdInput);
                    cartForm.appendChild(quantityInput);
                });

                // Add the total number of items
                let numItemInput = document.createElement('input');
                numItemInput.type = 'hidden';
                numItemInput.name = 'numItem';
                numItemInput.value = cartItems.length;
                cartForm.appendChild(numItemInput);

                cartForm.submit();
            });

            function showNotification(message) {
                // Create notification overlay
                let overlay = document.createElement('div');
                overlay.style.position = 'fixed';
                overlay.style.top = '0';
                overlay.style.left = '0';
                overlay.style.width = '100%';
                overlay.style.height = '100%';
                overlay.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
                overlay.style.display = 'flex';
                overlay.style.justifyContent = 'center';
                overlay.style.alignItems = 'center';
                overlay.style.zIndex = '9999';

                let notificationBox = document.createElement('div');
                notificationBox.style.backgroundColor = 'white';
                notificationBox.style.padding = '20px';
                notificationBox.style.borderRadius = '5px';
                notificationBox.style.textAlign = 'center';

                let messageElement = document.createElement('p');
                messageElement.textContent = message;

                let closeButton = document.createElement('button');
                closeButton.textContent = 'Close';
                closeButton.style.marginTop = '10px';
                closeButton.addEventListener('click', function () {
                    document.body.removeChild(overlay);
                });

                notificationBox.appendChild(messageElement);
                notificationBox.appendChild(closeButton);
                overlay.appendChild(notificationBox);

                document.body.appendChild(overlay);
            }
        </script>
    </body>
</html>
