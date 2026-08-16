<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="light" lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Đăng nhập - Quản lý kho</title>
  <%@ include file="_ui_head.jspf" %>
</head>
<body class="text-on-primary">
  <div class="min-h-screen flex items-center justify-center p-4" style="background:radial-gradient(1100px 500px at 20% -10%, rgba(79,70,229,.35), transparent 60%),radial-gradient(900px 400px at 100% 110%, rgba(53,37,205,.4), transparent 55%),#2d3133">
    <div class="w-full max-w-[400px] bg-surface-container-lowest rounded-2xl shadow-lg p-8">
      <div class="flex flex-col items-center mb-6 pt-2">
        <div class="w-14 h-14 rounded-xl bg-white/10 flex items-center justify-center mb-3">
          <img src="${pageContext.request.contextPath}/assets/images/qlkho.png" alt="Logo" class="w-9 h-9 object-contain">
        </div>
        <h1 class="text-xl font-bold text-on-surface tracking-widest">QUẢN LÝ KHO</h1>
        <p class="text-label-md font-label-md text-text-secondary mt-1">Đăng nhập vào hệ thống quản lý</p>
      </div>

      <c:if test="${not empty flashError}">
        <div class="flex items-center gap-2 px-3 py-2.5 mb-4 rounded-lg bg-danger-soft text-danger border border-danger/20 text-body-main font-body-main">
          <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="shrink-0"><path d="M18 6 6 18"/><path d="M6 6l12 12"/></svg>${flashError}
        </div>
      </c:if>
      <c:if test="${not empty flashSuccess}">
        <div class="flex items-center gap-2 px-3 py-2.5 mb-4 rounded-lg bg-success-soft text-success border border-success/20 text-body-main font-body-main">
          <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="shrink-0"><path d="M20 6 9 17l-5-5"/></svg>${flashSuccess}
        </div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-4">
        <div>
          <label class="block text-label-md font-label-md text-text-secondary mb-1">Tên đăng nhập</label>
          <input type="text" name="username" value="${rememberedUsername}" placeholder="Nhập tên đăng nhập" required class="w-full px-3 py-2.5 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
        </div>
        <div>
          <label class="block text-label-md font-label-md text-text-secondary mb-1">Mật khẩu</label>
          <input type="password" name="password" value="${rememberedPassword}" placeholder="Nhập mật khẩu" required class="w-full px-3 py-2.5 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
        </div>
        <div class="flex items-center justify-between text-sm">
          <label class="inline-flex items-center gap-2 text-body-main font-body-main text-text-secondary cursor-pointer">
            <input type="checkbox" name="remember" ${not empty rememberedUsername ? 'checked' : '' } class="rounded border-border-light text-primary-container focus:ring-primary-container">
            Ghi nhớ đăng nhập
          </label>
          <a href="${pageContext.request.contextPath}/forgot-password" class="text-primary-container font-body-main hover:underline">Quên mật khẩu?</a>
        </div>
        <button type="submit" class="w-full bg-primary hover:bg-primary-container text-white rounded-lg py-3 font-bold tracking-wider transition-colors">ĐĂNG NHẬP</button>
      </form>

      <div class="text-center text-caption font-caption text-text-secondary mt-6">© 2026 Hệ thống quản lý kho</div>
    </div>
  </div>
</body>
</html>