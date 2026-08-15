package whm.dao;

import jakarta.persistence.EntityManager;
import whm.entity.Receipt;
import java.util.List;

public class ReceiptDAOImpl extends CrudDAO<Receipt, Integer> implements ReceiptDAO {
    public ReceiptDAOImpl() { super(Receipt.class); }

    @Override
    public List<Receipt> findAll() {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery("SELECT DISTINCT r FROM Receipt r ORDER BY r.orderDate DESC", Receipt.class)
                     .getResultList();
        }
    }

    @Override
    public long countByStatus(String status) {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery("SELECT COUNT(r) FROM Receipt r WHERE r.status = :st", Long.class)
                     .setParameter("st", status).getSingleResult();
        }
    }
}
