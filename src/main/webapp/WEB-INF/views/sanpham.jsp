<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="Sản phẩm" scope="request"/>
<c:set var="wsChannels" value="broadcast"/>
<%@ include file="_head.jspf" %>

<c:if test="${not readOnly}">
  <div class="panel">
    <form method="post" action="${pageContext.request.contextPath}/admin/products">
      <input type="hidden" name="id" value="${editing.productId}">
      <input type="hidden" name="keyword" value="${keyword}">
      <input type="hidden" name="category" value="${category}">
      <input type="hidden" name="stock" value="${stock}">
      <input type="hidden" name="status" value="${status}">
      <input type="hidden" name="sort" value="${sort}">
      <div class="form-grid">
        <div><label>Tên sản phẩm</label>
          <input type="text" name="productName" value="${editing.productName}" required>
        </div>
        <div><label>Danh mục</label>
          <select name="categoryId" required>
            <option value="">-- Chọn --</option>
            <c:forEach var="c" items="${categories}">
              <option value="${c.categoryId}" ${editing.category.categoryId==c.categoryId ? 'selected' : '' }>
                ${c.categoryName}</option>
            </c:forEach>
          </select>
        </div>
        <div><label>Đơn vị tính</label>
          <input type="text" name="unit" value="${editing.unitOfMeasurement}" placeholder="cái, thùng, kg...">
        </div>
        <div><label>Ảnh (URL)</label>
          <input type="text" name="imageUrl" value="${editing.imageUrl}">
        </div>
        <div><label>Tồn tối thiểu</label>
          <input type="number" name="minStock" min="0" value="${empty editing ? 0 : editing.minStock}">
        </div>
        <div><label>Tồn tối đa</label>
          <input type="number" name="maxStock" min="0" value="${empty editing ? 0 : editing.maxStock}">
        </div>
      </div>
      <div class="actions">
        <c:if test="${not empty editing}">
          <label><input type="checkbox" name="isActive" ${editing.isActive ? 'checked' : '' }> Đang kinh
            doanh</label>
        </c:if>
        <button class="btn" type="submit">${empty editing ? 'Thêm sản phẩm' : 'Cập nhật'}</button>
        <c:if test="${not empty editing}">
          <a class="btn gray" href="${pageContext.request.contextPath}/admin/products">Hủy</a>
        </c:if>
      </div>
    </form>
  </div>
</c:if>

<div class="toolbar">
  <form method="get" action="${pageContext.request.contextPath}/admin/products" style="display:flex;gap:8px">
    <input type="text" name="keyword" value="${keyword}" placeholder="Tìm theo tên sản phẩm...">
    <select name="category">
      <option value="">Tất cả danh mục</option>
      <c:forEach var="c" items="${categories}">
        <option value="${c.categoryId}" ${category == c.categoryId ? 'selected' : ''}>${c.categoryName}</option>
      </c:forEach>
    </select>
    <select name="stock">
      <option value="">Tất cả tồn kho</option>
      <option value="in" ${stock == 'in' ? 'selected' : ''}>Còn hàng</option>
      <option value="out" ${stock == 'out' ? 'selected' : ''}>Hết hàng</option>
    </select>
    <select name="status">
      <option value="">Tất cả trạng thái</option>
      <option value="active" ${status == 'active' ? 'selected' : ''}>Đang bán</option>
      <option value="inactive" ${status == 'inactive' ? 'selected' : ''}>Ngừng bán</option>
    </select>
    <select name="sort">
      <option value="">Sắp xếp mặc định</option>
      <option value="nameAsc" ${sort == 'nameAsc' ? 'selected' : ''}>Tên: A → Z</option>
      <option value="nameDesc" ${sort == 'nameDesc' ? 'selected' : ''}>Tên: Z → A</option>
      <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
      <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
    </select>
    <button class="btn" type="submit">Áp dụng bộ lọc</button>
    <a class="btn gray" href="${pageContext.request.contextPath}/admin/products">Đặt lại</a>
  </form>
</div>

<p class="muted">${totalCount} sản phẩm${not empty keyword ? ' — kết quả tìm "' : ''}${not empty keyword ? keyword : ''}${not empty keyword ? '"' : ''}</p>

<table>
  <tr>
    <th style="width:60px">ID</th>
    <th>Tên sản phẩm</th>
    <th>Danh mục</th>
    <th>ĐVT</th>
    <th class="r">Tồn min</th>
    <th class="r">Tồn max</th>
    <th>Trạng thái</th>
    <c:if test="${not readOnly}">
      <th style="width:170px"></th>
    </c:if>
  </tr>
  <c:forEach var="p" items="${products}">
    <tr>
      <td>${p.productId}</td>
      <c:choose>
        <c:when test="${not empty p.imageUrl}">
          <td class="img-cell">${p.productName}<img class="img-pop" alt="${p.productName}"
              src="${fn:startsWith(p.imageUrl,'/') || fn:startsWith(p.imageUrl,'http') ? p.imageUrl : pageContext.request.contextPath.concat(p.imageUrl)}"
              onerror="this.style.display='none'"></td>
        </c:when>
        <c:otherwise>
          <td>${p.productName}</td>
        </c:otherwise>
      </c:choose>
      <td>${p.category.categoryName}</td>
      <td>${p.unitOfMeasurement}</td>
      <td class="r">${p.minStock}</td>
      <td class="r">${p.maxStock}</td>
      <td><span class="badge ${p.isActive ? 'approved' : 'off'}">${p.isActive ? 'Đang bán' : 'Ngừng'}</span>
      </td>
      <c:if test="${not readOnly}">
        <td class="r">
          <a class="btn sm gray" href="?edit=${p.productId}${baseQuery}">Sửa</a>
          <c:if test="${p.isActive}">
            <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/products"
              onsubmit="return confirm('Ngừng kinh doanh sản phẩm này?')">
              <input type="hidden" name="action" value="delete"><input type="hidden" name="id"
                value="${p.productId}">
              <button class="btn sm red" type="submit">Ngừng bán</button>
            </form>
          </c:if>
        </td>
      </c:if>
    </tr>
  </c:forEach>
</table>

<c:if test="${totalPages > 1}">
  <div class="pagination">
    <c:set var="prev" value="${page - 1}"/>
    <c:set var="next" value="${page + 1}"/>
    <c:if test="${page > 1}">
      <a class="btn sm gray" href="?page=1${baseQuery}">«</a>
      <a class="btn sm gray" href="?page=${prev}${baseQuery}">‹</a>
    </c:if>
    <c:forEach var="i" begin="1" end="${totalPages}">
      <c:choose>
        <c:when test="${i == page}">
          <span class="btn sm on">${i}</span>
        </c:when>
        <c:otherwise>
          <a class="btn sm gray" href="?page=${i}${baseQuery}">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:if test="${page < totalPages}">
      <a class="btn sm gray" href="?page=${next}${baseQuery}">›</a>
      <a class="btn sm gray" href="?page=${totalPages}${baseQuery}">»</a>
    </c:if>
  </div>
</c:if>

<%@ include file="_foot.jspf" %>
