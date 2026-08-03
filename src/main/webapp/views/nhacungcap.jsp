<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><title>Nhà cung cấp - Quản lý kho</title><link rel="stylesheet" href="css/style.css"></head><body>
<aside class="sidebar">
<div class="logo"><h2>QUẢN LÝ KHO</h2></div>
<nav class="menu">
<a class="menu-item " href="dashboard.jsp"><span>🏠</span><span>Tổng quan</span></a>
<a class="menu-item " href="sanpham.jsp"><span>📦</span><span>Sản phẩm</span></a>
<a class="menu-item " href="nhapkho.jsp"><span>📥</span><span>Nhập kho</span></a>
<a class="menu-item " href="xuatkho.jsp"><span>📤</span><span>Xuất kho</span></a>
<a class="menu-item active" href="nhacungcap.jsp"><span>🚚</span><span>Nhà cung cấp</span></a>
<a class="menu-item " href="nhanvien.jsp"><span>👥</span><span>Nhân viên</span></a>
<a class="menu-item" href="#"><span>📊</span><span>Báo cáo</span></a>
<a class="menu-item" href="#"><span>⚙️</span><span>Cài đặt</span></a>
</nav>
<div class="sidebar-bottom"><a class="menu-item" href="login.jsp"><span>🚪</span><span>Đăng xuất</span></a></div>
</aside>
<main class="main">
<header class="header"><h1>Nhà cung cấp</h1><div class="header-right"><span>🔔</span><div class="user"><div class="avatar">AD</div><div class="user-info"><strong>Nguyễn Anh Duy</strong><span>Quản trị viên</span></div></div></div></header>
<section class="content">
<div class="page-title"><div><h2>Quản lý nhà cung cấp</h2><p>Danh sách các nhà cung cấp của kho</p></div><a href="#form" class="btn btn-primary">+ Thêm nhà cung cấp</a></div>
<div class="panel"><div class="toolbar"><input class="search" placeholder="🔍 Tìm tên / số điện thoại..."></div>
<table><thead><tr><th>Mã NCC</th><th>Tên nhà cung cấp</th><th>Số điện thoại</th><th>Email</th><th>Địa chỉ</th><th>Trạng thái</th><th>Thao tác</th></tr></thead><tbody>
<tr><td>NCC001</td><td>FPT Trading</td><td>0901234567</td><td>fpt@example.com</td><td>TP. Hồ Chí Minh</td><td><span class="status success">Hoạt động</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
<tr><td>NCC002</td><td>Samsung Việt Nam</td><td>0902345678</td><td>samsung@example.com</td><td>TP. Hồ Chí Minh</td><td><span class="status success">Hoạt động</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
<tr><td>NCC003</td><td>Apple Việt Nam</td><td>0903456789</td><td>apple@example.com</td><td>Hà Nội</td><td><span class="status success">Hoạt động</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
</tbody></table></div>
<div class="panel" id="form"><div class="panel-header"><h3>Thông tin nhà cung cấp</h3></div><div class="form-grid">
<div class="form-group"><label>Mã nhà cung cấp</label><input placeholder="NCC004"></div><div class="form-group"><label>Tên nhà cung cấp</label><input placeholder="Nhập tên nhà cung cấp"></div>
<div class="form-group"><label>Số điện thoại</label><input placeholder="090xxxxxxx"></div><div class="form-group"><label>Email</label><input type="email" placeholder="email@example.com"></div>
<div class="form-group full"><label>Địa chỉ</label><input placeholder="Nhập địa chỉ"></div><div class="form-group full"><label>Ghi chú</label><textarea placeholder="Thông tin thêm"></textarea></div>
</div><div class="form-actions"><button class="btn btn-secondary">Hủy</button><button class="btn btn-primary">Lưu nhà cung cấp</button></div></div>
</section></main></body></html>