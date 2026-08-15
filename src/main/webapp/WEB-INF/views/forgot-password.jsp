<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width,initial-scale=1.0">
      <title>Quên mật khẩu - Quản lý kho</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style2.css">
    </head>

    <body>
      <div class="login-page">
        <div class="login-box">
          <div class="login-logo">
            <div class="icon">🔑</div>
            <h1>QUẢN LÝ KHO</h1>
            <p>Khôi phục mật khẩu</p>
          </div>
          <c:if test="${not empty flashError}">
            <div class="alert err">${flashError}</div>
          </c:if>
          <p class="muted" style="text-align:center;font-size:13px;margin-bottom:4px">
            Nhập email đã đăng ký, hệ thống sẽ gửi mật khẩu mới vào email của bạn.</p>
          <form class="login-form" method="post" action="${pageContext.request.contextPath}/forgot-password">
            <div><label>Email</label>
              <input type="email" name="email" placeholder="Nhập email đã đăng ký" required>
            </div>
            <div class="remember" style="justify-content:center;margin-top:18px">
              <button class="login-btn" type="submit">GỬI MẬT KHẨU MỚI</button>
            </div>
          </form>
          <div class="login-footer"><a href="${pageContext.request.contextPath}/login" class="muted">← Quay lại đăng
              nhập</a></div>
        </div>
      </div>
    </body>

    </html>