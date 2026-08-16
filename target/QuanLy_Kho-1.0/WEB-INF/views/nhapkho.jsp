<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Nhập kho" scope="request"/>
<c:set var="wsChannels" value="${not empty current ? 'receipt-'.concat(current.receiptId) : 'broadcast'}"/>
<%@ include file="_head.jspf" %>

<div class="flex-1 overflow-y-auto p-page-padding-x py-page-padding-y">
  <div class="max-w-7xl mx-auto space-y-margin-lg">

    <c:choose>
      <c:when test="${not empty current}">
        <!-- Voucher detail -->
        <div class="flex items-center justify-between flex-wrap gap-3">
          <a href="${pageContext.request.contextPath}/admin/receipts" class="inline-flex items-center gap-1.5 border border-border-light text-text-secondary rounded-lg px-3 py-2 text-[13px] font-body-main hover:bg-surface-container-low transition-colors">
            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5"/><path d="M11 18l-6-6 6-6"/></svg>
            Danh sách phiếu nhập
          </a>
          <h2 class="text-headline-lg font-headline-lg text-on-surface flex items-center gap-3">
            Phiếu nhập #${current.receiptId}
            <span class="inline-flex items-center px-2 py-1 rounded-full text-caption font-caption font-bold ${current.pending ? 'bg-warning-soft text-warning border border-warning/20' : 'bg-success-soft text-success border border-success/20'}">${current.pending ? 'Chờ duyệt' : 'Đã duyệt'}</span>
          </h2>
        </div>

        <div class="bg-white rounded-xl border border-border-light shadow-sm p-6">
          <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-4 text-body-main font-body-main">
            <p class="text-text-secondary"><span class="font-semibold text-on-surface">Nhà cung cấp:</span> ${current.supplierName}</p>
            <p class="text-text-secondary"><span class="font-semibold text-on-surface">Người tạo:</span> ${current.createdBy.fullName}</p>
            <p class="text-text-secondary"><span class="font-semibold text-on-surface">Ngày tạo:</span>
              <fmt:formatDate value="${current.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
            </p>
            <c:if test="${!current.pending}">
              <p class="text-text-secondary"><span class="font-semibold text-on-surface">Người duyệt:</span> ${current.approvedBy.fullName}</p>
              <p class="text-text-secondary"><span class="font-semibold text-on-surface">Ngày duyệt:</span>
                <fmt:formatDate value="${current.approvalDate}" pattern="dd/MM/yyyy HH:mm"/>
              </p>
            </c:if>
            <c:if test="${not empty current.remarks}">
              <p class="text-text-secondary sm:col-span-2 lg:col-span-3"><span class="font-semibold text-on-surface">Ghi chú:</span> ${current.remarks}</p>
            </c:if>
          </div>
        </div>

        <c:if test="${current.pending}">
          <div class="bg-white rounded-xl border border-border-light shadow-sm p-6 max-w-2xl">
            <h3 class="text-section-header font-section-header text-on-surface mb-4 flex items-center gap-2">
              <span class="material-symbols-outlined text-secondary text-lg">playlist_add</span>
              Thêm sản phẩm vào phiếu
            </h3>
            <form method="post" action="${pageContext.request.contextPath}/admin/receipts">
              <input type="hidden" name="action" value="addDetail"><input type="hidden" name="id"
                value="${current.receiptId}">
              <div class="flex flex-col sm:flex-row gap-3">
                <div class="flex-1">
                  <label class="block text-label-md font-label-md text-text-secondary mb-1">Sản phẩm</label>
                  <select name="productId" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
                    <option value="">-- Chọn sản phẩm --</option>
                    <c:forEach var="p" items="${products}">
                      <option value="${p.productId}">${p.productName} (${p.unitOfMeasurement})</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="w-full sm:w-40">
                  <label class="block text-label-md font-label-md text-text-secondary mb-1">Số lượng</label>
                  <input type="number" name="quantity" min="1" value="1" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
                </div>
                <div class="flex items-end">
                  <button type="submit" class="bg-primary-container text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-primary transition-colors">Thêm vào phiếu</button>
                </div>
              </div>
            </form>
          </div>
        </c:if>

        <div class="bg-white rounded-xl border border-border-light shadow-sm overflow-hidden">
          <div class="table-scroll">
            <table class="w-full border-collapse">
              <thead>
                <tr class="bg-surface-bright border-b border-border-light">
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Sản phẩm</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">ĐVT</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Số lượng</th>
                  <c:if test="${current.pending}">
                    <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider"></th>
                  </c:if>
                </tr>
              </thead>
              <tbody class="divide-y divide-border-light text-body-main font-body-main align-middle">
                <c:forEach var="d" items="${current.details}">
                  <tr class="hover:bg-slate-50 transition-colors">
                    <td class="px-4 py-3">${d.product.productName}</td>
                    <td class="px-4 py-3 text-text-secondary">${d.product.unitOfMeasurement}</td>
                    <td class="px-4 py-3 text-right">${d.quantity}</td>
                    <c:if test="${current.pending}">
                      <td class="px-4 py-3 text-right whitespace-nowrap">
                        <form class="inline-form" method="post"
                          action="${pageContext.request.contextPath}/admin/receipts">
                          <input type="hidden" name="action" value="removeDetail">
                          <input type="hidden" name="id" value="${current.receiptId}">
                          <input type="hidden" name="productId" value="${d.product.productId}">
                          <button type="submit" class="inline-flex items-center gap-1.5 bg-danger text-white rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-danger/90 transition-colors">
                            <span class="material-symbols-outlined text-[16px]">remove_circle</span> Xóa
                          </button>
                        </form>
                      </td>
                    </c:if>
                  </tr>
                </c:forEach>
                <tr class="bg-surface-container-low">
                  <td colspan="2" class="px-4 py-3 font-semibold text-on-surface">Tổng số lượng</td>
                  <td class="px-4 py-3 text-right font-semibold text-on-surface">${current.totalQuantity}</td>
                  <c:if test="${current.pending}"><td></td></c:if>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <c:if test="${current.pending && currentUser.admin}">
          <div class="flex items-center gap-3 flex-wrap">
            <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/receipts"
              onsubmit="return confirm('Duyệt phiếu? Sau khi duyệt sẽ không sửa được nữa.')">
              <input type="hidden" name="action" value="approve"><input type="hidden" name="id"
                value="${current.receiptId}">
              <button type="submit" class="inline-flex items-center gap-2 bg-success text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-success/90 transition-colors">
                <svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6 9 17l-5-5"/></svg>
                Duyệt phiếu nhập
              </button>
            </form>
            <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/receipts"
              onsubmit="return confirm('Xóa phiếu nhập này?')">
              <input type="hidden" name="action" value="delete"><input type="hidden" name="id"
                value="${current.receiptId}">
              <button type="submit" class="inline-flex items-center gap-2 bg-danger text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-danger/90 transition-colors">
                <span class="material-symbols-outlined text-[16px]">delete</span> Xóa phiếu
              </button>
            </form>
          </div>
        </c:if>
      </c:when>

      <c:otherwise>
        <!-- List -->
        <div class="bg-white rounded-xl border border-border-light shadow-sm p-6 max-w-2xl">
          <h3 class="text-section-header font-section-header text-on-surface mb-4 flex items-center gap-2">
            <span class="material-symbols-outlined text-secondary text-lg">add_box</span>
            Tạo phiếu nhập
          </h3>
          <form method="post" action="${pageContext.request.contextPath}/admin/receipts">
            <input type="hidden" name="action" value="create">
            <div class="grid sm:grid-cols-2 gap-4">
              <div>
                <label class="block text-label-md font-label-md text-text-secondary mb-1">Nhà cung cấp</label>
                <input type="text" name="supplierName" required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
              </div>
              <div>
                <label class="block text-label-md font-label-md text-text-secondary mb-1">Ghi chú</label>
                <input type="text" name="remarks" class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
              </div>
            </div>
            <div class="flex items-center gap-3 mt-5">
              <button type="submit" class="bg-primary-container text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-primary transition-colors">+ Tạo phiếu nhập</button>
            </div>
          </form>
        </div>

        <div class="bg-white rounded-xl border border-border-light shadow-sm overflow-hidden">
          <div class="table-scroll">
            <table class="w-full border-collapse">
              <thead>
                <tr class="bg-surface-bright border-b border-border-light">
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Số</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Nhà cung cấp</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Người tạo</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Ngày tạo</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">SL</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Trạng thái</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider"></th>
                </tr>
              </thead>
              <tbody class="divide-y divide-border-light text-body-main font-body-main align-middle">
                <c:forEach var="r" items="${receipts}">
                  <tr class="hover:bg-slate-50 transition-colors">
                    <td class="px-4 py-3 text-text-secondary">#${r.receiptId}</td>
                    <td class="px-4 py-3">${r.supplierName}</td>
                    <td class="px-4 py-3">${r.createdBy.fullName}</td>
                    <td class="px-4 py-3 text-text-secondary">
                      <fmt:formatDate value="${r.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                    </td>
                    <td class="px-4 py-3 text-right">${r.totalQuantity}</td>
                    <td class="px-4 py-3">
                      <span class="inline-flex items-center px-2 py-1 rounded-full text-caption font-caption font-bold ${r.pending ? 'bg-warning-soft text-warning border border-warning/20' : 'bg-success-soft text-success border border-success/20'}">${r.pending ? 'Chờ duyệt' : 'Đã duyệt'}</span>
                    </td>
                    <td class="px-4 py-3 text-right whitespace-nowrap">
                      <a href="?view=${r.receiptId}" class="inline-flex items-center gap-1.5 border border-border-light text-text-secondary rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-surface-container-low transition-colors">
                        <span class="material-symbols-outlined text-[16px]">visibility</span> Chi tiết
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </c:otherwise>
    </c:choose>

  </div>
</div>

<%@ include file="_foot.jspf" %>