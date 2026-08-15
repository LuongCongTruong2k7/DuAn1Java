package whm.service;

import whm.dao.UserDAO;
import whm.dao.UserDAOImpl;
import whm.entity.User;
import whm.util.XAuth;
import whm.util.XStr;
import java.security.SecureRandom;

public class AuthServiceImpl implements AuthService {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public User login(String username, String password) {
        if (username == null || password == null)
            return null;
        User u = userDAO.findByUsername(username.trim());
        if (u == null || Boolean.FALSE.equals(u.getIsActive()))
            return null;
        return XAuth.matches(password, u.getPassword()) ? u : null;
    }

    @Override
    public boolean changePassword(Integer userId, String oldPassword, String newPassword) {
        User u = userDAO.findById(userId);
        if (u == null || !XAuth.matches(oldPassword, u.getPassword()))
            return false;
        u.setPassword(XAuth.hash(newPassword));
        userDAO.update(u);
        return true;
    }

    @Override
    public User findByEmail(String email) {
        return XStr.isBlank(email) ? null : userDAO.findByEmail(email.trim());
    }

    @Override
    public String resetPassword(String email) {
        User u = findByEmail(email);
        if (u == null)
            return null;
        String newPw = randomPassword();
        u.setPassword(XAuth.hash(newPw));
        userDAO.update(u);
        return newPw;
    }

    private String randomPassword() {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789";
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(10);
        for (int i = 0; i < 10; i++)
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        return sb.toString();
    }
}
