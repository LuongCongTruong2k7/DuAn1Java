package whm.dao;

import whm.entity.Category;

public class CategoryDAOImpl extends CrudDAO<Category, Integer> implements CategoryDAO {
    public CategoryDAOImpl() {
        super(Category.class); 
    }
}
