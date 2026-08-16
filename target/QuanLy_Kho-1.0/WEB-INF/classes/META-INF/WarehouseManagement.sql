CREATE DATABASE WarehouseManagement;
GO

USE WarehouseManagement;
GO

-- =========================
-- Role Table
-- =========================
CREATE TABLE Role
(
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(100) NOT NULL
);

-- =========================
-- User Table
-- =========================
CREATE TABLE [User]
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(150),
    Email NVARCHAR(150),
    RoleID INT NOT NULL,
    IsActive BIT DEFAULT 1,

    CONSTRAINT FK_User_Role
        FOREIGN KEY (RoleID)
        REFERENCES Role(RoleID)
);

-- =========================
-- Product Category Table
-- =========================
CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(150) NOT NULL
);

-- =========================
-- Product Table
-- =========================
CREATE TABLE Product
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    UnitOfMeasurement NVARCHAR(50),
    ImageURL NVARCHAR(255),
    CategoryID INT NOT NULL,
    MinStock INT DEFAULT 0,
    MaxStock INT DEFAULT 0,
    IsActive BIT DEFAULT 1,

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
);

-- =========================
-- Receipt Table (Purchase Order)
-- =========================
CREATE TABLE Receipt
(
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,

    CreatedBy INT NOT NULL,
    ApprovedBy INT NULL,

    OrderDate DATETIME DEFAULT GETDATE(),
    ApprovalDate DATETIME NULL,

    SupplierName NVARCHAR(200),
    Status NVARCHAR(50),
    Remarks NVARCHAR(500),

    CONSTRAINT FK_Receipt_CreatedBy
        FOREIGN KEY (CreatedBy)
        REFERENCES [User](UserID),

    CONSTRAINT FK_Receipt_ApprovedBy
        FOREIGN KEY (ApprovedBy)
        REFERENCES [User](UserID)
);

-- =========================
-- Receipt Detail Table
-- =========================
CREATE TABLE ReceiptDetail
(
    ReceiptID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,

    PRIMARY KEY (ReceiptID, ProductID),

    CONSTRAINT FK_ReceiptDetail_Receipt
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipt(ReceiptID),

    CONSTRAINT FK_ReceiptDetail_Product
        FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID)
);

-- =========================
-- Issue Table (Sales Order / Issue Note)
-- =========================
CREATE TABLE Issue
(
    IssueID INT IDENTITY(1,1) PRIMARY KEY,

    CreatedBy INT NOT NULL,
    ApprovedBy INT NULL,

    OrderDate DATETIME DEFAULT GETDATE(),
    ApprovalDate DATETIME NULL,

    Recipient NVARCHAR(200),
    Status NVARCHAR(50),
    Remarks NVARCHAR(500),

    CONSTRAINT FK_Issue_CreatedBy
        FOREIGN KEY (CreatedBy)
        REFERENCES [User](UserID),

    CONSTRAINT FK_Issue_ApprovedBy
        FOREIGN KEY (ApprovedBy)
        REFERENCES [User](UserID)
);

-- =========================
-- Issue Detail Table
-- =========================
CREATE TABLE IssueDetail
(
    IssueID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,

    PRIMARY KEY (IssueID, ProductID),

    CONSTRAINT FK_IssueDetail_Issue
        FOREIGN KEY (IssueID)
        REFERENCES Issue(IssueID),

    CONSTRAINT FK_IssueDetail_Product
        FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID)
);

-- =========================
-- Seed data (mật khẩu mặc định: 123456)
-- =========================
INSERT INTO Role (RoleName) VALUES (N'Quản lý'), (N'Nhân viên kho');

INSERT INTO [User] (Username, Password, FullName, Email, RoleID, IsActive) VALUES
('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Quản lý kho', 'admin@whm.local', 1, 1),
('nhanvien', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Nhân viên kho 1', 'nv@whm.local', 2, 1);

INSERT INTO Category (CategoryName) VALUES (N'Điện tử'), (N'Văn phòng phẩm'), (N'Thực phẩm');

INSERT INTO Product (ProductName, UnitOfMeasurement, CategoryID, MinStock, MaxStock, IsActive) VALUES
(N'Laptop Dell Inspiron 15', N'chiếc', 1, 5, 50, 1),
(N'Chuột không dây Logitech', N'cái', 1, 10, 100, 1),
(N'Giấy A4 Double A', N'thùng', 2, 20, 200, 1),
(N'Bút bi Thiên Long', N'hộp', 2, 30, 300, 1),
(N'Mì gói Hảo Hảo', N'thùng', 3, 50, 500, 1);

-- Phiếu nhập mẫu (đã duyệt) để có tồn kho ban đầu
INSERT INTO Receipt (CreatedBy, ApprovedBy, OrderDate, ApprovalDate, SupplierName, Status, Remarks) VALUES
(1, 1, GETDATE(), GETDATE(), N'Công ty TNHH ABC', 'APPROVED', N'Nhập kho ban đầu');

INSERT INTO ReceiptDetail (ReceiptID, ProductID, Quantity) VALUES
(1, 1, 20), (1, 2, 50), (1, 3, 100), (1, 4, 100), (1, 5, 200);

-- Phiếu xuất mẫu (đã duyệt)
INSERT INTO Issue (CreatedBy, ApprovedBy, OrderDate, ApprovalDate, Recipient, Status, Remarks) VALUES
(1, 1, GETDATE(), GETDATE(), N'Cửa hàng số 1', 'APPROVED', N'Xuất bán lẻ');

INSERT INTO IssueDetail (IssueID, ProductID, Quantity) VALUES
(1, 1, 5), (1, 3, 20);
