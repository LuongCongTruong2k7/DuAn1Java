package whm.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.entity.User;
import whm.service.AuthService;
import whm.service.AuthServiceImpl;
import whm.util.*;
import java.io.IOException;

/**
 * Quên mật khẩu: nhập email → sinh mật khẩu mới → gửi mail)
 */
@SuppressWarnings("serial")
@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private final AuthService authService = new AuthServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (XAuth.currentUser(req) != null) {
            XPath.redirect(req, resp, "/dashboard");
            return;
        }
        XPath.view(req, resp, "forgot-password");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = XParam.getString(req, "email", "");
        User u = authService.findByEmail(email);
        if (u == null || Boolean.FALSE.equals(u.getIsActive())) {
            XAttr.flashError(req, "Không tìm thấy tài khoản với email này");
            XPath.redirect(req, resp, "/forgot-password");
            return;
        }
        String newPw = authService.resetPassword(email);
        try {
            XMail.send(email, "Mật khẩu mới - Quản lý kho",
                    "<h3>Mật khẩu mới của bạn</h3><p><b>" + newPw + "</b></p>");
        } catch (IllegalStateException e) {
            XAttr.flashError(req, "Gửi email thất bại: " + e.getMessage());
            XPath.redirect(req, resp, "/forgot-password");
            return;
        }
        XAttr.flashSuccess(req, "Mật khẩu mới đã được gửi đến email " + email);
        XPath.redirect(req, resp, "/login");
    }
}
