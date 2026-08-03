<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><title>Xuất kho - Quản lý kho</title><link rel="stylesheet" href="css/style.css"></head><body>
<aside class="sidebar">
<div class="logo"><h2>QUẢN LÝ KHO</h2></div>
<nav class="menu">
<a class="menu-item " href="dashboard.jsp"><span>🏠</span><span>Tổng quan</span></a>
<a class="menu-item " href="sanpham.jsp"><span>📦</span><span>Sản phẩm</span></a>
<a class="menu-item " href="nhapkho.jsp"><span>📥</span><span>Nhập kho</span></a>
<a class="menu-item active" href="xuatkho.jsp"><span>📤</span><span>Xuất kho</span></a>
<a class="menu-item " href="nhacungcap.jsp"><span>🚚</span><span>Nhà cung cấp</span></a>
<a class="menu-item " href="nhanvien.jsp"><span>👥</span><span>Nhân viên</span></a>
<a class="menu-item" href="#"><span>📊</span><span>Báo cáo</span></a>
<a class="menu-item" href="#"><span>⚙️</span><span>Cài đặt</span></a>
</nav>
<div class="sidebar-bottom"><a class="menu-item" href="login.jsp"><span>🚪</span><span>Đăng xuất</span></a></div>
</aside>
<main class="main">
<header class="header"><h1>Xuất kho</h1><div class="header-right"><span>🔔</span><div class="user"><div class="avatar">AD</div><div class="user-info"><strong>Nguyễn Anh Duy</strong><span>Quản trị viên</span></div></div></div></header>
<section class="content">
<div class="page-title"><div><h2>Quản lý xuất kho</h2><p>Tạo và theo dõi các phiếu xuất hàng</p></div><a href="#form" class="btn btn-primary">+ Tạo phiếu xuất</a></div>
<div class="summary"><div class="summary-card"><span>Tổng phiếu xuất</span><strong>96</strong></div><div class="summary-card"><span>Đã hoàn thành</span><strong>89</strong></div><div class="summary-card"><span>Đang xử lý</span><strong>7</strong></div></div>
<div class="panel"><div class="toolbar"><input class="search" placeholder="🔍 Tìm mã phiếu / người nhận..."><select class="filter"><option>Tất cả trạng thái</option><option>Hoàn thành</option><option>Đang xử lý</option></select></div>
<table><thead><tr><th>Mã phiếu</th><th>Người nhận</th><th>Ngày xuất</th><th>Nhân viên</th><th>Tổng tiền</th><th>Trạng thái</th><th>Thao tác</th></tr></thead><tbody>
<tr><td>PX001</td><td>Cửa hàng ABC</td><td>01/08/2026</td><td>Nguyễn Văn A</td><td>65.000.000đ</td><td><span class="status success">Hoàn thành</span></td><td><button class="btn btn-secondary">Chi tiết</button></td></tr>
<tr><td>PX002</td><td>Cửa hàng XYZ</td><td>31/07/2026</td><td>Trần Văn B</td><td>42.000.000đ</td><td><span class="status success">Hoàn thành</span></td><td><button class="btn btn-secondary">Chi tiết</button></td></tr>
<tr><td>PX003</td><td>Khách hàng Nguyễn Văn C</td><td>30/07/2026</td><td>Nguyễn Văn A</td><td>18.500.000đ</td><td><span class="status pending">Đang xử lý</span></td><td><button class="btn btn-secondary">Chi tiết</button></td></tr>
</tbody></table></div>
<div class="panel" id="form"><div class="panel-header"><h3>Tạo phiếu xuất kho</h3></div><div class="form-grid">
<div class="form-group"><label>Mã phiếu</label><input placeholder="PX004"></div><div class="form-group"><label>Người nhận</label><input placeholder="Tên người nhận / cửa hàng"></div>
<div class="form-group"><label>Ngày xuất</label><input type="date"></div><div class="form-group"><label>Nhân viên xuất</label><select><option>Nguyễn Văn A</option><option>Trần Văn B</option></select></div>
<div class="form-group full"><label>Ghi chú</label><textarea placeholder="Ghi chú phiếu xuất"></textarea></div>
</div><div class="form-actions"><button class="btn btn-secondary">Hủy</button><button class="btn btn-primary">Lưu phiếu xuất</button></div></div>
</section></main></body></html>