package whm.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public final class XCookie {
    private XCookie() {
    }

    public static void add(HttpServletResponse resp, String name, String value, int days) {
        Cookie c = new Cookie(name, value == null ? "" : value);
        c.setMaxAge(days * 24 * 60 * 60);
        c.setPath("/");
        c.setHttpOnly(true);
        resp.addCookie(c);
    }

    public static String get(HttpServletRequest req, String name) {
        if (req.getCookies() != null)
            for (Cookie c : req.getCookies())
                if (c.getName().equals(name))
                    return c.getValue();
        return null;
    }

    public static void remove(HttpServletResponse resp, String name) {
        add(resp, name, "", 0);
    }
}
