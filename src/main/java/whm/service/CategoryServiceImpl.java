package whm.service;

import whm.dao.CategoryDAO;
import whm.dao.CategoryDAOImpl;
import whm.entity.Category;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {
    private final CategoryDAO dao = new CategoryDAOImpl();

    @Override
    public List<Category> findAll() {
        return dao.findAll();
    }

    @Override
    public Category findById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public void delete(Integer id) {
        dao.deleteById(id);
    }

    @Override
    public void save(Category c) {
        if (c.getCategoryId() == null)
            dao.create(c);
        else
            dao.update(c);
    }
}
