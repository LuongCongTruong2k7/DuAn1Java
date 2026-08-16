<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Tài khoản" scope="request"/>
<%@ include file="_head.jspf" %>

<div class="flex-1 overflow-y-auto p-page-padding-x py-page-padding-y">
  <div class="max-w-7xl mx-auto space-y-margin-lg">

    <div class="bg-white rounded-xl border border-border-light shadow-sm p-6">
      <div class="flex flex-col sm:flex-row items-center sm:items-start gap-5">
        <div class="w-20 h-20 rounded-full bg-primary-container/10 text-primary-container flex items-center justify-center text-headline-lg font-headline-lg shrink-0">
          ${fn:toUpperCase(fn:substring(empty currentUser.fullName ? currentUser.username : currentUser.fullName,0,1))}
        </div>
        <div class="text-center sm:text-left">
          <div class="text-headline-md font-headline-md text-on-surface">${empty currentUser.fullName ? currentUser.username : currentUser.fullName}</div>
          <div class="text-label-md font-label-md text-text-secondary mt-1">${currentUser.role.roleName}</div>
          <div class="text-body-main font-body-main text-text-secondary mt-1">${currentUser.email}</div>
        </div>
      </div>
      <div class="grid sm:grid-cols-2 gap-4 mt-6 pt-6 border-t border-border-light text-body-main font-body-main">
        <p class="text-text-secondary"><span class="font-semibold text-on-surface">Tên đăng nhập:</span> ${currentUser.username}</p>
        <p class="text-text-secondary"><span class="font-semibold text-on-surface">Họ tên:</span> ${currentUser.fullName}</p>
        <p class="text-text-secondary"><span class="font-semibold text-on-surface">Email:</span> ${currentUser.email}</p>
        <p class="text-text-secondary"><span class="font-semibold text-on-surface">Vai trò:</span> ${currentUser.role.roleName}</p>
      </div>
    </div>

    <div class="bg-white rounded-xl border border-border-light shadow-sm p-6 max-w-2xl">
      <h3 class="text-section-header font-section-header text-on-surface mb-4 flex items-center gap-2">
        <span class="material-symbols-outlined text-secondary text-lg">lock_reset</span>
        Đổi mật khẩu
      </h3>
      <form method="post" action="${pageContext.request.contextPath}/account">
        <div class="grid sm:grid-cols-2 gap-4">
          <div>
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Mật khẩu hiện tại</label>
            <input type="password" name="oldPassword" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
          </div>
          <div>
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Mật khẩu mới</label>
            <input type="password" name="newPassword" minlength="6" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
          </div>
          <div class="sm:col-span-2">
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Xác nhận mật khẩu mới</label>
            <input type="password" name="confirmPassword" minlength="6" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
          </div>
        </div>
        <div class="flex items-center gap-3 mt-5">
          <button type="submit" class="bg-primary-container text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-primary transition-colors">Đổi mật khẩu</button>
        </div>
      </form>
    </div>

  </div>
</div>

<%@ include file="_foot.jspf" %>