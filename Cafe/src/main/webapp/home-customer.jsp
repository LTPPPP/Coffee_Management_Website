<%@page import="DAO.CustomerDAO"%>
<%@page import="DAO.OrderDAO"%>
<%@page import="Models.Order"%>
<%@page import="DAO.StaffDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ItemDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>CAFE</title>

        <!-- link css -->
        <link rel="stylesheet" href="../asset/css/style_home_customer.css" />
        <link rel="stylesheet" href="../asset/css/base.css" />
        <link rel="stylesheet" href="../asset/css/grid.css">
        <link rel="stylesheet" href="../asset/font/fontawesome-free-6.4.2-web/css/all.min.css" />

        <!-- link logo -->
        <link rel="icon" href="../asset/img/img_admin/img_Order/logo-symbol.png" type="image/x-icon">


        <!-- link js -->
        <script src="/asset/js/js_home-customer.js" defer></script>
    </head>

    <body>
        <!-- DESKTOP NAVIGATION BAR -->
        <nav id="desktop-nav">
            <div class="logo-and-name-container hide-on-moblile">
                <a href="${pageContext.request.contextPath}/signout">
                    <h1 class="logo-and-name">
                        <img src="../asset/img/img_admin/img_Order/logo.png" alt="" class="logo" />
                    </h1>
                </a>
            </div>
            <div class="nav-links-container">
                <ul class="nav-links">
                    <li>
                        <%
                            String id = (String) request.getAttribute("id");
                        %>
                        <a href="cart?idFromHome=<%= id%>">
                            <i class="fa-solid fa-house"></i>
                            <div class="nav-links-title">HOME</div>
                        </a>
                    </li>

                    <li>
                        <a href="cart?idFromHome=<%= id%>">
                            <i class="fa-solid fa-bag-shopping"></i>
                            <div class="nav-links-title">ORDER</div>
                        </a>
                    </li>

                    <li>
                        <a href="#staff-title">
                            <i class="fa-solid fa-circle-question"></i>
                            <div class="nav-links-title">HELP</div>
                        </a>
                    </li>

                    <li class="hide-on-moblile">
                        <a href="#footer">
                            <div class="nav-links-title">ABOUT</div>
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
                    <div class="cart-list col l-12">
                    </div>
                    <button class="cart-submit">ORDER</button>
                </form>
            </div>
        </div>

        <!-- HOME -->

        <!-- slider -->
        <div style="background-image: url();" id="slider" class="hide-on-moblile">
            <!-- slider img -->
            <div class="slider-list">

                <div class="slider-item">
                    <div style="background-image: url(../asset/img/img_customer/slider/welcome_slide.png);" class="slider-img">
                        <div class="slider-content">
                            <a href="#" class="btn-link">
                                <button class="item-btn brown"> ORDER NOW
                                </button>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="slider-item">
                    <div style="background-image: url(../asset/img/img_customer/slider/welcome_slide2.png);" class="slider-img">
                        <div class="slider-content">
                            <a href="#" class="btn-link">
                                <button class="item-btn yellow"> ORDER NOW
                                </button>
                            </a>
                        </div>
                    </div>
                </div>


                <div class="slider-item">
                    <div style="background-image: url(../asset/img/img_customer/slider/welcome_slide.png);" class="slider-img">
                        <div class="slider-content">
                            <a href="#" class="btn-link">
                                <button class="item-btn brown"> ORDER NOW
                                </button>
                            </a>
                        </div>
                    </div>
                </div>


                <div class="slider-item">
                    <div style="background-image: url(../asset/img/img_customer/slider/welcome_slide2.png);" class="slider-img">
                        <div class="slider-content">
                            <a href="#" class="btn-link">
                                <button class="item-btn yellow"> ORDER NOW
                                </button>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="slider-item">
                    <div style="background-image: url(../asset/img/img_customer/slider/welcome_slide.png);" class="slider-img">
                        <div class="slider-content">
                            <a href="#" class="btn-link">
                                <button class="item-btn brown"> ORDER NOW
                                </button>
                            </a>
                        </div>
                    </div>
                </div>



            </div>

            <!-- slider button -->
            <div class="slider-btn">
                <button id="slider-button_pre">
                    <i class="fa-solid fa-angle-left"></i>
                </button>
                <button id="slider-button_next">
                    <i class="fa-solid fa-angle-right"></i>
                </button>
            </div>

            <!-- sldier dots -->
            <ul class="slider-dot">
                <li class="dot-item__active"></li>
                <li class="dot-item"></li>
                <li class="dot-item"></li>
                <li class="dot-item"></li>
                <li class="dot-item"></li>
            </ul>

        </div>

        <!-- category -->
        <div class="category hide-on-moblile">
            <div class="category-content">
                <div class="row">
                    <div class="category-item col l-4">
                        <a href="#drink-container">
                            <div class="category-icon">
                                <img src="../asset/img/img_customer/category/coffee.png" alt="">
                            </div>
                            <div class="catergory-title">DRINK</div>
                        </a>
                    </div>

                    <div class="category-item col l-4">
                        <a href="#food-container">
                            <div class="category-icon">
                                <img src="../asset/img/img_customer/category/food.png" alt="">
                            </div>
                            <div class="catergory-title">FOOD</div>
                        </a>
                    </div>

                    <div class="category-item col l-4">
                        <a href="#dessert-container">
                            <div class="category-icon">
                                <img src="../asset/img/img_customer/category/dessert.png" alt="">
                            </div>
                            <div class="catergory-title">DESSERT</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- ORDER -->
        <!-- Drink section -->
        <div id="drink-container">
            <div class="title">Drink</div>
        </div>
        <div class="item-container">

            <%                ItemDAO itemDAO = new ItemDAO();
                ResultSet rs = itemDAO.getAllDrink();
                while (rs.next()) {
            %>

            <div class="item-order">
                <input type="hidden" name="idItem" value="<%= rs.getString("Item_id")%>">
                <img src="<%= rs.getString("Item_picture")%>" alt="" class="item-img" />
                <div class="item-content">
                    <div class="item-name"><%= rs.getString("Item_name")%></div>
                    <div class="item-price"><%= rs.getString("Item_price")%> VND</div>
                </div>
                <button class="orderBtn">Add</button>
            </div>

            <%};%>
        </div>


        <!-- Food section -->

        <div id="food-container">
            <div class="title">Food</div>
        </div>
        <div class="item-container">
            <%
                rs = itemDAO.getAllFood();
                while (rs.next()) {
            %>
            <div class="item-order">
                <input type="hidden" name="idItem" value="<%= rs.getString("Item_id")%>">
                <img src="<%= rs.getString("Item_picture")%>" alt="" class="item-img" />
                <div class="item-content">
                    <div class="item-name"><%= rs.getString("Item_name")%></div>
                    <div class="item-price"><%= rs.getString("Item_price")%> VND</div>
                </div>
                <button class="orderBtn">Add</button>
            </div>

            <%};%>

        </div>

        <!-- Dessert section -->
        <div id="dessert-container">
            <div class="title">Dessert</div>
        </div>
        <div class="item-container">
            <%
                rs = itemDAO.getAllDessert();
                while (rs.next()) {
            %>
            <div class="item-order">
                <input type="hidden" name="idItem" value="<%= rs.getString("Item_id")%>">
                <img src="<%= rs.getString("Item_picture")%>" alt="" class="item-img" />
                <div class="item-content">
                    <div class="item-name"><%= rs.getString("Item_name")%></div>
                    <div class="item-price"><%= rs.getString("Item_price")%> VND</div>
                </div>
                <button class="orderBtn">Add</button>
            </div>
            <%};%>
        </div>
        <!-- FOOTER -->
        <footer id="footer" class="hide-on-moblile">
            <div class="grid wide">

                <div class="row">

                    <div class="footer-item col l-4 c-12">
                        <img src="../asset/img/img_admin/img_Order/logo.png" alt="" class="footer-logo">
                        <div class="footer-description">Helo, hey hey whatsup</div>
                        <div class="footer-icon">

                            <div class="row">

                                <a href="" class="footer-icon-link l-1 c-2">
                                    <i class="fa-brands fa-facebook"></i>
                                </a>
                                <a href="" class="footer-icon-link l-1 c-2">
                                    <i class="fa-brands fa-square-instagram"></i>
                                </a>
                                <a href="" class="footer-icon-link l-1 c-2">
                                    <i class="fa-brands fa-github"></i>
                                </a>
                            </div>

                        </div>
                    </div>

                    <div class="footer-item col l-4 c-6">
                        <div class="footer-title">Navigation</div>
                        <a href="" class="footer-item-link">Home</a>
                        <a href="" class="footer-item-link">About</a>
                        <a href="" class="footer-item-link">Help</a>
                        <a href="" class="footer-item-link">About</a>
                    </div>

                    <div class="footer-item col l-4 c-6">
                        <div class="footer-title">Contact</div>

                        <div class="footer-item-contact">
                            <i class="fa-solid fa-location-dot"></i>
                            X/XX, Ninh Kieu, Can Tho
                            
                        </div>

                        <div class="footer-item-contact">
                            <i class="fa-solid fa-phone"></i>
                            XXXXXXXXXX
                        </div>

                        <div class="footer-item-contact">
                            <i class="fa-solid fa-envelope"></i>
                            XXXXX@gmail.com
                        </div>
                    </div>

                </div>


            </div>
        </footer>

        <div class="footer-bottom hide-on-moblile">
            ©2024 - Group 6
        </div>

        <script>
            let cartSubmit = document.querySelector('.cart-submit');
            cartSubmit.onclick = () => {
                let cartForm = document.querySelectorAll('.cartForm');
                cartForm.forEach((e) => {
                    e.submit();
                });
            };
            document.querySelectorAll('.category-item a').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();

                    const targetId = this.getAttribute('href').substring(1);
                    const targetElement = document.getElementById(targetId);

                    if (targetElement) {
                        const offset = 50; // Desired offset in pixels
                        const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - offset;

                        window.scrollTo({
                            top: targetPosition,
                            behavior: 'smooth'
                        });
                    }
                });
            });
            document.querySelector('.cart-submit').addEventListener('click', function (e) {
                e.preventDefault();

                let cartForm = document.querySelector('.cartForm');
                let cartItems = document.querySelectorAll('.cart-item');

                // Clear any previously added hidden inputs
                cartForm.querySelectorAll('input[name^="itemId"], input[name^="quantity"]').forEach(el => el.remove());

                cartItems.forEach((item, index) => {
                    let itemId = item.querySelector('input[name="idItem"]').value;
                    let quantity = item.querySelector('.cart-quantity-input').value;

                    let itemIdInput = document.createElement('input');
                    itemIdInput.type = 'hidden';
                    itemIdInput.name = 'itemId';
                    itemIdInput.value = itemId;

                    let quantityInput = document.createElement('input');
                    quantityInput.type = 'hidden';
                    quantityInput.name = 'quantity';
                    quantityInput.value = quantity;

                    cartForm.appendChild(itemIdInput);
                    cartForm.appendChild(quantityInput);
                });

                cartForm.submit();
            });
        </script>
    </body>
</html>
