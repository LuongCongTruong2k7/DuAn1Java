package whm.util;

import jakarta.servlet.http.HttpServletRequest;
import whm.dao.UserDAOImpl;
import whm.entity.User;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Objects;

/** Session helpers + password hashing (SHA-256 hex). */
public final class XAuth {
    public static final String SESSION_USER = "authUser";

    private XAuth() {
    }

    public static String hash(String raw) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(raw.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes)
                sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(e);
        }
    }

    public static boolean matches(String raw, String hashed) {
        return raw != null && hashed != null && hash(raw).equalsIgnoreCase(hashed);
    }

    public static User currentUser(HttpServletRequest req) {
        return (User) req.getSession().getAttribute(SESSION_USER);
    }

    public static void signIn(HttpServletRequest req, User user) {
        req.getSession().setAttribute(SESSION_USER, user);
    }

    /**
     * Re-read the signed-in user from the DB each request so profile edits,
     * role changes, and deactivation take effect immediately in this session.
     * Returns {@code null} — the caller (AuthFilter) signs out — when the
     * account no longer exists, was disabled, or its credentials
     * (username/password/role/email) were changed by someone else.
     */
    public static User refreshCurrentUser(HttpServletRequest req) {
        User current = currentUser(req);
        if (current == null)
            return null;
        User fresh = new UserDAOImpl().findById(current.getUserId());
        if (fresh == null || Boolean.FALSE.equals(fresh.getIsActive()))
            return null;
        // Credentials changed by an admin → force logout on the next request.
        // Plain profile fields (fullName) just refresh the session user,
        // which is what makes them realtime.
        if (!credentialsEqual(current, fresh))
            return null;
        req.getSession().setAttribute(SESSION_USER, fresh);
        return fresh;
    }

    private static boolean credentialsEqual(User a, User b) {
        return Objects.equals(a.getUsername(), b.getUsername())
                && Objects.equals(a.getPassword(), b.getPassword())
                && Objects.equals(a.getEmail(), b.getEmail())
                && Objects.equals(roleId(a), roleId(b));
    }

    private static Integer roleId(User u) {
        return u.getRole() == null ? null : u.getRole().getRoleId();
    }

    public static void signOut(HttpServletRequest req) {
        req.getSession().invalidate();
    }
}
