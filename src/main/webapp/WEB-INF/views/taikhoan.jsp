<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <c:set var="pageTitle" value="Tài khoản" scope="request" />
      <%@ include file="_head.jspf" %>

        <div class="panel profile-panel">
          <div class="profile-avatar">
            <div class="avatar">${fn:toUpperCase(fn:substring(empty currentUser.fullName ? currentUser.username :
              currentUser.fullName,0,1))}</div>
            <div class="name">${empty currentUser.fullName ? currentUser.username : currentUser.fullName}</div>
            <div class="role">${currentUser.role.roleName}</div>
            <div class="email">${currentUser.email}</div>
          </div>
          <div class="profile-info">
            <p><b>Tên đăng nhập:</b> ${currentUser.username}</p>
            <p><b>Họ tên:</b> ${currentUser.fullName}</p>
            <p><b>Email:</b> ${currentUser.email}</p>
            <p><b>Vai trò:</b> ${currentUser.role.roleName}</p>
          </div>
        </div>

        <h2>Đổi mật khẩu</h2>
        <div class="panel">
          <form method="post" action="${pageContext.request.contextPath}/account">
            <div class="form-grid">
              <div><label>Mật khẩu hiện tại</label><input type="password" name="oldPassword" required></div>
              <div><label>Mật khẩu mới</label><input type="password" name="newPassword" minlength="6" required></div>
              <div><label>Xác nhận mật khẩu mới</label><input type="password" name="confirmPassword" minlength="6"
                  required></div>
            </div>
            <div class="actions"><button class="btn" type="submit">Đổi mật khẩu</button></div>
          </form>
        </div>
        <%@ include file="_foot.jspf" %>