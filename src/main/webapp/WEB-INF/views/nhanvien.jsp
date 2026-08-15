<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <c:set var="pageTitle" value="Nhân viên" scope="request" />
      <c:set var="wsChannels" value="broadcast" />
      <%@ include file="_head.jspf" %>

        <div class="panel">
          <form method="post" action="${pageContext.request.contextPath}/admin/users">
            <input type="hidden" name="id" value="${editing.userId}">
            <div class="form-grid">
              <div><label>Tên đăng nhập</label>
                <input type="text" name="username" value="${editing.username}" required>
              </div>
              <div><label>Họ tên</label>
                <input type="text" name="fullName" value="${editing.fullName}">
              </div>
              <div><label>Email</label>
                <input type="email" name="email" value="${editing.email}">
              </div>
              <div><label>Vai trò</label>
                <select name="roleId">
                  <c:forEach var="r" items="${roles}">
                    <option value="${r.roleId}" ${editing.role.roleId==r.roleId ? 'selected' : '' }>${r.roleName}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div><label>Mật khẩu ${empty editing ? '' : '(để trống nếu không đổi)'}</label>
                <input type="password" name="password" ${empty editing ? 'required' : '' }>
              </div>
            </div>
            <div class="actions">
              <c:if test="${not empty editing}">
                <label><input type="checkbox" name="isActive" ${editing.isActive ? 'checked' : '' }> Đang hoạt
                  động</label>
              </c:if>
              <button class="btn" type="submit">${empty editing ? 'Thêm nhân viên' : 'Cập nhật'}</button>
              <c:if test="${not empty editing}">
                <a class="btn gray" href="${pageContext.request.contextPath}/admin/users">Hủy</a>
              </c:if>
            </div>
          </form>
        </div>

        <table>
          <tr>
            <th style="width:60px">ID</th>
            <th>Tên đăng nhập</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
            <th style="width:190px"></th>
          </tr>
          <c:forEach var="u" items="${users}">
            <tr>
              <td>${u.userId}</td>
              <td>${u.username}</td>
              <td>${u.fullName}</td>
              <td>${u.email}</td>
              <td>${u.role.roleName}</td>
              <td><span class="badge ${u.isActive ? 'approved' : 'off'}">${u.isActive ? 'Hoạt động' : 'Khóa'}</span>
              </td>
              <td class="r">
                <a class="btn sm gray" href="?edit=${u.userId}">Sửa</a>
                <c:if test="${u.isActive && u.userId != currentUser.userId}">
                  <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/users"
                    onsubmit="return confirm('Vô hiệu hóa tài khoản này?')">
                    <input type="hidden" name="action" value="delete"><input type="hidden" name="id"
                      value="${u.userId}">
                    <button class="btn sm red" type="submit">Vô hiệu hóa</button>
                  </form>
                </c:if>
                <c:if test="${not u.isActive}">
                  <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/users"
                    onsubmit="return confirm('Kích hoạt lại tài khoản này?')">
                    <input type="hidden" name="action" value="activate"><input type="hidden" name="id"
                      value="${u.userId}">
                    <button class="btn sm green" type="submit">Kích hoạt</button>
                  </form>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </table>
        <%@ include file="_foot.jspf" %>