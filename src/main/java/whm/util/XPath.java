package whm.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;

/** Forward/redirect helpers. Views live under /WEB-INF/views. */
public final class XPath {
    private XPath() {
    }

    public static void view(HttpServletRequest req, HttpServletResponse resp, String viewName)
            throws ServletException, IOException {
        XAttr.pullFlash(req);
        req.setAttribute("currentUser", XAuth.currentUser(req));
        req.getRequestDispatcher("/WEB-INF/views/" + viewName + ".jsp").forward(req, resp);
    }

    public static void redirect(HttpServletRequest req, HttpServletResponse resp, String path)
            throws IOException {
        resp.sendRedirect(req.getContextPath() + path);
    }
}
