package whm.service;

import whm.dao.UserDAO;
import whm.dao.UserDAOImpl;
import whm.entity.User;
import whm.util.XAuth;
import java.util.List;

public class UserServiceImpl implements UserService {
    private final UserDAO dao = new UserDAOImpl();

    @Override
    public List<User> findAll() {
        return dao.findAll();
    }

    @Override
    public User findById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public User findByUsername(String un) {
        return dao.findByUsername(un);
    }

    @Override
    public void save(User u, String rawPassword) {
        User existing = dao.findByUsername(u.getUsername());
        if (u.getUserId() == null) {
            if (existing != null)
                throw new IllegalStateException("Tên đăng nhập đã tồn tại");
            u.setPassword(XAuth.hash(rawPassword));
            dao.create(u);
        } else {
            if (existing != null && !existing.getUserId().equals(u.getUserId()))
                throw new IllegalStateException("Tên đăng nhập đã tồn tại");
            User db = dao.findById(u.getUserId());
            u.setPassword(rawPassword == null || rawPassword.isBlank()
                    ? db.getPassword()
                    : XAuth.hash(rawPassword));
            dao.update(u);
        }
    }

    @Override
    public void deactivate(Integer id) {
        User u = dao.findById(id);
        if (u != null) {
            u.setIsActive(false);
            dao.update(u);
        }
    }

    @Override
    public void activate(Integer id) {
        User u = dao.findById(id);
        if (u != null) {
            u.setIsActive(true);
            dao.update(u);
        }
    }
}
