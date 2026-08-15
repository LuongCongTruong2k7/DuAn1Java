package whm.dao;

import whm.entity.User;
import java.util.List;

public interface UserDAO {
    List<User> findAll();
    User findById(Integer id);
    User findByUsername(String username);
    User findByEmail(String email);
    User create(User u);
    User update(User u);
    void deleteById(Integer id);
}
