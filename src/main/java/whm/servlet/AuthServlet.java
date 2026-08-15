package whm.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.entity.User;
import whm.service.AuthService;
import whm.service.AuthServiceImpl;
import whm.util.*;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet({ "/login", "/logout" })
public class AuthServlet extends HttpServlet {
    private final AuthService authService = new AuthServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if ("/logout".equals(req.getServletPath())) {
            XAuth.signOut(req);
            XPath.redirect(req, resp, "/login");
            return;
        }
        if (XAuth.currentUser(req) != null) {
            XPath.redirect(req, resp, "/dashboard");
            return;
        }
        req.setAttribute("rememberedUsername", XCookie.get(req, "username"));
        req.setAttribute("rememberedPassword", XCookie.get(req, "password"));
        XPath.view(req, resp, "login");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = XParam.getString(req, "username", "");
        String password = XParam.getString(req, "password", "");
        User user = authService.login(username, password);
        if (user == null) {
            req.setAttribute("flashError", "Sai tên đăng nhập hoặc mật khẩu");
            req.setAttribute("rememberedUsername", username);
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }
        XAuth.signIn(req, user);
        if (XParam.getBool(req, "remember")) {
            XCookie.add(resp, "username", username, 30);
            XCookie.add(resp, "password", password, 30);
        } else {
            XCookie.remove(resp, "username");
            XCookie.remove(resp, "password");
        }
        XPath.redirect(req, resp, "/dashboard");
    }
}
