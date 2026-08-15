package whm.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import whm.entity.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl extends CrudDAO<Product, Integer> implements ProductDAO {
    public ProductDAOImpl() { super(Product.class); }

    @Override
    public List<Product> findActive() {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery("FROM Product p WHERE p.isActive = true ORDER BY p.productName", Product.class)
                     .getResultList();
        }
    }

    @Override
    public List<Product> search(String keyword) {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery(
                    "FROM Product p WHERE lower(p.productName) LIKE :kw ORDER BY p.productName", Product.class)
                     .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                     .getResultList();
        }
    }
    
    @Override
    public long countFiltered(String keyword, Integer categoryId, String stock, Boolean status) {
        try (EntityManager em = XJpa.em()) {
            TypedQuery<Long> q = em.createQuery(
                    "SELECT COUNT(p) FROM Product p" + whereClause(keyword, categoryId, stock, status), Long.class);
            bind(q, keyword, categoryId, status);
            return q.getSingleResult();
        }
    }

    @Override
    public List<Product> findFiltered(String keyword, Integer categoryId, String stock, Boolean status,
                                      String sort, int offset, int limit) {
        try (EntityManager em = XJpa.em()) {
            TypedQuery<Product> q = em.createQuery(
                    "FROM Product p" + whereClause(keyword, categoryId, stock, status)
                            + orderClause(sort), Product.class);
            bind(q, keyword, categoryId, status);
            q.setFirstResult(offset).setMaxResults(limit);
            return q.getResultList();
        }
    }

    /** Dynamic WHERE conditions — every value is bound as a query parameter (SQL-injection safe). */
    private String whereClause(String keyword, Integer categoryId, String stock, Boolean status) {
        List<String> conds = new ArrayList<>();
        if (keyword != null && !keyword.isBlank())
            conds.add("lower(p.productName) LIKE :kw");
        if (categoryId != null)
            conds.add("p.category.categoryId = :cid");
        if ("in".equals(stock))
            conds.add("(SELECT COALESCE(SUM(r.quantity), 0) FROM ReceiptDetail r "
                    + "WHERE r.product = p AND r.receipt.status = 'APPROVED') > "
                    + "(SELECT COALESCE(SUM(i.quantity), 0) FROM IssueDetail i "
                    + "WHERE i.product = p AND i.issue.status = 'APPROVED')");
        if ("out".equals(stock))
            conds.add("(SELECT COALESCE(SUM(r.quantity), 0) FROM ReceiptDetail r "
                    + "WHERE r.product = p AND r.receipt.status = 'APPROVED') <= "
                    + "(SELECT COALESCE(SUM(i.quantity), 0) FROM IssueDetail i "
                    + "WHERE i.product = p AND i.issue.status = 'APPROVED')");
        if (status != null)
            conds.add("p.isActive = :act");
        return conds.isEmpty() ? "" : " WHERE " + String.join(" AND ", conds);
    }

	private String orderClause(String sort) {
        return switch (sort == null ? "" : sort) {
            case "nameDesc" -> " ORDER BY p.productName DESC";
            case "newest"   -> " ORDER BY p.productId DESC";
            case "oldest"   -> " ORDER BY p.productId ASC";
            default         -> " ORDER BY p.productName ASC";
        };
    }

    private void bind(Query q, String keyword, Integer categoryId, Boolean status) {
        if (keyword != null && !keyword.isBlank())
            q.setParameter("kw", "%" + keyword.toLowerCase() + "%");
        if (categoryId != null)
            q.setParameter("cid", categoryId);
        if (status != null)
            q.setParameter("act", status);
    }
}
