package whm.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.service.*;
import whm.util.XPath;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet({ "", "/dashboard" })
public class HomeServlet extends HttpServlet {
    private final ProductService productService = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();
    private final UserService userService = new UserServiceImpl();
    private final ReceiptService receiptService = new ReceiptServiceImpl();
    private final IssueService issueService = new IssueServiceImpl();
    private final ReportService reportService = new ReportServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("productCount", productService.findActive().size());
        req.setAttribute("categoryCount", categoryService.findAll().size());
        req.setAttribute("userCount", userService.findAll().size());
        req.setAttribute("pendingReceipts", receiptService.countPending());
        req.setAttribute("pendingIssues", issueService.countPending());
        req.setAttribute("lowStock", reportService.lowStock());
        req.setAttribute("active", "dashboard");
        XPath.view(req, resp, "dashboard");
    }
}
