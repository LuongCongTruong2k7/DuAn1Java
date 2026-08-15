package whm.servlet.adm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.report.FlowReport;
import whm.report.StockReport;
import whm.service.ReportService;
import whm.service.ReportServiceImpl;
import whm.util.XParam;
import whm.util.XPath;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {
    private final ReportService service = new ReportServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String type = XParam.getString(req, "type", "stock");
        boolean json = "json".equals(XParam.getString(req, "format", ""));
        if ("flow".equals(type)) {
            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
            Date to = new Date(), from;
            try {
                from = fmt.parse(XParam.getString(req, "from", ""));
            } catch (Exception e) {
                Calendar c = Calendar.getInstance();
                c.add(Calendar.DAY_OF_MONTH, -30);
                from = c.getTime();
            }
            try {
                Date parsedTo = fmt.parse(XParam.getString(req, "to", ""));
                Calendar c = Calendar.getInstance();
                c.setTime(parsedTo);
                c.add(Calendar.DAY_OF_MONTH, 1); // inclusive end of day
                to = c.getTime();
            } catch (Exception ignored) {
            }
            List<FlowReport> flow = service.flow(from, to);
            if (json) {
                writeFlowJson(resp, flow);
                return;
            }
            req.setAttribute("flow", flow);
            req.setAttribute("from", fmt.format(from));
            req.setAttribute("to", fmt.format(to));
        } else {
            List<StockReport> stock = service.stock();
            if (json) {
                writeStockJson(resp, stock);
                return;
            }
            req.setAttribute("stock", stock);
        }
        req.setAttribute("type", type);
        req.setAttribute("active", "reports");
        XPath.view(req, resp, "baocao");
    }

    // ---- JSON output (for the realtime report page, no page reload) -------

    private void writeStockJson(HttpServletResponse resp, List<StockReport> stock)
            throws IOException {
        StringBuilder sb = new StringBuilder("[");
        for (StockReport s : stock) {
            if (sb.length() > 1) sb.append(',');
            sb.append("{\"productId\":").append(s.getProductId())
              .append(",\"productName\":\"").append(esc(s.getProductName()))
              .append("\",\"unit\":\"").append(esc(s.getUnit()))
              .append("\",\"received\":").append(s.getReceived())
              .append(",\"issued\":").append(s.getIssued())
              .append(",\"stock\":").append(s.getStock())
              .append(",\"minStock\":").append(s.getMinStock())
              .append(",\"maxStock\":").append(s.getMaxStock())
              .append(",\"low\":").append(s.isLow())
              .append(",\"over\":").append(s.isOver())
              .append('}');
        }
        sendJson(resp, sb.append(']').toString());
    }

    private void writeFlowJson(HttpServletResponse resp, List<FlowReport> flow)
            throws IOException {
        StringBuilder sb = new StringBuilder("[");
        for (FlowReport f : flow) {
            if (sb.length() > 1) sb.append(',');
            sb.append("{\"productName\":\"").append(esc(f.getProductName()))
              .append("\",\"unit\":\"").append(esc(f.getUnit()))
              .append("\",\"received\":").append(f.getReceived())
              .append(",\"issued\":").append(f.getIssued())
              .append(",\"net\":").append(f.getNet())
              .append('}');
        }
        sendJson(resp, sb.append(']').toString());
    }

    private static void sendJson(HttpServletResponse resp, String body) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        resp.setHeader("Cache-Control", "no-store");
        resp.getWriter().write(body);
    }

    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
