package whm.service;

import whm.entity.User;
import java.util.List;

public interface UserService {
    List<User> findAll();

    User findById(Integer id);

    User findByUsername(String username);

    /** @throws IllegalStateException when username already exists */
    void save(User u, String rawPassword);

    void deactivate(Integer id);

    void activate(Integer id);
}
