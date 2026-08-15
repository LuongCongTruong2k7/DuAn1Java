package whm.servlet.adm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import whm.dao.*;
import whm.entity.Role;
import whm.entity.User;
import whm.service.UserService;
import whm.service.UserServiceImpl;
import whm.util.*;
import whm.ws.RealtimeNotifier;
import java.io.IOException;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/admin/users")
public class UserServlet extends HttpServlet {
    private final UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer editId = XParam.getInt(req, "edit", null);
        if (editId != null)
        req.setAttribute("editing", service.findById(editId));
        req.setAttribute("users", service.findAll());
        req.setAttribute("roles", findRoles());
        req.setAttribute("active", "users");
        XPath.view(req, resp, "nhanvien");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = XParam.getString(req, "action", "save");
        try {
            if ("delete".equals(action)) {
                Integer id = XParam.getInt(req, "id", -1);
                if (id.equals(XAuth.currentUser(req).getUserId()))
                    throw new IllegalStateException("Không thể vô hiệu hóa chính mình");
                service.deactivate(id);
                XAttr.flashSuccess(req, "Đã vô hiệu hóa nhân viên");
                RealtimeNotifier.notifyUsersChanged(XAuth.currentUser(req).getFullName());
            } else if ("activate".equals(action)) {
                service.activate(XParam.getInt(req, "id", -1));
                XAttr.flashSuccess(req, "Đã mở khóa nhân viên");
                RealtimeNotifier.notifyUsersChanged(XAuth.currentUser(req).getFullName());

            } else {
                User u = new User();
                u.setUserId(XParam.getInt(req, "id", null));
                u.setUsername(XParam.getString(req, "username", ""));
                u.setFullName(XParam.getString(req, "fullName", null));
                u.setEmail(XParam.getString(req, "email", null));
                u.setIsActive(u.getUserId() == null || XParam.getBool(req, "isActive"));
                Role r = new Role();
                r.setRoleId(XParam.getInt(req, "roleId", 2));
                u.setRole(r);
                String rawPassword = XParam.getString(req, "password", "");
                if (u.getUsername().isEmpty())
                    throw new IllegalStateException("Tên đăng nhập là bắt buộc");
                if (u.getUserId() == null && rawPassword.length() < 6)
                    throw new IllegalStateException("Mật khẩu phải từ 6 ký tự");
                service.save(u, rawPassword);
                XAttr.flashSuccess(req, "Đã lưu nhân viên");
                RealtimeNotifier.notifyUsersChanged(XAuth.currentUser(req).getFullName());
            }
        } catch (IllegalStateException e) {
            XAttr.flashError(req, e.getMessage());
        }
        XPath.redirect(req, resp, "/admin/users");
    }

    private List<Role> findRoles() {
        try (var em = XJpa.em()) {
            return em.createQuery("FROM Role", Role.class).getResultList();
        }
    }
}
