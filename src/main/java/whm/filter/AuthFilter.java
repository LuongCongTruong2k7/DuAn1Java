package whm.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import whm.entity.User;
import whm.util.XAttr;
import whm.util.XAuth;
import java.io.IOException;

/**
 * Access control:
 * - /login and static resources: public
 * - everything else: signed-in users only
 * - /admin/receipts + /admin/issues: staff may create/update orders
 * - /admin/categories, /admin/products, /admin/reports: staff may view (GET) but not modify (POST)
 * - /admin/users and every other /admin/*: admin only
 * - sensitive actions (approve/delete) checked again inside the servlets
 */
@SuppressWarnings("serial")
@WebFilter(filterName = "AuthFilter", urlPatterns = "/*")
public class AuthFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        String path = req.getRequestURI().substring(req.getContextPath().length());

        if (isPublic(path)) {
            chain.doFilter(req, resp);
            return;
        }

        // Live session: re-read the signed-in user from the DB so profile edits,
        // role changes, and deactivation take effect immediately. A deleted or
        // disabled account is signed out right here.
        User user = XAuth.refreshCurrentUser(req);
        if (user == null) {
            XAuth.signOut(req);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (path.startsWith("/admin/") && !user.isAdmin() && !staffAllowed(req, path)) {
            XAttr.flashError(req, "Bạn không có quyền truy cập chức năng này");
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        chain.doFilter(req, resp);
    }

    /** Rules for non-admin staff; returns true when the request is permitted. */
    private boolean staffAllowed(HttpServletRequest req, String path) {
        if ("GET".equals(req.getMethod()))
            return path.startsWith("/admin/receipts") || path.startsWith("/admin/issues")
                    || path.startsWith("/admin/categories") || path.startsWith("/admin/products")
                    || path.startsWith("/admin/reports")
                    || path.equals("/admin/ws");
        return path.startsWith("/admin/receipts") || path.startsWith("/admin/issues");
    }

    private boolean isPublic(String path) {
        return path.equals("/login") || path.equals("/forgot-password")
                || path.startsWith("/css/") || path.startsWith("/js/")
                || path.startsWith("/images/") || path.equals("/favicon.ico");
    }
}
