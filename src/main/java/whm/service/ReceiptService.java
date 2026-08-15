package whm.service;

import whm.entity.Receipt;
import java.util.List;

public interface ReceiptService {
    List<Receipt> findAll();

    Receipt findById(Integer id);

    Receipt create(String supplierName, String remarks, Integer createdByUserId);

    void addDetail(Integer receiptId, Integer productId, int quantity);

    void removeDetail(Integer receiptId, Integer productId);

    /** @throws IllegalStateException when receipt is empty or already approved */
    void approve(Integer receiptId, Integer approvedByUserId);

    /** Only pending receipts can be deleted. */
    void delete(Integer receiptId);

    long countPending();
}
