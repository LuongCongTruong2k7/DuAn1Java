package whm.servlet.adm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.service.*;
import whm.ws.RealtimeNotifier;
import whm.util.*;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/admin/issues")
public class IssueServlet extends HttpServlet {
    private final IssueService service = new IssueServiceImpl();
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer viewId = XParam.getInt(req, "view", null);
        if (viewId != null)
            req.setAttribute("current", service.findById(viewId));
        req.setAttribute("issues", service.findAll());
        req.setAttribute("products", productService.findActive());
        req.setAttribute("active", "issues");
        XPath.view(req, resp, "xuatkho");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = XParam.getString(req, "action", "");
        Integer id = XParam.getInt(req, "id", null);
        String back = id == null ? "/admin/issues" : "/admin/issues?view=" + id;
        try {
            switch (action) {
                case "create" -> {
                    String recipient = XParam.getString(req, "recipient", "");
                    if (recipient.isEmpty())
                        throw new IllegalStateException("Tên người nhận không được để trống");
                    var i = service.create(
                            recipient,
                            XParam.getString(req, "remarks", null),
                            XAuth.currentUser(req).getUserId());
                    XAttr.flashSuccess(req, "Đã tạo phiếu xuất #" + i.getIssueId());
                    RealtimeNotifier.notifyOrderCreated("issue", i.getIssueId());
                    back = "/admin/issues?view=" + i.getIssueId();
                }
                case "addDetail" -> {
                    service.addDetail(id, XParam.getInt(req, "productId", -1), XParam.getInt(req, "quantity", 0));
                    XAttr.flashSuccess(req, "Đã thêm sản phẩm vào phiếu");
                    RealtimeNotifier.notifyDetailChanged("issue", id, XAuth.currentUser(req).getFullName());
                }
                case "removeDetail" -> {
                    service.removeDetail(id, XParam.getInt(req, "productId", -1));
                    RealtimeNotifier.notifyDetailChanged("issue", id, XAuth.currentUser(req).getFullName());
                }
                case "approve" -> {
                    if (!XAuth.currentUser(req).isAdmin())
                        throw new IllegalStateException("Chỉ Quản lý mới được duyệt phiếu xuất");
                    service.approve(id, XAuth.currentUser(req).getUserId());
                    XAttr.flashSuccess(req, "Đã duyệt phiếu xuất — hàng đã ra kho");
                    // Realtime: notify the staff member watching this issue.
                    RealtimeNotifier.notifyApproved("issue", id, XAuth.currentUser(req).getFullName());
                }
                case "delete" -> {
                    service.delete(id);
                    XAttr.flashSuccess(req, "Đã xóa phiếu xuất");
                    back = "/admin/issues";
                }
                default -> throw new IllegalStateException("Hành động không hợp lệ");
            }
        } catch (IllegalStateException e) {
            XAttr.flashError(req, e.getMessage());
        }
        XPath.redirect(req, resp, back);
    }
}
