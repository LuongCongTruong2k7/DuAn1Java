package whm.dao;

import jakarta.persistence.EntityManager;
import whm.entity.Issue;
import java.util.List;

public class IssueDAOImpl extends CrudDAO<Issue, Integer> implements IssueDAO {
    public IssueDAOImpl() { super(Issue.class); }

    @Override
    public List<Issue> findAll() {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery("SELECT DISTINCT i FROM Issue i ORDER BY i.orderDate DESC", Issue.class)
                     .getResultList();
        }
    }

    @Override
    public long countByStatus(String status) {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery("SELECT COUNT(i) FROM Issue i WHERE i.status = :st", Long.class)
                     .setParameter("st", status).getSingleResult();
        }
    }
}
