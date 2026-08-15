package whm.service;

import whm.entity.Category;
import java.util.List;

public interface CategoryService {
    List<Category> findAll();

    Category findById(Integer id);

    void save(Category c);

    void delete(Integer id);
}
