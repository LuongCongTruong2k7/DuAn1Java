package whm.servlet.adm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.service.*;
import whm.ws.RealtimeNotifier;
import whm.util.*;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/admin/receipts")
public class ReceiptServlet extends HttpServlet {
    private final ReceiptService service = new ReceiptServiceImpl();
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer viewId = XParam.getInt(req, "view", null);
        if (viewId != null)
            req.setAttribute("current", service.findById(viewId));
        req.setAttribute("receipts", service.findAll());
        req.setAttribute("products", productService.findActive());
        req.setAttribute("active", "receipts");
        XPath.view(req, resp, "nhapkho");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = XParam.getString(req, "action", "");
        Integer id = XParam.getInt(req, "id", null);
        String back = id == null ? "/admin/receipts" : "/admin/receipts?view=" + id;
        try {
            switch (action) {
                case "create" -> {
                    String supplierName = XParam.getString(req, "supplierName", "");
                    if (supplierName.isEmpty())
                        throw new IllegalStateException("Tên nhà cung cấp không được để trống");
                    var r = service.create(
                            supplierName,
                            XParam.getString(req, "remarks", null),
                            XAuth.currentUser(req).getUserId());
                    XAttr.flashSuccess(req, "Đã tạo phiếu nhập #" + r.getReceiptId());
                    RealtimeNotifier.notifyOrderCreated("receipt", r.getReceiptId());
                    back = "/admin/receipts?view=" + r.getReceiptId();
                }
                case "addDetail" -> {
                    service.addDetail(id, XParam.getInt(req, "productId", -1), XParam.getInt(req, "quantity", 0));
                    XAttr.flashSuccess(req, "Đã thêm sản phẩm vào phiếu");
                    RealtimeNotifier.notifyDetailChanged("receipt", id, XAuth.currentUser(req).getFullName());
                }
                case "removeDetail" -> {
                    service.removeDetail(id, XParam.getInt(req, "productId", -1));
                    RealtimeNotifier.notifyDetailChanged("receipt", id, XAuth.currentUser(req).getFullName());
                }
                case "approve" -> {
                    if (!XAuth.currentUser(req).isAdmin())
                        throw new IllegalStateException("Chỉ Quản lý mới được duyệt phiếu nhập");
                    service.approve(id, XAuth.currentUser(req).getUserId());
                    XAttr.flashSuccess(req, "Đã duyệt phiếu nhập — hàng đã vào kho");
                    // Realtime: notify the staff member watching this receipt.
                    RealtimeNotifier.notifyApproved("receipt", id, XAuth.currentUser(req).getFullName());
                }
                case "delete" -> {
                    service.delete(id);
                    XAttr.flashSuccess(req, "Đã xóa phiếu nhập");
                    back = "/admin/receipts";
                }
                default -> throw new IllegalStateException("Hành động không hợp lệ");
            }
        } catch (IllegalStateException e) {
            XAttr.flashError(req, e.getMessage());
        }
        XPath.redirect(req, resp, back);
    }
}
