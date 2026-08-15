package whm.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.entity.User;
import whm.service.AuthService;
import whm.service.AuthServiceImpl;
import whm.util.*;
import java.io.IOException;

/** Profile page + change password. */
@SuppressWarnings("serial")
@WebServlet("/account")
public class AccountServlet extends HttpServlet {
    private final AuthService authService = new AuthServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("active", "account");
        XPath.view(req, resp, "taikhoan");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = XAuth.currentUser(req);
        String oldPw = XParam.getString(req, "oldPassword", "");
        String newPw = XParam.getString(req, "newPassword", "");
        String confirm = XParam.getString(req, "confirmPassword", "");

        if (newPw.length() < 6)
            XAttr.flashError(req, "Mật khẩu mới phải từ 6 ký tự");
        else if (!newPw.equals(confirm))
            XAttr.flashError(req, "Xác nhận mật khẩu không khớp");
        else if (!authService.changePassword(user.getUserId(), oldPw, newPw))
            XAttr.flashError(req, "Mật khẩu hiện tại không đúng");
        else
            XAttr.flashSuccess(req, "Đổi mật khẩu thành công");

        XPath.redirect(req, resp, "/account");
    }
}
