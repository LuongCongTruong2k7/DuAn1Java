package whm.servlet.adm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.entity.Category;
import whm.service.CategoryService;
import whm.service.CategoryServiceImpl;
import whm.util.*;
import whm.ws.RealtimeNotifier;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/admin/categories")
public class CategoryServlet extends HttpServlet {
    private final CategoryService service = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer editId = XParam.getInt(req, "edit", null);
        if (editId != null)
            req.setAttribute("editing", service.findById(editId));
        req.setAttribute("categories", service.findAll());
        req.setAttribute("readOnly", !XAuth.currentUser(req).isAdmin());
        req.setAttribute("active", "categories");
        XPath.view(req, resp, "danhmuc");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = XParam.getString(req, "action", "save");
        try {
            switch (action) {
                case "delete" -> {
                    service.delete(XParam.getInt(req, "id", -1));
                    XAttr.flashSuccess(req, "Đã xóa danh mục");
                    RealtimeNotifier.notifyCatalogChanged(XAuth.currentUser(req).getFullName());
                }
                default -> {
                    String name = XParam.getString(req, "categoryName", "");
                    if (name.isEmpty())
                        throw new IllegalStateException("Tên danh mục không được để trống");
                    Category c = new Category();
                    c.setCategoryId(XParam.getInt(req, "id", null));
                    c.setCategoryName(name);
                    service.save(c);
                    XAttr.flashSuccess(req, "Đã lưu danh mục");
                    RealtimeNotifier.notifyCatalogChanged(XAuth.currentUser(req).getFullName());
                }
            }
        } catch (IllegalStateException e) {
            XAttr.flashError(req, e.getMessage());
        } catch (RuntimeException e) {
            XAttr.flashError(req, "Không thể xóa: danh mục đang được sử dụng bởi sản phẩm");
        }
        XPath.redirect(req, resp, "/admin/categories");
    }
}
