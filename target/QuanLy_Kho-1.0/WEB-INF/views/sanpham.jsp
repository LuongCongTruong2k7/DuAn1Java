<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="Sản phẩm" scope="request"/>
<c:set var="wsChannels" value="broadcast"/>
<%@ include file="_head.jspf" %>

<div class="flex-1 overflow-y-auto p-page-padding-x py-page-padding-y">
  <div class="max-w-7xl mx-auto">
    <div class="grid grid-cols-1 xl:grid-cols-12 gap-margin-lg">

      <!-- Main data section -->
      <div class="xl:col-span-8 flex flex-col space-y-margin-lg min-w-0">

        <!-- Toolbar & filters -->
        <div class="bg-surface-container-lowest rounded-lg border border-border-light p-4 shadow-sm flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
          <form method="get" action="${pageContext.request.contextPath}/admin/products" class="w-full flex flex-col lg:flex-row lg:items-center gap-3 flex-wrap">
            <div class="relative w-full sm:w-64">
              <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm sản phẩm..." class="pl-9 pr-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container w-full">
            </div>
            <select name="category" class="py-2 pl-3 pr-8 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
              <option value="">Tất cả danh mục</option>
              <c:forEach var="c" items="${categories}">
                <option value="${c.categoryId}" ${category == c.categoryId ? 'selected' : ''}>${c.categoryName}</option>
              </c:forEach>
            </select>
            <select name="stock" class="py-2 pl-3 pr-8 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
              <option value="">Trạng thái tồn</option>
              <option value="in" ${stock == 'in' ? 'selected' : ''}>Còn hàng</option>
              <option value="out" ${stock == 'out' ? 'selected' : ''}>Hết hàng</option>
            </select>
            <select name="status" class="py-2 pl-3 pr-8 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
              <option value="">Trạng thái</option>
              <option value="active" ${status == 'active' ? 'selected' : ''}>Đang bán</option>
              <option value="inactive" ${status == 'inactive' ? 'selected' : ''}>Ngừng bán</option>
            </select>
            <select name="sort" class="py-2 pl-3 pr-8 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
              <option value="">Sắp xếp mặc định</option>
              <option value="nameAsc" ${sort == 'nameAsc' ? 'selected' : ''}>Tên: A → Z</option>
              <option value="nameDesc" ${sort == 'nameDesc' ? 'selected' : ''}>Tên: Z → A</option>
              <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
              <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
            </select>
            <div class="flex items-center gap-2">
              <button type="submit" class="bg-primary-container text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-primary transition-colors inline-flex items-center gap-2">
                <span class="material-symbols-outlined text-[18px]">filter_alt</span> Áp dụng
              </button>
              <a href="${pageContext.request.contextPath}/admin/products" class="border border-border-light text-text-secondary rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-surface-container-low transition-colors">Đặt lại</a>
            </div>
          </form>
        </div>

        <p class="text-caption font-caption text-text-secondary">${totalCount} sản phẩm${not empty keyword ? ' — kết quả tìm "' : ''}${not empty keyword ? keyword : ''}${not empty keyword ? '"' : ''}</p>

        <!-- Table -->
        <div class="bg-white rounded-xl border border-border-light shadow-sm overflow-hidden">
          <div class="table-scroll">
            <table class="w-full border-collapse">
              <thead>
                <tr class="bg-surface-bright border-b border-border-light">
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">ID</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tên sản phẩm</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Danh mục</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">ĐVT</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tồn min</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tồn max</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Trạng thái</th>
                  <c:if test="${not readOnly}">
                    <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider"></th>
                  </c:if>
                </tr>
              </thead>
              <tbody class="divide-y divide-border-light text-body-main font-body-main align-middle">
                <c:forEach var="p" items="${products}">
                  <tr class="hover:bg-slate-50 transition-colors">
                    <td class="px-4 py-3 text-text-secondary">${p.productId}</td>
                    <c:choose>
                      <c:when test="${not empty p.imageUrl}">
                        <td class="px-4 py-3">
                          <span class="img-cell">${p.productName}<img class="img-pop" alt="${p.productName}"
                            src="${fn:startsWith(p.imageUrl,'/') || fn:startsWith(p.imageUrl,'http') ? p.imageUrl : pageContext.request.contextPath.concat(p.imageUrl)}"
                            onerror="this.style.display='none'"></span>
                        </td>
                      </c:when>
                      <c:otherwise>
                        <td class="px-4 py-3">${p.productName}</td>
                      </c:otherwise>
                    </c:choose>
                    <td class="px-4 py-3 text-text-secondary">${p.category.categoryName}</td>
                    <td class="px-4 py-3 text-text-secondary">${p.unitOfMeasurement}</td>
                    <td class="px-4 py-3 text-right text-text-secondary">${p.minStock}</td>
                    <td class="px-4 py-3 text-right text-text-secondary">${p.maxStock}</td>
                    <td class="px-4 py-3">
                      <span class="inline-flex items-center px-2 py-1 rounded-full text-caption font-caption font-bold ${p.isActive ? 'bg-success-soft text-success border border-success/20' : 'bg-surface-container text-text-secondary border border-border-light'}">${p.isActive ? 'Đang bán' : 'Ngừng'}</span>
                    </td>
                    <c:if test="${not readOnly}">
                      <td class="px-4 py-3 text-right whitespace-nowrap">
                        <div class="inline-flex items-center gap-1.5">
                          <a href="?edit=${p.productId}${baseQuery}" class="inline-flex items-center gap-1.5 border border-border-light text-text-secondary rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-surface-container-low transition-colors">
                            <span class="material-symbols-outlined text-[16px]">edit</span> Sửa
                          </a>
                          <c:if test="${p.isActive}">
                            <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/products"
                              onsubmit="return confirm('Ngừng kinh doanh sản phẩm này?')">
                              <input type="hidden" name="action" value="delete"><input type="hidden" name="id"
                                value="${p.productId}">
                              <button type="submit" class="inline-flex items-center gap-1.5 bg-danger text-white rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-danger/90 transition-colors">
                                <span class="material-symbols-outlined text-[16px]">block</span> Ngừng bán
                              </button>
                            </form>
                          </c:if>
                        </div>
                      </td>
                    </c:if>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
          <div class="flex items-center justify-end gap-2 mt-2">
            <c:set var="prev" value="${page - 1}"/>
            <c:set var="next" value="${page + 1}"/>
            <c:if test="${page > 1}">
              <a href="?page=1${baseQuery}" class="inline-flex items-center justify-center w-9 h-9 rounded-lg border border-border-light text-text-secondary hover:bg-surface-container-low transition-colors">«</a>
              <a href="?page=${prev}${baseQuery}" class="inline-flex items-center justify-center w-9 h-9 rounded-lg border border-border-light text-text-secondary hover:bg-surface-container-low transition-colors">‹</a>
            </c:if>
            <c:forEach var="i" begin="1" end="${totalPages}">
              <c:choose>
                <c:when test="${i == page}">
                  <span class="inline-flex items-center justify-center w-9 h-9 rounded-lg bg-primary-container text-white font-label-md">${i}</span>
                </c:when>
                <c:otherwise>
                  <a href="?page=${i}${baseQuery}" class="inline-flex items-center justify-center w-9 h-9 rounded-lg border border-border-light text-text-secondary hover:bg-surface-container-low transition-colors">${i}</a>
                </c:otherwise>
              </c:choose>
            </c:forEach>
            <c:if test="${page < totalPages}">
              <a href="?page=${next}${baseQuery}" class="inline-flex items-center justify-center w-9 h-9 rounded-lg border border-border-light text-text-secondary hover:bg-surface-container-low transition-colors">›</a>
              <a href="?page=${totalPages}${baseQuery}" class="inline-flex items-center justify-center w-9 h-9 rounded-lg border border-border-light text-text-secondary hover:bg-surface-container-low transition-colors">»</a>
            </c:if>
          </div>
        </c:if>

      </div>

      <!-- Add / edit panel -->
      <c:if test="${not readOnly}">
        <div class="xl:col-span-4">
          <div class="bg-white rounded-xl border border-border-light shadow-sm p-6 xl:sticky xl:top-24">
            <h3 class="text-section-header font-section-header text-on-surface mb-4 flex items-center gap-2">
              <span class="material-symbols-outlined text-secondary text-lg">${empty editing ? 'add_box' : 'edit_note'}</span>
              ${empty editing ? 'Thêm sản phẩm' : 'Cập nhật sản phẩm'}
            </h3>
            <form method="post" action="${pageContext.request.contextPath}/admin/products">
              <input type="hidden" name="id" value="${editing.productId}">
              <input type="hidden" name="keyword" value="${keyword}">
              <input type="hidden" name="category" value="${category}">
              <input type="hidden" name="stock" value="${stock}">
              <input type="hidden" name="status" value="${status}">
              <input type="hidden" name="sort" value="${sort}">
              <div class="space-y-4">
                <div>
                  <label class="block text-label-md font-label-md text-text-secondary mb-1">Tên sản phẩm</label>
                  <input type="text" name="productName" value="${editing.productName}" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
                </div>
                <div>
                  <label class="block text-label-md font-label-md text-text-secondary mb-1">Danh mục</label>
                  <select name="categoryId" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
                    <option value="">-- Chọn --</option>
                    <c:forEach var="c" items="${categories}">
                      <option value="${c.categoryId}" ${editing.category.categoryId==c.categoryId ? 'selected' : '' }>${c.categoryName}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="grid grid-cols-2 gap-3">
                  <div>
                    <label class="block text-label-md font-label-md text-text-secondary mb-1">Đơn vị tính</label>
                    <input type="text" name="unit" value="${editing.unitOfMeasurement}" placeholder="cái, thùng, kg..." class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
                  </div>
                  <div>
                    <label class="block text-label-md font-label-md text-text-secondary mb-1">Ảnh (URL)</label>
                    <input type="text" name="imageUrl" value="${editing.imageUrl}" class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
                  </div>
                </div>
                <div class="grid grid-cols-2 gap-3">
                  <div>
                    <label class="block text-label-md font-label-md text-text-secondary mb-1">Tồn tối thiểu</label>
                    <input type="number" name="minStock" min="0" value="${empty editing ? 0 : editing.minStock}" class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
                  </div>
                  <div>
                    <label class="block text-label-md font-label-md text-text-secondary mb-1">Tồn tối đa</label>
                    <input type="number" name="maxStock" min="0" value="${empty editing ? 0 : editing.maxStock}" class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
                  </div>
                </div>
              </div>
              <div class="flex items-center gap-3 mt-5 flex-wrap">
                <c:if test="${not empty editing}">
                  <label class="inline-flex items-center gap-2 text-body-main font-body-main text-text-secondary cursor-pointer">
                    <input type="checkbox" name="isActive" ${editing.isActive ? 'checked' : '' } class="rounded border-border-light text-primary-container focus:ring-primary-container">
                    Đang kinh doanh
                  </label>
                </c:if>
                <button type="submit" class="bg-primary-container text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-primary transition-colors">${empty editing ? 'Thêm sản phẩm' : 'Cập nhật'}</button>
                <c:if test="${not empty editing}">
                  <a href="${pageContext.request.contextPath}/admin/products" class="border border-border-light text-text-secondary rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-surface-container-low transition-colors">Hủy</a>
                </c:if>
              </div>
            </form>
          </div>
        </div>
      </c:if>

    </div>
  </div>
</div>

<%@ include file="_foot.jspf" %>