package whm.dao;

import jakarta.persistence.EntityManager;
import whm.report.FlowReport;
import whm.report.StockReport;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ReportDAOImpl implements ReportDAO {

    private static final String RECEIVED =
        "SELECT d.product.productId, SUM(d.quantity) FROM ReceiptDetail d " +
        "WHERE d.receipt.status = 'APPROVED' %s GROUP BY d.product.productId";
    private static final String ISSUED =
        "SELECT d.product.productId, SUM(d.quantity) FROM IssueDetail d " +
        "WHERE d.issue.status = 'APPROVED' %s GROUP BY d.product.productId";

    @Override
    public List<StockReport> stock() {
        try (EntityManager em = XJpa.em()) {
            Map<Integer, StockReport> map = baseMap(em);
            apply(em, String.format(RECEIVED, ""), null, null, map, true);
            apply(em, String.format(ISSUED, ""), null, null, map, false);
            return List.copyOf(map.values());
        }
    }

    @Override
    public List<FlowReport> flow(Date from, Date to) {
        try (EntityManager em = XJpa.em()) {
            Map<Integer, StockReport> map = baseMap(em);
            String cond = " AND %s.approvalDate BETWEEN :f AND :t ";
            apply(em, String.format(RECEIVED, String.format(cond, "d.receipt")), from, to, map, true);
            apply(em, String.format(ISSUED, String.format(cond, "d.issue")), from, to, map, false);
            return map.values().stream()
                      .map(s -> new FlowReport(s.getProductId(), s.getProductName(), s.getUnit(),
                                               s.getReceived(), s.getIssued()))
                      .toList();
        }
    }

    private Map<Integer, StockReport> baseMap(EntityManager em) {
        Map<Integer, StockReport> map = new LinkedHashMap<>();
        em.createQuery("FROM whm.entity.Product p ORDER BY p.productName", whm.entity.Product.class)
          .getResultList()
          .forEach(p -> map.put(p.getProductId(),
                  new StockReport(p.getProductId(), p.getProductName(),
                                  p.getUnitOfMeasurement(), p.getMinStock(), p.getMaxStock())));
        return map;
    }

    @SuppressWarnings("unchecked")
    private void apply(EntityManager em, String jpql, Date from, Date to,
                       Map<Integer, StockReport> map, boolean received) {
        var q = em.createQuery(jpql);
        if (from != null) q.setParameter("f", from).setParameter("t", to);
        for (Object[] row : (List<Object[]>) q.getResultList()) {
            StockReport s = map.get((Integer) row[0]);
            if (s == null) continue;
            long qty = ((Number) row[1]).longValue();
            if (received) s.setReceived(qty); else s.setIssued(qty);
        }
    }
}
