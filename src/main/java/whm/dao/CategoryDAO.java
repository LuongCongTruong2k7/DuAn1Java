package whm.dao;

import whm.entity.Category;
import java.util.List;

public interface CategoryDAO {
    List<Category> findAll();
    Category findById(Integer id);
    Category findByName(String name);
    Category create(Category c);
    Category update(Category c);
    void deleteById(Integer id);
}
