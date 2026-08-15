package whm.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public final class XJpa {
    private static EntityManagerFactory emf;

    private XJpa() {}

    public static synchronized EntityManagerFactory getFactory() {
        if (emf == null || !emf.isOpen()) {
            emf = Persistence.createEntityManagerFactory("WarehouseManagementBV");
        }
        return emf;
    }

    public static EntityManager em() {
        return getFactory().createEntityManager();
    }

    public static synchronized void shutdown() {
        if (emf != null && emf.isOpen()) emf.close();
    }
}
