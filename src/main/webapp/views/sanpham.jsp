<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><title>Quản lý sản phẩm - Quản lý kho</title><link rel="stylesheet" href="css/style.css"></head><body>
<aside class="sidebar">
<div class="logo"><h2>QUẢN LÝ KHO</h2></div>
<nav class="menu">
<a class="menu-item " href="dashboard.jsp"><span>🏠</span><span>Tổng quan</span></a>
<a class="menu-item active" href="sanpham.jsp"><span>📦</span><span>Sản phẩm</span></a>
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
<header class="header"><h1>Quản lý sản phẩm</h1><div class="header-right"><span>🔔</span><div class="user"><div class="avatar">AD</div><div class="user-info"><strong>Nguyễn Anh Duy</strong><span>Quản trị viên</span></div></div></div></header>
<section class="content">
<div class="page-title"><div><h2>Danh sách sản phẩm</h2><p>Quản lý toàn bộ sản phẩm trong kho</p></div><a href="#form" class="btn btn-primary">+ Thêm sản phẩm</a></div>
<div class="panel"><div class="toolbar"><input class="search" placeholder="🔍 Tìm kiếm sản phẩm..."><select class="filter"><option>Tất cả danh mục</option><option>Điện thoại</option><option>Laptop</option><option>Phụ kiện</option></select></div>
<table><thead><tr><th>Mã SP</th><th>Tên sản phẩm</th><th>Danh mục</th><th>Đơn vị</th><th>Số lượng</th><th>Giá nhập</th><th>Trạng thái</th><th>Thao tác</th></tr></thead><tbody>
<tr><td>SP001</td><td>iPhone 15 Pro Max</td><td>Điện thoại</td><td>Cái</td><td>35</td><td>25.000.000đ</td><td><span class="status success">Còn hàng</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
<tr><td>SP002</td><td>MacBook Air M3</td><td>Laptop</td><td>Cái</td><td>5</td><td>27.000.000đ</td><td><span class="status pending">Sắp hết</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
<tr><td>SP003</td><td>Logitech G502</td><td>Phụ kiện</td><td>Cái</td><td>72</td><td>1.200.000đ</td><td><span class="status success">Còn hàng</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
<tr><td>SP004</td><td>Samsung Galaxy S25</td><td>Điện thoại</td><td>Cái</td><td>2</td><td>18.000.000đ</td><td><span class="status danger-status">Sắp hết</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
</tbody></table></div>
<div class="panel" id="form"><div class="panel-header"><h3>Thông tin sản phẩm</h3></div><div class="form-grid">
<div class="form-group"><label>Mã sản phẩm</label><input placeholder="VD: SP005"></div><div class="form-group"><label>Tên sản phẩm</label><input placeholder="Nhập tên sản phẩm"></div>
<div class="form-group"><label>Danh mục</label><select><option>Chọn danh mục</option><option>Điện thoại</option><option>Laptop</option><option>Phụ kiện</option></select></div><div class="form-group"><label>Đơn vị tính</label><input placeholder="Cái"></div>
<div class="form-group"><label>Giá nhập</label><input type="number" placeholder="0"></div><div class="form-group"><label>Số lượng</label><input type="number" placeholder="0"></div>
<div class="form-group full"><label>Mô tả</label><textarea placeholder="Nhập mô tả sản phẩm"></textarea></div>
</div><div class="form-actions"><button class="btn btn-secondary">Hủy</button><button class="btn btn-primary">Lưu sản phẩm</button></div></div>
</section></main></body></html>