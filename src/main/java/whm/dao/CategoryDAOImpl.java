package whm.dao;

import jakarta.persistence.EntityManager;
import whm.entity.Category;
import java.util.List;

public class CategoryDAOImpl extends CrudDAO<Category, Integer> implements CategoryDAO {
    public CategoryDAOImpl() {
        super(Category.class);
    }

    @Override
    public Category findByName(String name) {
        try (EntityManager em = XJpa.em()) {
            List<Category> r = em.createQuery(
                    "FROM Category c WHERE lower(c.categoryName) = lower(:name)", Category.class)
                    .setParameter("name", name)
                    .setMaxResults(1)
                    .getResultList();
            return r.isEmpty() ? null : r.get(0);
        }
    }
}