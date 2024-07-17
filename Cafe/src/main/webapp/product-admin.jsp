<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
        <link rel="stylesheet" href="asset/css/style_product-admin.css">
        <link rel="stylesheet" href="asset/font/fontawesome-free-6.4.2-web/css/all.min.css">

        <!-- link logo -->
        <link rel="icon" href="./asset/img/img_admin/img_Order/logo-symbol.png" type="image/x-icon">

        <!-- link js -->
        <script src="./asset/js/js_product-admin.js" defer></script>
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

                    <style>
                        .menu-item {
                            width: 100%; /* Ensure the menu item takes full width of its container */
                        }

                        .menu-link {
                            display: block; /* Make the link a block-level element */
                            width: 100%; /* Set the link width to 100% of its parent */
                            padding: 10px 15px; /* Add some padding for better clickability */
                            text-decoration: none; /* Remove underline from links */
                            color: inherit; /* Inherit text color from parent */
                        }
                    </style>

                    <div class="menu-item">
                        <a href="/order-admin" class="menu-link">ORDER</a>
                    </div>

                    <div class="menu-item">
                        <a href="/staff-admin" class="menu-link">STAFF</a>
                    </div>

                    <div class="menu-item">
                        <a href="/product-manager" class="menu-link">PRODUCTS</a>
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
                <button class="product-update-btn">
                    Update Product
                </button>
            </div>

            <div class="product-update-contain">
                <form id="productForm" action="${pageContext.request.contextPath}/product-manager" method="POST" enctype="multipart/form-data" class="product-update-form">
                    <div class="row">
                        <h1 class="product-update-title col l-6">Update Product</h1>
                        <div class="product-update-icon col l-6">
                            <i class="fa-solid fa-xmark"></i>
                        </div>
                        <div class="product-update-input-container col l-6">
                            <input type="text" name="item_id" class="product-update-input" required="required" placeholder="ID">
                        </div>

                        <div class="product-update-input-container col l-6">
                            <input type="text" name="item_name" class="product-update-input" required="required" placeholder="Name">
                        </div>
                        <div class="product-update-input-container col l-6">
                            <input type="text" name="item_price" class="product-update-input" required="required" placeholder="Price">
                        </div>
                        <div class="product-update-input-container col l-6">
                            <select name="item_type" class="product-update-input">
                                <option value="none">Select Type</option>
                                <option value="Food">Food</option>
                                <option value="Drink">Drink</option>
                                <option value="Dessert">Dessert</option>
                            </select>
                        </div>
                        <div class="product-update-input-container col l-12">
                            <input type="file" class="product-update-input" id="uploadBtn" required="required" name="item_picture" accept="image/*">
                            <label style="position: relative;" for="uploadBtn" class="label-title">
                                <i class="fa-solid fa-upload"></i>
                                Upload Picture
                            </label>
                            <span id="uploadStatus" style="font-size: 20px">(Empty)</span>
                            <img id="imagePreview" src="" alt="Preview" style="display: none; vertical-align: middle; margin-left: 10px; width: 30px; height: 30px; object-fit: cover;">
                        </div>

                        <input type="hidden" name="action" id="formAction" value="">
                        <div class="product-update-submit col l-12">
                            <button type="submit" onclick="document.getElementById('formAction').value = 'add'" class="btn-add">Add</button>
                            <button type="submit" onclick="document.getElementById('formAction').value = 'update'" class="btn-Update">Update</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Product SECTION -->
            <div class="product-container">
                <div class="grid wide">
                    <div class="product-title">Food</div>
                    <div class="row">
                        <c:forEach var="item" items="${foodItems}">
                            <div class="product-item col l-2-4">
                                <div class="product-content">
                                    <div class="row">
                                        <div class="product-img col l-12 c-4">
                                            <img src="${item.item_pic}" alt="${item.item_name}">
                                        </div>
                                        <div class="product-information col l-12 c-8">
                                            <div class="row">
                                                <div class="product-name col l-12 c-12">ID : ${item.item_id}</div>
                                                <div class="product-name col l-12 c-12">${item.item_name}</div>
                                                <div class="product-price col l-12 c-12">${item.item_price} VND</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-icon">
                                        <button class="btn-remove remove-btn" data-item-id="${item.item_id}">Remove</button>
                                        <form id="removeForm${item.item_id}" action="${pageContext.request.contextPath}/product-manager?action=remove" method="POST" style="display:none;">
                                            <input type="hidden" name="item_id" value="${item.item_id}">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Drink -->
                    <div class="product-title">Drink</div>
                    <div class="row">
                        <c:forEach var="item" items="${drinkItems}">
                            <div class="product-item col l-2-4">
                                <div class="product-content">
                                    <div class="row">
                                        <div class="product-img col l-12 c-4">
                                            <img src="${item.item_pic}" alt="${item.item_name}">
                                        </div>
                                        <div class="product-information col l-12 c-8">
                                            <div class="row">
                                                <div class="product-name col l-12 c-12">ID : ${item.item_id}</div>
                                                <div class="product-name col l-12 c-12">${item.item_name}</div>
                                                <div class="product-price col l-12 c-12">${item.item_price} VND</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-icon">
                                        <button class="btn-remove remove-btn" data-item-id="${item.item_id}">Remove</button>
                                        <form id="removeForm${item.item_id}" action="${pageContext.request.contextPath}/product-manager?action=remove" method="POST" style="display:none;">
                                            <input type="hidden" name="item_id" value="${item.item_id}">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Dessert -->
                    <div class="product-title">Dessert</div>
                    <div class="row">
                        <c:forEach var="item" items="${dessertItems}">
                            <div class="product-item col l-2-4">
                                <div class="product-content">
                                    <div class="row">
                                        <div class="product-img col l-12 c-4">
                                            <img src="${item.item_pic}" alt="${item.item_name}">
                                        </div>
                                        <div class="product-information col l-12 c-8">
                                            <div class="row">
                                                <div class="product-name col l-12 c-12">ID : ${item.item_id}</div>
                                                <div class="product-name col l-12 c-12">${item.item_name}</div>
                                                <div class="product-price col l-12 c-12">${item.item_price} VND</div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Replace the existing remove button with this -->
                                    <div class="product-icon">
                                        <button class="btn-remove remove-btn" data-item-id="${item.item_id}">Remove</button>
                                        <form id="removeForm${item.item_id}" action="${pageContext.request.contextPath}/product-manager?action=remove" method="POST" style="display:none;">
                                            <input type="hidden" name="item_id" value="${item.item_id}">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
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
        <div id="confirmOverlay" class="confirm-overlay" style="display:none;">
            <div class="confirm-content">
                <p id="confirmMessage"></p>
                <button onclick="confirmRemove(true)">YES</button>
                <button onclick="confirmRemove(false)">NO</button>
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
            let itemToRemove = null;

            function showConfirm(itemId, itemName) {
                itemToRemove = itemId;
                document.getElementById('confirmMessage').innerText = `Do you want to remove ${itemName}?`;
                document.getElementById('confirmOverlay').style.display = 'flex';
            }

            function confirmRemove(confirmed) {
                document.getElementById('confirmOverlay').style.display = 'none';
                if (confirmed && itemToRemove) {
                    document.getElementById('removeForm' + itemToRemove).submit();
                }
                itemToRemove = null;
            }

// Modify the existing remove buttons
            document.querySelectorAll('.remove-btn').forEach(button => {
                button.addEventListener('click', function (e) {
                    e.preventDefault();
                    const itemId = this.dataset.itemId;
                    const itemName = this.closest('.product-content').querySelector('.product-name').innerText;
                    showConfirm(itemId, itemName);
                });
            });

            function showAlert(message) {
                document.getElementById('alertMessage').innerText = message;
                document.getElementById('alertOverlay').style.display = 'flex';
            }

            function closeAlert() {
                document.getElementById('alertOverlay').style.display = 'none';
            }

            <%
                if (alertMessage != null) {
            %>
            showAlert("<%= alertMessage%>");
            <%
                    session.removeAttribute("alertMessage");
                }
            %>

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
