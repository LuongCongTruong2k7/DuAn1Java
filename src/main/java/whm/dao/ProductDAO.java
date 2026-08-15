package whm.dao;

import whm.entity.Product;
import java.util.List;

public interface ProductDAO {
    List<Product> findAll();
    List<Product> findActive();
    List<Product> search(String keyword);
    long countFiltered(String keyword, Integer categoryId, String stock, Boolean status);
    List<Product> findFiltered(String keyword, Integer categoryId, String stock, Boolean status, String sort, int offset, int limit);
    Product findById(Integer id);
    Product create(Product p);
    Product update(Product p);
    void deleteById(Integer id);
}
