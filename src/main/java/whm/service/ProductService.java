package whm.service;

import whm.entity.Product;
import java.util.List;

public interface ProductService {
    List<Product> findAll();

    List<Product> findActive();

    List<Product> search(String keyword);
    
    long countFiltered(String keyword, Integer categoryId, String stock, Boolean status);

    List<Product> findFiltered(String keyword, Integer categoryId, String stock, Boolean status, String sort, int offset, int limit);

    Product findById(Integer id);

    void save(Product p);

    /** Soft-delete: mark inactive so history stays intact. */
    void deactivate(Integer id);
}
