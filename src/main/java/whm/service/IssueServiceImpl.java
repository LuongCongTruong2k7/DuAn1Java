package whm.service;

import whm.dao.*;
import whm.entity.*;
import whm.report.StockReport;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class IssueServiceImpl implements IssueService {
    private final IssueDAO dao = new IssueDAOImpl();
    private final ProductDAO productDAO = new ProductDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();
    private final ReportDAO reportDAO = new ReportDAOImpl();

    @Override
    public List<Issue> findAll() {
        return dao.findAll();
    }

    @Override
    public Issue findById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public long countPending() {
        return dao.countByStatus(Issue.PENDING);
    }

    @Override
    public Issue create(String recipient, String remarks, Integer createdByUserId) {
        Issue i = new Issue();
        i.setRecipient(recipient);
        i.setRemarks(remarks);
        i.setCreatedBy(userDAO.findById(createdByUserId));
        return dao.create(i);
    }

    @Override
    public void addDetail(Integer issueId, Integer productId, int quantity) {
        if (quantity <= 0)
            throw new IllegalStateException("Số lượng phải lớn hơn 0");
        Issue i = requirePending(issueId);
        Product p = productDAO.findById(productId);
        if (p == null)
            throw new IllegalStateException("Sản phẩm không tồn tại");
        i.getDetails().stream()
                .filter(d -> d.getProduct().getProductId().equals(productId)).findFirst()
                .ifPresentOrElse(
                        d -> d.setQuantity(d.getQuantity() + quantity),
                        () -> i.getDetails().add(new IssueDetail(i, p, quantity)));
        dao.update(i);
    }

    @Override
    public void removeDetail(Integer issueId, Integer productId) {
        Issue i = requirePending(issueId);
        i.getDetails().removeIf(d -> d.getProduct().getProductId().equals(productId));
        dao.update(i);
    }

    @Override
    public void approve(Integer issueId, Integer approvedByUserId) {
        Issue i = requirePending(issueId);
        if (i.getDetails().isEmpty())
            throw new IllegalStateException("Phiếu xuất chưa có sản phẩm nào");

        Map<Integer, Long> stock = reportDAO.stock().stream()
                .collect(Collectors.toMap(StockReport::getProductId, StockReport::getStock));
        for (IssueDetail d : i.getDetails()) {
            long available = stock.getOrDefault(d.getProduct().getProductId(), 0L);
            if (d.getQuantity() > available)
                throw new IllegalStateException("Không đủ tồn kho cho \"" + d.getProduct().getProductName()
                        + "\" (tồn: " + available + ", cần xuất: " + d.getQuantity() + ")");
        }
        i.setStatus(Issue.APPROVED);
        i.setApprovedBy(userDAO.findById(approvedByUserId));
        i.setApprovalDate(new Date());
        dao.update(i);
    }

    @Override
    public void delete(Integer issueId) {
        requirePending(issueId);
        dao.deleteById(issueId);
    }

    private Issue requirePending(Integer id) {
        Issue i = dao.findById(id);
        if (i == null)
            throw new IllegalStateException("Phiếu xuất không tồn tại");
        if (!i.isPending())
            throw new IllegalStateException("Phiếu đã duyệt, không thể thay đổi");
        return i;
    }
}
