<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Danh mục" scope="request"/>
<c:set var="wsChannels" value="broadcast"/>
<%@ include file="_head.jspf" %>

<div class="flex-1 overflow-y-auto p-page-padding-x py-page-padding-y">
  <div class="max-w-7xl mx-auto space-y-margin-lg">

    <c:if test="${not readOnly}">
      <div class="bg-white rounded-xl border border-border-light shadow-sm p-6 max-w-2xl">
        <h3 class="text-section-header font-section-header text-on-surface mb-4 flex items-center gap-2">
          <span class="material-symbols-outlined text-secondary text-lg">${empty editing ? 'add_box' : 'edit_note'}</span>
          ${empty editing ? 'Thêm danh mục' : 'Cập nhật danh mục'}
        </h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/categories">
          <input type="hidden" name="id" value="${editing.categoryId}">
          <div>
            <label class="block text-label-md font-label-md text-text-secondary mb-1">Tên danh mục</label>
            <input type="text" name="categoryName" value="${editing.categoryName}" placeholder="VD: Điện tử"
              required class="w-full px-3 py-2 border border-border-light rounded-lg text-body-main font-body-main focus:outline-none focus:ring-2 focus:ring-primary-container/20 focus:border-primary-container bg-white">
          </div>
          <div class="flex items-center gap-3 mt-5">
            <button type="submit" class="bg-primary-container text-white rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-primary transition-colors">${empty editing ? 'Thêm danh mục' : 'Cập nhật'}</button>
            <c:if test="${not empty editing}">
              <a href="${pageContext.request.contextPath}/admin/categories" class="border border-border-light text-text-secondary rounded-lg px-4 py-2 text-body-main font-body-main hover:bg-surface-container-low transition-colors">Hủy</a>
            </c:if>
          </div>
        </form>
      </div>
    </c:if>

    <div class="bg-white rounded-xl border border-border-light shadow-sm overflow-hidden">
      <div class="table-scroll">
        <table class="w-full border-collapse">
          <thead>
            <tr class="bg-surface-bright border-b border-border-light">
              <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">ID</th>
              <th class="px-4 py-3 text-left text-table-head font-table-head text-text-secondary uppercase tracking-wider">Tên danh mục</th>
              <c:if test="${not readOnly}">
                <th class="px-4 py-3 text-right text-table-head font-table-head text-text-secondary uppercase tracking-wider"></th>
              </c:if>
            </tr>
          </thead>
          <tbody class="divide-y divide-border-light text-body-main font-body-main align-middle">
            <c:forEach var="c" items="${categories}">
              <tr class="hover:bg-slate-50 transition-colors">
                <td class="px-4 py-3 text-text-secondary">${c.categoryId}</td>
                <td class="px-4 py-3">${c.categoryName}</td>
                <c:if test="${not readOnly}">
                  <td class="px-4 py-3 text-right whitespace-nowrap">
                    <div class="inline-flex items-center gap-1.5">
                      <a href="?edit=${c.categoryId}" class="inline-flex items-center gap-1.5 border border-border-light text-text-secondary rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-surface-container-low transition-colors">
                        <span class="material-symbols-outlined text-[16px]">edit</span> Sửa
                      </a>
                      <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/categories"
                        onsubmit="return confirm('Xóa danh mục này?')">
                        <input type="hidden" name="action" value="delete"><input type="hidden" name="id"
                          value="${c.categoryId}">
                        <button type="submit" class="inline-flex items-center gap-1.5 bg-danger text-white rounded-lg px-2.5 py-1 text-[13px] font-body-main hover:bg-danger/90 transition-colors">
                          <span class="material-symbols-outlined text-[16px]">delete</span> Xóa
                        </button>
                      </form>
                    </div>
                  </td>
                </c:if>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<%@ include file="_foot.jspf" %>