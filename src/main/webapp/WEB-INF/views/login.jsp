<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width,initial-scale=1.0">
      <title>Đăng nhập - Quản lý kho</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style3.css">
    </head>

    <body>
      <div class="login-page">
        <div class="login-box">
          <div class="login-logo">
            <div class="icon"><img src="${pageContext.request.contextPath}/assets/images/qlkho.png"></div>
            <h1>QUẢN LÝ KHO</h1>
            <p>Đăng nhập vào hệ thống quản lý</p>
          </div>
          <c:if test="${not empty flashError}">
            <div class="alert err">${flashError}</div>
          </c:if>
          <c:if test="${not empty flashSuccess}">
            <div class="alert ok">${flashSuccess}</div>
          </c:if>
          <form class="login-form" method="post" action="${pageContext.request.contextPath}/login">
            <div><label>Tên đăng nhập</label>
              <input type="text" name="username" value="${rememberedUsername}" placeholder="Nhập tên đăng nhập"
                required>
            </div>
            <div><label>Mật khẩu</label>
              <input type="password" name="password" value="${rememberedPassword}" placeholder="Nhập mật khẩu" required>
            </div>
            <div class="remember">
              <label><input type="checkbox" name="remember" ${not empty rememberedUsername ? 'checked' : '' }> Ghi nhớ
                đăng nhập</label>
              <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
            </div>
            <button class="login-btn" type="submit">ĐĂNG NHẬP</button>
          </form>
          <div class="login-footer">© 2026 Hệ thống quản lý kho</div>
        </div>
      </div>
    </body>

    </html>