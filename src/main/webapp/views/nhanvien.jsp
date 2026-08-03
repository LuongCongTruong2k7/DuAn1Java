<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><title>Nhân viên - Quản lý kho</title><link rel="stylesheet" href="css/style.css"></head><body>
<aside class="sidebar">
<div class="logo"><h2>QUẢN LÝ KHO</h2></div>
<nav class="menu">
<a class="menu-item " href="dashboard.jsp"><span>🏠</span><span>Tổng quan</span></a>
<a class="menu-item " href="sanpham.jsp"><span>📦</span><span>Sản phẩm</span></a>
<a class="menu-item " href="nhapkho.jsp"><span>📥</span><span>Nhập kho</span></a>
<a class="menu-item " href="xuatkho.jsp"><span>📤</span><span>Xuất kho</span></a>
<a class="menu-item " href="nhacungcap.jsp"><span>🚚</span><span>Nhà cung cấp</span></a>
<a class="menu-item active" href="nhanvien.jsp"><span>👥</span><span>Nhân viên</span></a>
<a class="menu-item" href="#"><span>📊</span><span>Báo cáo</span></a>
<a class="menu-item" href="#"><span>⚙️</span><span>Cài đặt</span></a>
</nav>
<div class="sidebar-bottom"><a class="menu-item" href="login.jsp"><span>🚪</span><span>Đăng xuất</span></a></div>
</aside>
<main class="main">
<header class="header"><h1>Nhân viên</h1><div class="header-right"><span>🔔</span><div class="user"><div class="avatar">AD</div><div class="user-info"><strong>Nguyễn Anh Duy</strong><span>Quản trị viên</span></div></div></div></header>
<section class="content">
<div class="page-title"><div><h2>Quản lý nhân viên</h2><p>Quản lý tài khoản và nhân viên trong hệ thống</p></div><a href="#form" class="btn btn-primary">+ Thêm nhân viên</a></div>
<div class="panel"><div class="toolbar"><input class="search" placeholder="🔍 Tìm tên / email / SĐT..."><select class="filter"><option>Tất cả chức vụ</option><option>Quản trị viên</option><option>Nhân viên kho</option></select></div>
<table><thead><tr><th>Mã NV</th><th>Họ tên</th><th>Email</th><th>Số điện thoại</th><th>Chức vụ</th><th>Trạng thái</th><th>Thao tác</th></tr></thead><tbody>
<tr><td>NV001</td><td>Nguyễn Văn A</td><td>nguyenvana@example.com</td><td>0901111111</td><td>Nhân viên kho</td><td><span class="status success">Đang làm</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
<tr><td>NV002</td><td>Trần Văn B</td><td>tranvanb@example.com</td><td>0902222222</td><td>Nhân viên kho</td><td><span class="status success">Đang làm</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
<tr><td>NV003</td><td>Nguyễn Anh Duy</td><td>duy@example.com</td><td>0903333333</td><td>Quản trị viên</td><td><span class="status success">Đang làm</span></td><td><div class="action-buttons"><button class="btn btn-secondary">Sửa</button><button class="btn btn-danger">Xóa</button></div></td></tr>
</tbody></table></div>
<div class="panel" id="form"><div class="panel-header"><h3>Thông tin nhân viên</h3></div><div class="form-grid">
<div class="form-group"><label>Mã nhân viên</label><input placeholder="NV004"></div><div class="form-group"><label>Họ và tên</label><input placeholder="Nhập họ tên"></div>
<div class="form-group"><label>Email</label><input type="email" placeholder="email@example.com"></div><div class="form-group"><label>Số điện thoại</label><input placeholder="090xxxxxxx"></div>
<div class="form-group"><label>Chức vụ</label><select><option>Nhân viên kho</option><option>Quản trị viên</option></select></div><div class="form-group"><label>Mật khẩu</label><input type="password" placeholder="Nhập mật khẩu"></div>
</div><div class="form-actions"><button class="btn btn-secondary">Hủy</button><button class="btn btn-primary">Lưu nhân viên</button></div></div>
</section></main></body></html>