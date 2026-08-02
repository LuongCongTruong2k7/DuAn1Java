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
-- Users Table
-- =========================
CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(150),
    Email NVARCHAR(150),
    RoleID INT NOT NULL,
    IsActive BIT DEFAULT 1,

    CONSTRAINT FK_Users_Role
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
        REFERENCES Users(UserID),

    CONSTRAINT FK_Receipt_ApprovedBy
        FOREIGN KEY (ApprovedBy)
        REFERENCES Users(UserID)
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
        REFERENCES Users(UserID),

    CONSTRAINT FK_Issue_ApprovedBy
        FOREIGN KEY (ApprovedBy)
        REFERENCES Users(UserID)
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
