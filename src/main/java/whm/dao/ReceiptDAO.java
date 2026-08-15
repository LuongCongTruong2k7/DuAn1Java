package whm.dao;

import whm.entity.Receipt;
import java.util.List;

public interface ReceiptDAO {
    List<Receipt> findAll();
    Receipt findById(Integer id);
    Receipt create(Receipt r);
    Receipt update(Receipt r);
    void deleteById(Integer id);
    long countByStatus(String status);
}
