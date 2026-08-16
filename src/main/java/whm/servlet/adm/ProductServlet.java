package whm.servlet.adm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.entity.Product;
import whm.service.CategoryService;
import whm.service.CategoryServiceImpl;
import whm.service.ProductService;
import whm.service.ProductServiceImpl;
import whm.util.*;
import whm.ws.RealtimeNotifier;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@SuppressWarnings("serial")
@WebServlet("/admin/products")
public class ProductServlet extends HttpServlet {
	private static final int PAGE_SIZE = 10;
    private final ProductService service = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer editId = XParam.getInt(req, "edit", null);
        if (editId != null)
            req.setAttribute("editing", service.findById(editId));
        String keyword = XParam.getString(req, "keyword", "");
        Integer categoryId = XParam.getInt(req, "category", null);
        String stock = XParam.getString(req, "stock", "");
        String statusParam = XParam.getString(req, "status", "");
        String sort = XParam.getString(req, "sort", "");
        Boolean status = "active".equals(statusParam) ? Boolean.TRUE
                : "inactive".equals(statusParam) ? Boolean.FALSE : null;

        long total = service.countFiltered(keyword, categoryId, stock, status);
        int page = Math.max(1, XParam.getInt(req, "page", 1));
        int totalPages = (int) Math.max(1, (total + PAGE_SIZE - 1) / PAGE_SIZE);
        if (page > totalPages)
            page = totalPages;
        
        int offset = (page - 1) * PAGE_SIZE;
        req.setAttribute("products", service.findFiltered(keyword, categoryId, stock, status, sort, offset, PAGE_SIZE));
        req.setAttribute("keyword", keyword);
        req.setAttribute("category", categoryId);
        req.setAttribute("stock", stock);
        req.setAttribute("status", statusParam);
        req.setAttribute("sort", sort);
        req.setAttribute("page", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCount", total);
        req.setAttribute("baseQuery", baseQuery(keyword, categoryId, stock, statusParam, sort));
        req.setAttribute("categories", categoryService.findAll());
        req.setAttribute("readOnly", !XAuth.currentUser(req).isAdmin());
        req.setAttribute("active", "products");
        XPath.view(req, resp, "sanpham");
    }
    
    private String baseQuery(String keyword, Integer categoryid, String stock, String status, String sort) {
        StringBuilder sb = new StringBuilder();
        if (!keyword.isBlank())
            sb.append("&keyword=").append(URLEncoder.encode(keyword, StandardCharsets.UTF_8));
        if (categoryid != null)
            sb.append("&category=").append(categoryid);
        if (!stock.isBlank())
            sb.append("&stock=").append(stock);
        if (!status.isBlank())
            sb.append("&status=").append(status);
        if (!sort.isBlank())
            sb.append("&sort=").append(sort);
        return sb.toString();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = XParam.getString(req, "action", "save");
        String keyword = XParam.getString(req, "keyword", "");
        Integer categoryid = XParam.getInt(req, "category", null);
        String stock = XParam.getString(req, "stock", "");
        String statusParam = XParam.getString(req, "status", "");
        String sort = XParam.getString(req, "sort", "");
        String back = baseQuery(keyword, categoryid, stock, statusParam, sort);
        try {
            if ("delete".equals(action)) {
                service.deactivate(XParam.getInt(req, "id", -1));
                XAttr.flashSuccess(req, "Đã ngừng kinh doanh sản phẩm");
                RealtimeNotifier.notifyCatalogChanged(XAuth.currentUser(req).getFullName());
            } else if("activate".equals(action)) {
				service.activate(XParam.getInt(req, "id", -1));
				XAttr.flashSuccess(req, "Đã mở kinh doanh sản phẩm");
				RealtimeNotifier.notifyCatalogChanged(XAuth.currentUser(req).getFullName());
            	
            } else {
                String name = XParam.getString(req, "productName", "");
                String unit = XParam.getString(req, "unit", null);
                Integer categoryId = XParam.getInt(req, "categoryId", null);
                if (name.isEmpty() || categoryId == null)
                    throw new IllegalStateException("Tên sản phẩm và danh mục là bắt buộc");
                if (unit == null || unit.isBlank())
                    throw new IllegalStateException("Đơn vị tính không được để trống");
                Integer id = XParam.getInt(req, "id", null);
                Product existing = service.findByName(name);
                if (existing != null && (id == null || !existing.getProductId().equals(id)))
                    throw new IllegalStateException("Tên sản phẩm đã tồn tại");
                Product p = new Product();
                p.setProductId(id);
                p.setProductName(name);
                p.setUnitOfMeasurement(unit);
                p.setImageUrl(XParam.getString(req, "imageUrl", null));
                p.setCategory(categoryService.findById(categoryId));
                p.setMinStock(XParam.getInt(req, "minStock", 0));
                p.setMaxStock(XParam.getInt(req, "maxStock", 0));
                p.setIsActive(p.getProductId() == null || XParam.getBool(req, "isActive"));
                service.save(p);
                XAttr.flashSuccess(req, "Đã lưu sản phẩm");
                RealtimeNotifier.notifyCatalogChanged(XAuth.currentUser(req).getFullName());
            }
        } catch (IllegalStateException e) {
            XAttr.flashError(req, e.getMessage());
        }
        XPath.redirect(req, resp,
                back.isEmpty() ? "/admin/products" : "/admin/products?" + back.substring(1));
    }
}
