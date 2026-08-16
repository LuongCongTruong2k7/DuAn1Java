<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Tổng quan" scope="request"/>
<c:set var="wsChannels" value="broadcast"/>
<%@ include file="_head.jspf" %>

<div class="flex-1 overflow-y-auto p-page-padding-x py-page-padding-y">
  <div class="max-w-7xl mx-auto space-y-margin-lg">

    <!-- Stat cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-card-gap">
      <div class="bg-white rounded-xl border border-border-light p-5 shadow-sm hover:shadow-md transition flex flex-col justify-between gap-4">
        <a href="${pageContext.request.contextPath}/admin/products" aria-label="Sản phẩm" class="w-11 h-11 rounded-lg bg-primary-container/10 text-primary-container flex items-center justify-center">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="w-6 h-6"><path d="M21 8 12 3 3 8v8l9 5 9-5Z"/><path d="M3 8l9 5 9-5"/><path d="M12 13v8"/></svg>
        </a>
        <div>
          <p class="text-text-secondary text-label-md font-label-md uppercase tracking-wider mb-1">Sản phẩm</p>
          <p class="text-3xl font-headline-lg text-on-surface">${productCount}</p>
        </div>
      </div>

      <div class="bg-white rounded-xl border border-border-light p-5 shadow-sm hover:shadow-md transition flex flex-col justify-between gap-4">
        <a href="${pageContext.request.contextPath}/admin/categories" aria-label="Danh mục" class="w-11 h-11 rounded-lg bg-secondary-container text-secondary flex items-center justify-center">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="w-6 h-6"><path d="M20 12.3 12.7 5H5v7.7L12.3 20a2 2 0 0 0 2.8 0l5-5a2 2 0 0 0 0-2.8Z"/><circle cx="9" cy="9" r="1.4" fill="currentColor" stroke="none"/></svg>
        </a>
        <div>
          <p class="text-text-secondary text-label-md font-label-md uppercase tracking-wider mb-1">Danh mục</p>
          <p class="text-3xl font-headline-lg text-on-surface">${categoryCount}</p>
        </div>
      </div>

      <c:if test="${currentUser.admin}">
        <div class="bg-white rounded-xl border border-border-light p-5 shadow-sm hover:shadow-md transition flex flex-col justify-between gap-4">
          <a href="${pageContext.request.contextPath}/admin/users" aria-label="Nhân viên" class="w-11 h-11 rounded-lg bg-danger-soft text-danger flex items-center justify-center">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="w-6 h-6"><circle cx="9" cy="8" r="3.2"/><path d="M2.5 20a6.5 6.5 0 0 1 13 0"/><path d="M16.5 6.5a3.2 3.2 0 0 1 0 6.3"/><path d="M18.5 14a6 6 0 0 1 4 5.6"/></svg>
          </a>
          <div>
            <p class="text-text-secondary text-label-md font-label-md uppercase tracking-wider mb-1">Nhân viên</p>
            <p class="text-3xl font-headline-lg text-on-surface">${userCount}</p>
          </div>
        </div>
      </c:if>

      <div class="bg-white rounded-xl border border-border-light border-l-4 border-l-warning p-5 shadow-sm hover:shadow-md transition flex flex-col justify-between gap-4">
        <a href="${pageContext.request.contextPath}/admin/receipts" aria-label="Phiếu nhập chờ duyệt" class="w-11 h-11 rounded-lg bg-warning-soft text-warning flex items-center justify-center">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="w-6 h-6"><path d="M12 3v12"/><path d="M7 10l5 5 5-5"/><path d="M4 19h16"/></svg>
        </a>
        <div>
          <p class="text-text-secondary text-label-md font-label-md uppercase tracking-wider mb-1">Phiếu nhập chờ duyệt</p>
          <p class="text-3xl font-headline-lg text-on-surface">${pendingReceipts}</p>
        </div>
      </div>

      <div class="bg-white rounded-xl border border-border-light border-l-4 border-l-danger p-5 shadow-sm hover:shadow-md transition flex flex-col justify-between gap-4">
        <a href="${pageContext.request.contextPath}/admin/issues" aria-label="Phiếu xuất chờ duyệt" class="w-11 h-11 rounded-lg bg-danger-soft text-danger flex items-center justify-center">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="w-6 h-6"><path d="M12 15V3"/><path d="M7 8l5-5 5 5"/><path d="M4 19h16"/></svg>
        </a>
        <div>
          <p class="text-text-secondary text-label-md font-label-md uppercase tracking-wider mb-1">Phiếu xuất chờ duyệt</p>
          <p class="text-3xl font-headline-lg text-on-surface">${pendingIssues}</p>
        </div>
      </div>
    </div>

    <!-- Low stock -->
    <div class="bg-white rounded-xl border border-border-light shadow-sm overflow-hidden">
      <div class="px-6 py-4 border-b border-border-light bg-surface flex items-center gap-2">
        <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-warning shrink-0"><path d="M12 9v4"/><path d="M10.3 3.9 1.8 18a1.5 1.5 0 0 0 1.3 2.3h17.8a1.5 1.5 0 0 0 1.3-2.3L13.7 3.9a1.5 1.5 0 0 0-2.6 0Z"/><path d="M12 16.2h.01"/></svg>
        <h2 class="text-section-header font-section-header text-on-surface">Sản phẩm dưới mức tồn tối thiểu</h2>
      </div>
      <c:choose>
        <c:when test="${empty lowStock}">
          <p class="px-6 py-6 text-body-main font-body-main text-text-secondary">Không có sản phẩm nào dưới mức tồn tối thiểu.</p>
        </c:when>
        <c:otherwise>
          <div class="table-scroll">
            <table class="w-full border-collapse">
              <thead>
                <tr class="bg-surface-bright border-b border-border-light">
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Sản phẩm</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">ĐVT</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tồn kho</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tồn tối thiểu</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-border-light text-body-main font-body-main">
                <c:forEach var="s" items="${lowStock}">
                  <tr class="hover:bg-slate-50 transition-colors">
                    <td class="px-4 py-3">${s.productName}</td>
                    <td class="px-4 py-3">${s.unit}</td>
                    <td class="px-4 py-3 text-right text-danger font-semibold">${s.stock}</td>
                    <td class="px-4 py-3 text-right">${s.minStock}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </div>
</div>

<%@ include file="_foot.jspf" %>