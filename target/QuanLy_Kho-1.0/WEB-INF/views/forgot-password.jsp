<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="light" lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Quên mật khẩu - Quản lý kho</title>
  <%@ include file="_ui_head.jspf" %>
</head>
<body class="text-on-primary">
  <div class="min-h-screen flex items-center justify-center p-4" style="background:radial-gradient(1100px 500px at 20% -10%, rgba(79,70,229,.35), transparent 60%),radial-gradient(900px 400px at 100% 110%, rgba(53,37,205,.4), transparent 55%),#2d3133">
    <div class="w-full max-w-[400px] bg-surface-container-lowest rounded-2xl shadow-lg p-8">
      <div class="flex flex-col items-center mb-6 pt-2">
        <div class="w-14 h-14 rounded-xl bg-white/10 flex items-center justify-center mb-3">
          <svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="text-on-primary"><circle cx="8" cy="15" r="4"/><path d="M10.8 12.2 20 3"/><path d="M16 7l3 3"/><path d="M13 4l3 3"/></svg>
        </div>
        <h1 class="text-xl font-bold text-on-surface tracking-widest">QUẢN LÝ KHO</h1>
        <p class="text-label-md font-label-md text-text-secondary mt-1">Khôi phục mật khẩu</p>
      </div>

      <c:if test="${not empty flashError}">
        <div class="flex items-center gap-2 px-3 py-2.5 mb-4 rounded-lg bg-danger-soft text-danger border border-danger/20 text-body-main font-body-main">
          <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="shrink-0"><path d="M18 6 6 18"/><path d="M6 6l12 12"/></svg>${flashError}
        </div>
      </c:if>

      <p class="text-caption font-caption text-text-secondary text-center mb-4">
        Nhập email đã đăng ký, hệ thống sẽ gửi mật khẩu mới vào email của bạn.
      </p>
      <form method="post" action="${pageContext.request.contextPath}/forgot-password" class="space-y-4">
        <div>
          <label class="block text-label-md font-label-md text-text-secondary mb-1">Email</label>
          <input type="email" name="email" placeholder="Nhập email đã đăng ký" required class="w-full px-3 py-2.5 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
        </div>
        <button type="submit" class="w-full bg-primary hover:bg-primary-container text-white rounded-lg py-3 font-bold tracking-wider transition-colors">GỬI MẬT KHẨU MỚI</button>
      </form>
      <div class="text-center mt-6">
        <a href="${pageContext.request.contextPath}/login" class="inline-flex items-center gap-1.5 text-text-secondary font-body-main hover:text-on-surface transition-colors">
          <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5"/><path d="M11 18l-6-6 6-6"/></svg>
          Quay lại đăng nhập
        </a>
      </div>
    </div>
  </div>
</body>
</html>