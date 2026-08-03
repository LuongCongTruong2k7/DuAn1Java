<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><title>Tổng quan - Quản lý kho</title><link rel="stylesheet" href="css/style.css"></head><body>
<aside class="sidebar">
<div class="logo"><h2>QUẢN LÝ KHO</h2></div>
<nav class="menu">
<a class="menu-item active" href="dashboard.jsp"><span>🏠</span><span>Tổng quan</span></a>
<a class="menu-item " href="sanpham.jsp"><span>📦</span><span>Sản phẩm</span></a>
<a class="menu-item " href="nhapkho.jsp"><span>📥</span><span>Nhập kho</span></a>
<a class="menu-item " href="xuatkho.jsp"><span>📤</span><span>Xuất kho</span></a>
<a class="menu-item " href="nhacungcap.jsp"><span>🚚</span><span>Nhà cung cấp</span></a>
<a class="menu-item " href="nhanvien.jsp"><span>👥</span><span>Nhân viên</span></a>
<a class="menu-item" href="#"><span>📊</span><span>Báo cáo</span></a>
<a class="menu-item" href="#"><span>⚙️</span><span>Cài đặt</span></a>
</nav>
<div class="sidebar-bottom"><a class="menu-item" href="login.jsp"><span>🚪</span><span>Đăng xuất</span></a></div>
</aside>
<main class="main">
<header class="header"><h1>Tổng quan</h1><div class="header-right"><span>🔔</span><div class="user"><div class="avatar">AD</div><div class="user-info"><strong>Nguyễn Anh Duy</strong><span>Quản trị viên</span></div></div></div></header>
<section class="content">
<div class="welcome"><h2>Xin chào, Nguyễn Anh Duy 👋</h2><p>Chào mừng bạn đến với hệ thống quản lý kho.</p></div>
<div class="stats">
<div class="stat-card"><div class="stat-icon blue">📦</div><div class="stat-info"><span>Tổng sản phẩm</span><h2>1,250</h2></div></div>
<div class="stat-card"><div class="stat-icon green">📥</div><div class="stat-info"><span>Nhập kho tháng này</span><h2>350</h2></div></div>
<div class="stat-card"><div class="stat-icon orange">📤</div><div class="stat-info"><span>Xuất kho tháng này</span><h2>280</h2></div></div>
<div class="stat-card"><div class="stat-icon red">⚠️</div><div class="stat-info"><span>Sắp hết hàng</span><h2>15</h2></div></div>
</div>
<div class="dashboard-grid">
<div class="panel"><div class="panel-header"><h3>Phiếu nhập gần đây</h3><a href="nhapkho.jsp">Xem tất cả</a></div>
<table><thead><tr><th>Mã phiếu</th><th>Nhà cung cấp</th><th>Ngày nhập</th><th>Trạng thái</th></tr></thead><tbody>
<tr><td>PN001</td><td>FPT Trading</td><td>01/08/2026</td><td><span class="status success">Hoàn thành</span></td></tr>
<tr><td>PN002</td><td>Samsung Việt Nam</td><td>31/07/2026</td><td><span class="status success">Hoàn thành</span></td></tr>
<tr><td>PN003</td><td>Apple Việt Nam</td><td>30/07/2026</td><td><span class="status pending">Đang xử lý</span></td></tr>
</tbody></table></div>
<div class="panel"><div class="panel-header"><h3>Sản phẩm sắp hết</h3><a href="sanpham.jsp">Xem tất cả</a></div>
<div class="product-list">
<div class="product-item"><div class="product-image">📱</div><div class="product-info"><strong>iPhone 15 Pro Max</strong><span>IP15PM</span></div><div class="quantity danger">3 sản phẩm</div></div>
<div class="product-item"><div class="product-image">💻</div><div class="product-info"><strong>MacBook Air M3</strong><span>MBA-M3</span></div><div class="quantity warning">5 sản phẩm</div></div>
<div class="product-item"><div class="product-image">🖱️</div><div class="product-info"><strong>Logitech G502</strong><span>G502</span></div><div class="quantity warning">7 sản phẩm</div></div>
</div></div></div>
<div class="panel"><div class="panel-header"><h3>Thao tác nhanh</h3></div><div class="quick-actions">
<a class="quick-button" href="sanpham.jsp"><span>➕</span><strong>Thêm sản phẩm</strong></a><a class="quick-button" href="nhapkho.jsp"><span>📥</span><strong>Tạo phiếu nhập</strong></a><a class="quick-button" href="xuatkho.jsp"><span>📤</span><strong>Tạo phiếu xuất</strong></a><a class="quick-button" href="#"><span>📊</span><strong>Xem báo cáo</strong></a>
</div></div>
</section></main></body></html>