package whm.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJpa {
	private static EntityManagerFactory factory;
	public static EntityManager creatEntityManager() {
		if (factory == null & !factory.isOpen()) {
			factory = Persistence.createEntityManagerFactory("WarehouseManagement");
		}
		return factory.createEntityManager();
	}
}
