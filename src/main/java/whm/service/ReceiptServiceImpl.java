package whm.service;

import whm.dao.*;
import whm.entity.*;
import java.util.Date;
import java.util.List;

public class ReceiptServiceImpl implements ReceiptService {
    private final ReceiptDAO dao = new ReceiptDAOImpl();
    private final ProductDAO productDAO = new ProductDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public List<Receipt> findAll() {
        return dao.findAll();
    }

    @Override
    public Receipt findById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public long countPending() {
        return dao.countByStatus(Receipt.PENDING);
    }

    @Override
    public Receipt create(String supplierName, String remarks, Integer createdByUserId) {
        Receipt r = new Receipt();
        r.setSupplierName(supplierName);
        r.setRemarks(remarks);
        r.setCreatedBy(userDAO.findById(createdByUserId));
        return dao.create(r);
    }

    @Override
    public void addDetail(Integer receiptId, Integer productId, int quantity) {
        if (quantity <= 0)
            throw new IllegalStateException("Số lượng phải lớn hơn 0");
        Receipt r = requirePending(receiptId);
        Product p = productDAO.findById(productId);
        if (p == null)
            throw new IllegalStateException("Sản phẩm không tồn tại");
        r.getDetails().stream()
                .filter(d -> d.getProduct().getProductId().equals(productId)).findFirst()
                .ifPresentOrElse(
                        d -> d.setQuantity(d.getQuantity() + quantity),
                        () -> r.getDetails().add(new ReceiptDetail(r, p, quantity)));
        dao.update(r);
    }

    @Override
    public void removeDetail(Integer receiptId, Integer productId) {
        Receipt r = requirePending(receiptId);
        r.getDetails().removeIf(d -> d.getProduct().getProductId().equals(productId));
        dao.update(r);
    }

    @Override
    public void approve(Integer receiptId, Integer approvedByUserId) {
        Receipt r = requirePending(receiptId);
        if (r.getDetails().isEmpty())
            throw new IllegalStateException("Phiếu nhập chưa có sản phẩm nào");
        r.setStatus(Receipt.APPROVED);
        r.setApprovedBy(userDAO.findById(approvedByUserId));
        r.setApprovalDate(new Date());
        dao.update(r);
    }

    @Override
    public void delete(Integer receiptId) {
        requirePending(receiptId);
        dao.deleteById(receiptId);
    }

    private Receipt requirePending(Integer id) {
        Receipt r = dao.findById(id);
        if (r == null)
            throw new IllegalStateException("Phiếu nhập không tồn tại");
        if (!r.isPending())
            throw new IllegalStateException("Phiếu đã duyệt, không thể thay đổi");
        return r;
    }
}
