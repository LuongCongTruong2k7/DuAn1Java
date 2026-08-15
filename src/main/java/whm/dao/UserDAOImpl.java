package whm.dao;

import jakarta.persistence.EntityManager;
import whm.entity.User;

public class UserDAOImpl extends CrudDAO<User, Integer> implements UserDAO {
    public UserDAOImpl() { super(User.class); }

    @Override
    public User findByUsername(String username) {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery("FROM User u WHERE u.username = :un", User.class)
                     .setParameter("un", username)
                     .getResultStream().findFirst().orElse(null);
        }
    }

    @Override
    public User findByEmail(String email) {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery("FROM User u WHERE u.email = :em", User.class)
                     .setParameter("em", email)
                     .getResultStream().findFirst().orElse(null);
        }
    }
}
