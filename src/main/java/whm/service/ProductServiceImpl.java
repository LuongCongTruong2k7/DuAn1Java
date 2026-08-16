package whm.service;

import whm.dao.ProductDAO;
import whm.dao.ProductDAOImpl;
import whm.entity.Product;
import java.util.List;

public class ProductServiceImpl implements ProductService {
    private final ProductDAO dao = new ProductDAOImpl();

    @Override
    public List<Product> findAll() {
        return dao.findAll();
    }

    @Override
    public List<Product> findActive() {
        return dao.findActive();
    }

    @Override
    public List<Product> search(String kw) {
        return dao.search(kw == null ? "" : kw);
    }
    
    public long countFiltered(String keyword, Integer categoryId, String stock, Boolean status) {
        return dao.countFiltered(keyword, categoryId, stock, status);
    }

    @Override
    public List<Product> findFiltered(String keyword, Integer categoryId, String stock, Boolean status,
                                      String sort, int offset, int limit) {
        return dao.findFiltered(keyword, categoryId, stock, status, sort, offset, limit);
    }

    @Override
    public Product findById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public Product findByName(String name) {
        return dao.findByName(name);
    }

    @Override
    public void save(Product p) {
        if (p.getProductId() == null)
            dao.create(p);
        else
            dao.update(p);
    }

    @Override
    public void deactivate(Integer id) {
        Product p = dao.findById(id);
        if (p != null) {
            p.setIsActive(false);
            dao.update(p);
        }
    }
    
    @Override
    public void activate(Integer id) {
    	Product p = dao.findById(id);
		if (p != null) {
			p.setIsActive(true);
			dao.update(p);
		}
    }
}
