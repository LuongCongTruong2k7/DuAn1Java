<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><title>Nhập kho - Quản lý kho</title><link rel="stylesheet" href="css/style.css"></head><body>
<aside class="sidebar">
<div class="logo"><h2>QUẢN LÝ KHO</h2></div>
<nav class="menu">
<a class="menu-item " href="dashboard.jsp"><span>🏠</span><span>Tổng quan</span></a>
<a class="menu-item " href="sanpham.jsp"><span>📦</span><span>Sản phẩm</span></a>
<a class="menu-item active" href="nhapkho.jsp"><span>📥</span><span>Nhập kho</span></a>
<a class="menu-item " href="xuatkho.jsp"><span>📤</span><span>Xuất kho</span></a>
<a class="menu-item " href="nhacungcap.jsp"><span>🚚</span><span>Nhà cung cấp</span></a>
<a class="menu-item " href="nhanvien.jsp"><span>👥</span><span>Nhân viên</span></a>
<a class="menu-item" href="#"><span>📊</span><span>Báo cáo</span></a>
<a class="menu-item" href="#"><span>⚙️</span><span>Cài đặt</span></a>
</nav>
<div class="sidebar-bottom"><a class="menu-item" href="login.jsp"><span>🚪</span><span>Đăng xuất</span></a></div>
</aside>
<main class="main">
<header class="header"><h1>Nhập kho</h1><div class="header-right"><span>🔔</span><div class="user"><div class="avatar">AD</div><div class="user-info"><strong>Nguyễn Anh Duy</strong><span>Quản trị viên</span></div></div></div></header>
<section class="content">
<div class="page-title"><div><h2>Quản lý nhập kho</h2><p>Tạo và theo dõi các phiếu nhập hàng</p></div><a href="#form" class="btn btn-primary">+ Tạo phiếu nhập</a></div>
<div class="summary"><div class="summary-card"><span>Tổng phiếu nhập</span><strong>128</strong></div><div class="summary-card"><span>Đã hoàn thành</span><strong>115</strong></div><div class="summary-card"><span>Đang xử lý</span><strong>13</strong></div></div>
<div class="panel"><div class="toolbar"><input class="search" placeholder="🔍 Tìm mã phiếu / nhà cung cấp..."><select class="filter"><option>Tất cả trạng thái</option><option>Hoàn thành</option><option>Đang xử lý</option></select></div>
<table><thead><tr><th>Mã phiếu</th><th>Nhà cung cấp</th><th>Ngày nhập</th><th>Nhân viên</th><th>Tổng tiền</th><th>Trạng thái</th><th>Thao tác</th></tr></thead><tbody>
<tr><td>PN001</td><td>FPT Trading</td><td>01/08/2026</td><td>Nguyễn Văn A</td><td>120.000.000đ</td><td><span class="status success">Hoàn thành</span></td><td><button class="btn btn-secondary">Chi tiết</button></td></tr>
<tr><td>PN002</td><td>Samsung Việt Nam</td><td>31/07/2026</td><td>Trần Văn B</td><td>85.000.000đ</td><td><span class="status success">Hoàn thành</span></td><td><button class="btn btn-secondary">Chi tiết</button></td></tr>
<tr><td>PN003</td><td>Apple Việt Nam</td><td>30/07/2026</td><td>Nguyễn Văn A</td><td>210.000.000đ</td><td><span class="status pending">Đang xử lý</span></td><td><button class="btn btn-secondary">Chi tiết</button></td></tr>
</tbody></table></div>
<div class="panel" id="form"><div class="panel-header"><h3>Tạo phiếu nhập kho</h3></div><div class="form-grid">
<div class="form-group"><label>Mã phiếu</label><input placeholder="PN004"></div><div class="form-group"><label>Nhà cung cấp</label><select><option>Chọn nhà cung cấp</option><option>FPT Trading</option><option>Samsung Việt Nam</option><option>Apple Việt Nam</option></select></div>
<div class="form-group"><label>Ngày nhập</label><input type="date"></div><div class="form-group"><label>Nhân viên nhập</label><select><option>Nguyễn Văn A</option><option>Trần Văn B</option></select></div>
<div class="form-group full"><label>Ghi chú</label><textarea placeholder="Ghi chú phiếu nhập"></textarea></div>
</div><div class="form-actions"><button class="btn btn-secondary">Hủy</button><button class="btn btn-success">Lưu phiếu nhập</button></div></div>
</section></main></body></html>