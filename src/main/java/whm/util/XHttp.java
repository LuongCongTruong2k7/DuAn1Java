package whm.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/** JSON response helper (Jackson). */
public final class XHttp {
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private XHttp() {
    }

    public static void json(HttpServletResponse resp, Object body) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        MAPPER.writeValue(resp.getWriter(), body);
    }
}
