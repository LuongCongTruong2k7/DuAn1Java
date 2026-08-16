<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Nhân viên" scope="request"/>
<c:set var="wsChannels" value="broadcast"/>
<%@ include file="_head.jspf" %>

<div class="flex-1 overflow-y-auto p-page-padding-x py-page-padding-y">
  <div class="max-w-7xl mx-auto space-y-margin-lg">

    <div class="bg-white rounded-xl border border-border-light shadow-sm p-6 max-w-2xl">
      <h3 class="text-section-header font-section-header text-on-surface mb-4 flex items-center gap-2">
        <span class="material-symbols-outlined text-secondary text-lg">${empty editing ? 'person_add' : 'edit_note'}</span>
        ${empty editing ? 'Thêm nhân viên' : 'Cập nhật nhân viên'}
      </h3>
      <form method="post" action="${pageContext.request.contextPath}/admin/users">
        <input type="hidden" name="id" value="${editing.userId}">
        <div class="grid sm:grid-cols-2 gap-4">
          <div>
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Tên đăng nhập</label>
            <input type="text" name="username" value="${editing.username}" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
          </div>
          <div>
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Họ tên</label>
            <input type="text" name="fullName" value="${editing.fullName}" class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
          </div>
          <div>
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Email</label>
            <input type="email" name="email" value="${editing.email}" class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
          </div>
          <div>
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Vai trò</label>
            <select name="roleId" class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
              <c:forEach var="r" items="${roles}">
                <option value="${r.roleId}" ${editing.role.roleId==r.roleId ? 'selected' : '' }>${r.roleName}</option>
              </c:forEach>
            </select>
          </div>
          <div class="sm:col-span-2">
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Mật khẩu ${empty editing ? '' : '(để trống nếu không đổi)'}</label>
            <input type="password" name="password" ${empty editing ? 'required' : '' } class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
          </div>
        </div>
        <div class="flex items-center gap-3 mt-5 flex-wrap">
          <c:if test="${not empty editing}">
            <label class="inline-flex items-center gap-2 text-body-main font-body-main text-text-secondary cursor-pointer">
              <input type="checkbox" name="isActive" ${editing.isActive ? 'checked' : '' } class="rounded border-border-light text-primary-container focus:ring-primary-container">
              Đang hoạt động
            </label>
          </c:if>
          <button type="submit" class="bg-primary-container text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-primary transition-colors">${empty editing ? 'Thêm nhân viên' : 'Cập nhật'}</button>
          <c:if test="${not empty editing}">
            <a href="${pageContext.request.contextPath}/admin/users" class="border border-border-light text-text-secondary rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-surface-container-low transition-colors">Hủy</a>
          </c:if>
        </div>
      </form>
    </div>

    <div class="bg-white rounded-xl border border-border-light shadow-sm overflow-hidden">
      <div class="table-scroll">
        <table class="w-full border-collapse">
          <thead>
            <tr class="bg-surface-bright border-b border-border-light">
              <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">ID</th>
              <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tên đăng nhập</th>
              <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Họ tên</th>
              <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Email</th>
              <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Vai trò</th>
              <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Trạng thái</th>
              <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Thao tác</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-border-light text-body-main font-body-main align-middle">
            <c:forEach var="u" items="${users}">
              <tr class="hover:bg-slate-50 transition-colors">
                <td class="px-4 py-3 text-text-secondary">${u.userId}</td>
                <td class="px-4 py-3 font-medium">${u.username}</td>
                <td class="px-4 py-3">${u.fullName}</td>
                <td class="px-4 py-3 text-text-secondary">${u.email}</td>
                <td class="px-4 py-3">${u.role.roleName}</td>
                <td class="px-4 py-3">
                  <span class="inline-flex items-center px-2 py-1 rounded-full text-caption font-caption font-bold ${u.isActive ? 'bg-success-soft text-success border border-success/20' : 'bg-surface-container text-text-secondary border border-border-light'}">${u.isActive ? 'Hoạt động' : 'Khóa'}</span>
                </td>
                <td class="px-4 py-3 text-right whitespace-nowrap">
                  <div class="inline-flex items-center gap-1.5 justify-end flex-wrap">
                    <a href="?edit=${u.userId}" class="inline-flex items-center gap-1.5 border border-border-light text-text-secondary rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-surface-container-low transition-colors">
                      <span class="material-symbols-outlined text-[16px]">edit</span> Sửa
                    </a>
                    <c:if test="${u.isActive && u.userId != currentUser.userId}">
                      <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/users"
                        onsubmit="return confirm('Vô hiệu hóa tài khoản này?')">
                        <input type="hidden" name="action" value="delete"><input type="hidden" name="id"
                          value="${u.userId}">
                        <button type="submit" class="inline-flex items-center gap-1.5 bg-danger text-white rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-danger/90 transition-colors">
                          <span class="material-symbols-outlined text-[16px]">block</span> Vô hiệu hóa
                        </button>
                      </form>
                    </c:if>
                    <c:if test="${not u.isActive}">
                      <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/users"
                        onsubmit="return confirm('Kích hoạt lại tài khoản này?')">
                        <input type="hidden" name="action" value="activate"><input type="hidden" name="id"
                          value="${u.userId}">
                        <button type="submit" class="inline-flex items-center gap-1.5 bg-success text-white rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-success/90 transition-colors">
                          <span class="material-symbols-outlined text-[16px]">check_circle</span> Kích hoạt
                        </button>
                      </form>
                    </c:if>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<%@ include file="_foot.jspf" %>