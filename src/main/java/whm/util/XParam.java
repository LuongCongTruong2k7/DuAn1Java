package whm.util;

import jakarta.servlet.http.HttpServletRequest;

/** Safe request-parameter readers. */
public final class XParam {
    private XParam() {
    }

    public static String getString(HttpServletRequest req, String name, String def) {
        String v = req.getParameter(name);
        return (v == null || v.isBlank()) ? def : v.trim();
    }

    public static Integer getInt(HttpServletRequest req, String name, Integer def) {
        try {
            return Integer.valueOf(req.getParameter(name).trim());
        } catch (Exception e) {
            return def;
        }
    }

    public static boolean getBool(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return "true".equalsIgnoreCase(v) || "on".equalsIgnoreCase(v) || "1".equals(v);
    }
}
