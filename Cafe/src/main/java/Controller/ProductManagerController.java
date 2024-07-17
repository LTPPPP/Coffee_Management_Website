package Controller;

import DAO.ItemDAO;
import Models.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet(name = "ProductManagerController", urlPatterns = {"/product-manager"})
@MultipartConfig
public class ProductManagerController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("action ProductManagerController : " + action);
        ItemDAO itemDAO = new ItemDAO();
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/listItem-admin");
            return;
        }

        boolean success = false;
        String message = "";

        try {
            switch (action) {
                case "add":
                    success = addProduct(request, response, itemDAO);
                    message = success ? "Item added successfully" : (String) request.getSession().getAttribute("alertMessage");
                    break;
                case "update":
                    success = updateProduct(request, response, itemDAO);
                    System.out.println("update success? " + success);
                    message = success ? "Item updated successfully" : (String) request.getSession().getAttribute("alertMessage");
                    break;
                case "remove":
                    success = removeProduct(request, response, itemDAO);
                    message = success ? "Item removed successfully" : (String) request.getSession().getAttribute("alertMessage");
                    break;
                default:
                    message = "Invalid action";
                    break;
            }
        } catch (ServletException | IOException e) {
            message = "An error occurred: " + e.getMessage();
        }

        request.getSession().setAttribute("alertMessage", message);
        response.sendRedirect(request.getContextPath() + "/listItem-admin");
    }

    @SuppressWarnings("empty-statement")
    private boolean addProduct(HttpServletRequest request, HttpServletResponse response, ItemDAO itemDAO)
            throws ServletException, IOException {
        String id = request.getParameter("item_id");
        if (itemDAO.isItemExists(id)) {
            // Item already exists, send error message
            request.getSession().setAttribute("alertMessage", "ID/Item already exists. Please use a different ID.");
            return false;
        }
        String name = request.getParameter("item_name");
        String priceStr = request.getParameter("item_price");
        float price;
        try {
            price = Float.parseFloat(priceStr);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("alertMessage", "Price must be a valid number. Price must be a number.");
            return false;
        }
        String type = request.getParameter("item_type");
        if ("none".equals(type)) {
            request.getSession().setAttribute("alertMessage", "Item type can't be empty. Please select type of item.");
            return false;
        }
        Part picturePart = request.getPart("item_picture");
        if (picturePart == null || picturePart.getSize() == 0) {
            request.getSession().setAttribute("alertMessage", "Please select a picture for the item.");
            return false;
        }
        String picture = picturePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        picturePart.write(uploadPath + "/" + picture);
        Item newItem = new Item();
        System.out.println("type : " + type);
        String picPath = "";
        if (null != type) {
            switch (type) {
                case "Food":
                    picPath = request.getContextPath() + "/asset/img/img_item/food/" + picture;
                    break;
                case "Drink":
                    picPath = request.getContextPath() + "/asset/img/img_item/drink/" + picture;
                    break;
                case "Dessert":
                    picPath = request.getContextPath() + "/asset/img/img_item/dessert/" + picture;
                    break;
                default:
                    break;
            }
        }
        newItem.setItem_id(id);
        newItem.setItem_name(name);
        newItem.setItem_price(price);
        newItem.setItem_type(type);
        newItem.setItem_pic(picPath);
        boolean success = itemDAO.addItem(newItem);
        if (success) {
            request.getSession().setAttribute("alertMessage", "Item added successfully.");
        } else {
            request.getSession().setAttribute("alertMessage", "Failed to add item.");
        }
        return success;
    }

    private boolean updateProduct(HttpServletRequest request, HttpServletResponse response, ItemDAO itemDAO)
            throws ServletException, IOException {
        String id = request.getParameter("item_id");
        if (id == null || id.trim().isEmpty() || !itemDAO.isItemExists(id)) {
            request.getSession().setAttribute("alertMessage", "Item with this ID does not exist.");
            return false;
        }

        String name = request.getParameter("item_name");
        String priceStr = request.getParameter("item_price");
        float price;
        try {
            price = Float.parseFloat(priceStr);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("alertMessage", "Price must be a valid number.");
            return false;
        }

        String type = request.getParameter("item_type");
        if ("none".equals(type)) {
            request.getSession().setAttribute("alertMessage", "Item type can't be empty. Please select type of item.");
            return false;
        }

        Part picturePart = request.getPart("item_picture");
        String picture = null;
        String picPath = null;

        if (picturePart != null && picturePart.getSize() > 0) {
            picture = picturePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            picturePart.write(uploadPath + "/" + picture);

            if (type != null) {
                switch (type) {
                    case "Food":
                        picPath = request.getContextPath() + "/asset/img/img_item/food/" + picture;
                        break;
                    case "Drink":
                        picPath = request.getContextPath() + "/asset/img/img_item/drink/" + picture;
                        break;
                    case "Dessert":
                        picPath = request.getContextPath() + "/asset/img/img_item/dessert/" + picture;
                        break;
                    default:
                        break;
                }
            }
        } else {
            // If no new picture is provided, keep the existing picture
            Item existingItem = itemDAO.getItemById(id);
            picPath = existingItem.getItem_pic();
        }

        Item updatedItem = new Item();
        updatedItem.setItem_id(id);
        updatedItem.setItem_name(name);
        updatedItem.setItem_price(price);
        updatedItem.setItem_type(type);
        updatedItem.setItem_pic(picPath);

        boolean success = itemDAO.updateItem(updatedItem);
        if (success) {
            request.getSession().setAttribute("alertMessage", "Item updated successfully.");
        } else {
            request.getSession().setAttribute("alertMessage", "Failed to update item.");
        }
        return success;
    }

    private boolean removeProduct(HttpServletRequest request, HttpServletResponse response, ItemDAO itemDAO)
            throws ServletException, IOException {
        String id = request.getParameter("item_id");
        if (itemDAO.removeItem(id)) {
            request.getSession().setAttribute("alertMessage", "Item removed successfully.");
        } else {
            request.getSession().setAttribute("alertMessage", "Failed to remove item.");
        }
        return itemDAO.removeItem(id);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
