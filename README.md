# QuanLy_Kho — Hệ thống quản lý kho

Java 21 · Jakarta Servlet 6 / JSP + JSTL · Hibernate 6.5 (JPA) · SQL Server · Maven (WAR)

## Chạy dự án

1. **Tạo database**: chạy toàn bộ file `src/main/java/META-INF/WarehouseManagement.sql`
   trong SSMS (đã gồm schema + dữ liệu mẫu).
2. **Kiểm tra kết nối DB**: sửa user/password SQL Server trong
   `src/main/java/META-INF/persistence.xml` nếu khác `sa / 221027`.
3. **Build**: `mvn clean package` → file `target/QuanLy_Kho-1.0.war`.
4. **Deploy**: Tomcat **10.1+** (bắt buộc, vì dùng Jakarta EE 10). Trong Eclipse:
   Run As → Run on Server.

## Tài khoản mẫu

| Tài khoản  | Mật khẩu | Vai trò    |
|------------|----------|-----------|
| `admin`    | `123456` | Quản lý       |
| `nhanvien` | `123456` | Nhân viên kho |

Mật khẩu lưu dạng SHA-256. Chỉ **Quản lý** vào được mục **Nhân viên**.

## Chức năng

- Đăng nhập / đăng xuất, ghi nhớ đăng nhập, đổi mật khẩu
- CRUD danh mục, sản phẩm (ngừng kinh doanh thay vì xóa để giữ lịch sử)
- Phiếu **nhập kho** / **xuất kho**: tạo phiếu → thêm dòng sản phẩm → duyệt.
  Chỉ phiếu đã duyệt mới tính vào tồn kho; duyệt phiếu xuất có kiểm tra đủ tồn.
- Báo cáo tồn kho (cảnh báo dưới min / vượt max) và nhập–xuất theo khoảng ngày
- Quản lý nhân viên + phân quyền (chỉ Quản lý)

## Cấu trúc

```
whm.entity   – 10 entity JPA khớp schema SQL (bảng [User], khóa kép ReceiptDetail/IssueDetail)
whm.dao      – XJpa (EntityManagerFactory), CrudDAO generic, DAO từng bảng, ReportDAO
whm.service  – business logic (duyệt phiếu, kiểm tra tồn, hash mật khẩu…)
whm.servlet  – AuthServlet, HomeServlet, AccountServlet + adm/* (CRUD, duyệt phiếu, báo cáo)
whm.filter   – AppFilter (UTF-8), AuthFilter (bắt đăng nhập, chặn /admin/users)
whm.util     – XAuth, XParam, XAttr, XPath, XCookie, XStr, XHttp, XMail
WEB-INF/views – JSP + JSTL (không truy cập trực tiếp được, phải qua servlet)
```
