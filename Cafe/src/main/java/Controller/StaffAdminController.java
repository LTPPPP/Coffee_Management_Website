package Controller;

import DAO.StaffDAO;
import Models.Staff;
import java.io.IOException;
import java.io.File;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.List;

@WebServlet(name = "StaffAdminController", urlPatterns = {"/staff-admin"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class StaffAdminController extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "upload";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StaffDAO staffDAO = new StaffDAO();
        List<Staff> staffList = staffDAO.getStaffList();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("staff-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("action " + action);
        boolean success = false;
        String message = "";

        try {
            if (null != action) {
                switch (action) {
                    case "add":
                        success = addStaff(request);
                        message = success ? "Staff added successfully." : (String) request.getSession().getAttribute("alertMessage");
                        break;
                    case "delete":
                        String staffId = request.getParameter("Staff_id");
                        StaffDAO staffDAO = new StaffDAO();
                        success = staffDAO.deleteStaff(staffId);
                        message = success ? "Staff deleted successfully." : (String) request.getSession().getAttribute("alertMessage");
                        break;
                    case "update":
                        success = updateStaff(request);
                        message = success ? "Staff updated successfully." : (String) request.getSession().getAttribute("alertMessage");
                        break;
                    default:
                        break;
                }
            }
        } catch (ServletException | IOException e) {
            message = "An error occurred: " + e.getMessage();
        }

        request.getSession().setAttribute("alertMessage", message);
        response.sendRedirect(request.getContextPath() + "/staff-admin");
    }

    private boolean addStaff(HttpServletRequest request) throws ServletException, IOException {
        StaffDAO staffDAO = new StaffDAO();
        String staffId = request.getParameter("Staff_id");
        String phoneNumber = request.getParameter("Staff_phoneNum");
        if (staffDAO.staffIdExists(staffId)) {
            request.getSession().setAttribute("alertMessage", "Staff ID already exists. Please use a different ID.");
            return false;
        }
        if (!isValidPhoneNumber(phoneNumber)) {
            request.getSession().setAttribute("alertMessage", "Invalid phone number. It should be 10-11 digits and start with 0.");
            return false;
        }
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        Part filePart = request.getPart("Staff_pic");
        if (filePart == null || filePart.getSize() == 0) {
            request.getSession().setAttribute("alertMessage", "Please select a picture for the staff member.");
            return false;
        }
        String fileName = "./asset/img/img_staff/img_staffAcc/" + getFileName(filePart);
        System.out.println(fileName);
        Staff staff = new Staff(
                staffId,
                request.getParameter("Staff_name"),
                fileName,
                request.getParameter("Staff_role"),
                request.getParameter("Staff_user"),
                request.getParameter("Staff_pass"),
                request.getParameter("Staff_phoneNum"),
                Boolean.parseBoolean(request.getParameter("Staff_status"))
        );
        return staffDAO.addStaff(staff);
    }

    private boolean deleteStaff(HttpServletRequest request) {
        String staffId = request.getParameter("Staff_id");
        if (staffId != null && !staffId.isEmpty()) {
            StaffDAO staffDAO = new StaffDAO();
            boolean result = staffDAO.deleteStaff(staffId);
            System.out.println("Delete result: " + result);
            return staffDAO.deleteStaff(staffId);
        }
        return false;
    }

    private boolean updateStaff(HttpServletRequest request) throws ServletException, IOException {
        StaffDAO staffDAO = new StaffDAO();
        String staffId = request.getParameter("Staff_id");
        String phoneNumber = request.getParameter("Staff_phoneNum");
        if (!staffDAO.staffIdExists(staffId)) {
            request.getSession().setAttribute("alertMessage", "Staff ID does not exist in the database.");
            return false;
        }
        if (!isValidPhoneNumber(phoneNumber)) {
            request.getSession().setAttribute("alertMessage", "Invalid phone number. It should be 10-11 digits and start with 0.");
            return false;
        }
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String staffName = request.getParameter("Staff_name");
        String staffRole = request.getParameter("Staff_role");
        String staffUser = request.getParameter("Staff_user");
        String staffPass = request.getParameter("Staff_pass");
        String staffPhoneNum = request.getParameter("Staff_phoneNum");
        boolean staffStatus = Boolean.parseBoolean(request.getParameter("Staff_status"));

        String relativePath = null;
        Part filePart = request.getPart("Staff_pic");
        if (filePart == null || filePart.getSize() == 0) {
            // For update, we might want to allow updates without changing the picture
            // So, we'll check if other fields are being updated
            boolean isUpdatingOtherFields = !staffName.isEmpty() || !staffRole.isEmpty()
                    || !staffUser.isEmpty() || !staffPass.isEmpty()
                    || !staffPhoneNum.isEmpty();

            if (isUpdatingOtherFields) {
                request.getSession().setAttribute("alertMessage", "Please select a new picture or keep the existing one.");
                return false;
            }
        } else {
            String fileName = "./asset/img/img_staff/img_staffAcc/" + getFileName(filePart);
            System.out.println(fileName);
        }

        Staff staff = new Staff(staffId, staffName, relativePath, staffRole, staffUser, staffPass, staffPhoneNum, staffStatus);
        return staffDAO.updateStaff(staff);
    }

    private String getFileName(Part part) {
        if (part == null) {
            return null;
        }
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) {
            return null;
        }
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber != null && phoneNumber.matches("^0\\d{9,10}$");
    }
}
