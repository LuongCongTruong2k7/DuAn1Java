package whm.util;

import jakarta.servlet.http.HttpServletRequest;

/** Flash messages stored in session, shown once then cleared. */
public final class XAttr {
    private XAttr() {
    }

    public static void flashSuccess(HttpServletRequest req, String msg) {
        req.getSession().setAttribute("flashSuccess", msg);
    }

    public static void flashError(HttpServletRequest req, String msg) {
        req.getSession().setAttribute("flashError", msg);
    }

    /**
     * Move flash attributes from session to request scope (call before forwarding
     * to a view).
     */
    public static void pullFlash(HttpServletRequest req) {
        var s = req.getSession();
        for (String k : new String[] { "flashSuccess", "flashError" }) {
            Object v = s.getAttribute(k);
            if (v != null) {
                req.setAttribute(k, v);
                s.removeAttribute(k);
            }
        }
    }
}
