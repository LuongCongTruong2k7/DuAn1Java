<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Báo cáo" scope="request"/>
<c:set var="wsChannels" value="broadcast"/>
<%@ include file="_head.jspf" %>

<div class="flex-1 overflow-y-auto p-page-padding-x py-page-padding-y">
  <div class="max-w-7xl mx-auto space-y-margin-lg">

    <div class="flex flex-wrap items-center gap-2">
      <a href="?type=stock" class="inline-flex items-center gap-2 rounded-lg px-4 py-2 text-body-main font-body-main transition-colors ${type=='stock' ? 'bg-primary-container text-white' : 'border border-border-light text-text-secondary hover:bg-surface-container-low'}">
        <span class="material-symbols-outlined text-[18px]">inventory_2</span> Tồn kho hiện tại
      </a>
      <a href="?type=flow" class="inline-flex items-center gap-2 rounded-lg px-4 py-2 text-body-main font-body-main transition-colors ${type=='flow' ? 'bg-primary-container text-white' : 'border border-border-light text-text-secondary hover:bg-surface-container-low'}">
        <span class="material-symbols-outlined text-[18px]">swap_vert</span> Nhập / xuất theo kỳ
      </a>
    </div>

    <c:choose>
      <c:when test="${type=='flow'}">
        <div class="bg-white rounded-xl border border-border-light shadow-sm p-6">
          <form method="get" class="flex flex-col sm:flex-row items-start sm:items-end gap-4 flex-wrap">
            <input type="hidden" name="type" value="flow">
            <div>
              <label class="block text-label-md font-label-md text-text-secondary mb-1">Từ ngày</label>
              <input type="date" name="from" value="${from}" class="px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
            </div>
            <div>
              <label class="block text-label-md font-label-md text-text-secondary mb-1">Đến ngày</label>
              <input type="date" name="to" value="${to}" class="px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
            </div>
            <button type="submit" class="bg-primary-container text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-primary transition-colors inline-flex items-center gap-2">
              <span class="material-symbols-outlined text-[18px]">search</span> Xem
            </button>
          </form>
        </div>
        <div class="bg-white rounded-xl border border-border-light shadow-sm overflow-hidden">
          <div class="table-scroll">
            <table class="w-full border-collapse">
              <thead>
                <tr class="bg-surface-bright border-b border-border-light">
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Sản phẩm</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">ĐVT</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Nhập trong kỳ</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Xuất trong kỳ</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Chênh lệch</th>
                </tr>
              </thead>
              <tbody id="flowBody" class="divide-y divide-border-light text-body-main font-body-main align-middle">
                <c:forEach var="f" items="${flow}">
                  <tr class="hover:bg-slate-50 transition-colors">
                    <td class="px-4 py-3">${f.productName}</td>
                    <td class="px-4 py-3 text-text-secondary">${f.unit}</td>
                    <td class="px-4 py-3 text-right text-success font-medium">+${f.received}</td>
                    <td class="px-4 py-3 text-right text-danger font-medium">-${f.issued}</td>
                    <td class="px-4 py-3 text-right">${f.net}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <div class="bg-white rounded-xl border border-border-light shadow-sm overflow-hidden">
          <div class="table-scroll">
            <table class="w-full border-collapse">
              <thead>
                <tr class="bg-surface-bright border-b border-border-light">
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Sản phẩm</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">ĐVT</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tổng nhập</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tổng xuất</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tồn kho</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Min</th>
                  <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider">Max</th>
                  <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Cảnh báo</th>
                </tr>
              </thead>
              <tbody id="stockBody" class="divide-y divide-border-light text-body-main font-body-main align-middle">
                <c:forEach var="s" items="${stock}">
                  <tr class="hover:bg-slate-50 transition-colors">
                    <td class="px-4 py-3">${s.productName}</td>
                    <td class="px-4 py-3 text-text-secondary">${s.unit}</td>
                    <td class="px-4 py-3 text-right text-text-secondary">${s.received}</td>
                    <td class="px-4 py-3 text-right text-text-secondary">${s.issued}</td>
                    <td class="px-4 py-3 text-right font-semibold text-on-surface">${s.stock}</td>
                    <td class="px-4 py-3 text-right text-text-secondary">${s.minStock}</td>
                    <td class="px-4 py-3 text-right text-text-secondary">${s.maxStock}</td>
                    <td class="px-4 py-3">
                      <c:if test="${s.low}"><span class="inline-flex items-center px-2 py-1 rounded-full text-caption font-caption font-bold bg-warning-soft text-warning border border-warning/20">Dưới mức tối thiểu</span></c:if>
                      <c:if test="${s.over}"><span class="inline-flex items-center px-2 py-1 rounded-full text-caption font-caption font-bold bg-surface-container text-text-secondary border border-border-light">Vượt mức tối đa</span></c:if>
                      <c:if test="${!s.low && !s.over}"><span class="text-success"><svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6 9 17l-5-5"/></svg></span></c:if>
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