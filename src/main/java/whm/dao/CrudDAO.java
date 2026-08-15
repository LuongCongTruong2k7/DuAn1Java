package whm.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;
import java.util.function.Function;

/** Generic CRUD base class for all DAO implementations. */
public abstract class CrudDAO<E, K> {
    protected final Class<E> entityClass;

    protected CrudDAO(Class<E> entityClass) {
        this.entityClass = entityClass;
    }

    public List<E> findAll() {
        try (EntityManager em = XJpa.em()) {
            return em.createQuery("FROM " + entityClass.getSimpleName(), entityClass).getResultList();
        }
    }

    public E findById(K id) {
        try (EntityManager em = XJpa.em()) {
            return em.find(entityClass, id);
        }
    }

    public E create(E entity) {
        return inTransaction(em -> { em.persist(entity); 
            return entity; 
        });
    }

    public E update(E entity) {
        return inTransaction(em -> em.merge(entity));
    }

    public void deleteById(K id) {
        inTransaction(em -> {
            E e = em.find(entityClass, id);
            if (e != null) em.remove(e);
            return null;
        });
    }

    protected <R> R inTransaction(Function<EntityManager, R> work) {
        EntityManager em = XJpa.em();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            R result = work.apply(em);
            tx.commit();
            return result;
        } catch (RuntimeException ex) {
            if (tx.isActive()) tx.rollback();
            throw ex;
        } finally {
            em.close();
        }
    }
}
