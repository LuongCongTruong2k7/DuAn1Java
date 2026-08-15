package whm.service;

import whm.entity.User;

public interface AuthService {
    /**
     * @return user when credentials are valid and account active, otherwise null
     */
    User login(String username, String password);

    boolean changePassword(Integer userId, String oldPassword, String newPassword);

    User findByEmail(String email);

    /**
     * Generate a random password and persist it. @return the new plain-text
     * password
     */
    String resetPassword(String email);
}
