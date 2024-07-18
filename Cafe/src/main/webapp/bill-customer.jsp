<%@page import="DAO.ItemDAO" %>
<%@page import="DAO.CustomerDAO" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="DAO.OrderDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CAFE</title>

        <!-- link css -->
        <link rel="stylesheet" href="../asset/css/style_bill-customer.css">
        <link rel="stylesheet" href="../asset/css/base.css">
        <link rel="stylesheet" href="../asset/css/responsive.css">
        <link rel="stylesheet" href="../asset/css/grid.css">
        <link rel="stylesheet" href="../asset/font/fontawesome-free-6.4.2-web/css/all.min.css">

        <!-- link logo -->
        <link rel="icon" href="../asset/img/img_admin/img_Order/logo-symbol.png"
              type="image/x-icon">

        <!-- link js -->
        <script src="/asset/js/js_bill-customer.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script
        src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>

    </head>

    <body onload="autoClick();">

        <div class="app">
            <div class="bill-container">

                <div class="grid">

                    <!-- Bill container -->
                    <div class="bill-title-container">
                        <div class="row">

                            <div class="bill-logo col l-12 c-12">
                                <img src="../asset/img/img_admin/img_Order/logo.png" alt="">
                            </div>
                            <div class="bill-location col l-12 c-12">
                                XXX,XX/XX XX, Ninh Kieu, Can Tho
                            </div>

                            <div class="bill-phone col l-12 c-12">
                                DT: XXXXXXXXXX
                            </div>


                        </div>
                    </div>

                    <% String idCus = (String) request.getAttribute("idCus"); %>

                    <!-- bill content -->
                    <div class="bill-content">

                        <div class="bill-title">
                            Payment
                        </div>
                        <div class="bill-info">
                            <% OrderDAO orderDAO = new OrderDAO();
                                ResultSet rs = orderDAO.getOrderByIdCus(idCus);
                                String date = "";
                                String time = "";
                                while (rs.next()) {
                                    String datetime = rs.getString("Order_date");
                                    String[] arr = datetime.split("\\s+");
                                    String[] arrDate = arr[0].split("-");
                                    date = arrDate[2] + "-" + arrDate[1] + "-" + arrDate[0];
                                    time = arr[1].substring(0, 5);
                                    break;
                                };
                                String table = "";
                                CustomerDAO customerDAO = new CustomerDAO();
                                rs = customerDAO.getAllCustomerById(idCus);
                                                        while (rs.next()) {
                                                            table = rs.getString("Customer_table");
                                                            break;
                                                        }%>
                            <div class="bill-date">Date: <%= date + " " + time%>
                            </div>
                            <div class="bill-table">Table: <%= table%>
                            </div>
                        </div>

                        <div class="receipt-container">

                            <div class="row">

                                <!-- receipt title -->
                                <div class="receipt-title col l-12 c-12">
                                    <div class="row">

                                        <div class="receipt-title-item col l-3 c-3">Item</div>
                                        <div class="receipt-title-item col l-3 c-2">Price</div>
                                        <div class="receipt-title-item col l-3 c-3">Quantity
                                        </div>
                                        <div class="receipt-title-item col l-3 c-4">Final Price
                                        </div>

                                    </div>
                                </div>


                                <!-- receipt list -->
                                <div class="receipt-list col l-12 c-12">
                                    <div class="row">

                                        <% rs = orderDAO.getOrderByIdCus(idCus);
                                            float total = 0;
                                            while (rs.next()) {
                                                ItemDAO itemDAO = new ItemDAO();
                                                ResultSet itemInfo = itemDAO.getItemByIdResultSet(rs.getString("Item_id"));
                                                while (itemInfo.next()) {
                                                    float finalPrice = Float.parseFloat(itemInfo.getString("Item_price"))
                                                                                    * Float.parseFloat(rs.getString("Order_quantity"));
                                                                            total += finalPrice;%>

                                        <div class="receipt-item col l-12 c-12">
                                            <div class="row">
                                                <div class="receipt-name col l-3 c-3">
                                                    <%= itemInfo.getString("Item_name")%>
                                                </div>
                                                <div class="receipt-price col l-3 c-2">
                                                    <%= itemInfo.getString("Item_price")%> VND
                                                </div>
                                                <div class="receipt-quantity col l-3 c-3">x
                                                    <%=rs.getString("Order_quantity")%>
                                                </div>
                                                <div class="receipt-total col l-3 c-4">
                                                    <%= finalPrice + "00"%> VND
                                                </div>
                                            </div>
                                        </div>

                                        <%};
                                                                        };%>
                                    </div>
                                </div>

                                <!-- receipt list -->
                                <div class="receipt-bottom col l-12 c-12">
                                    <div class="row">
                                        <div class="receipt-bottom-item col l-9 c-8">Total</div>
                                        <div class="receipt-bottom-item col l-3 c-4">
                                            <%= total + "00"%> VND
                                        </div>

                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>
        </div>

        <!-- button -->
        <div class="button-container">
            <a style="text-decoration: none;" class="download-link">
                <button class="save-button">
                    Save As PNG
                </button>
            </a>
        </div>

        <!-- Hmtl to javascript -->
        <script>
            function autoClick() {
                $(".download-link").click();
            }
            $(document).ready(function () {
                var element = $(".bill-container");

                $(".download-link").on('click', function () {

                    html2canvas(element, {
                        onrendered: function (canvas) {
                            var imageData = canvas.toDataURL("image/png");
                            var newData = imageData.replace(/^data:image\/png/, "data:application/octet-stream");
                            $(".download-link").attr("download", "bill.png").attr("href", newData);
                        }
                    });
                });
            });
        </script>


    </body>

</html>