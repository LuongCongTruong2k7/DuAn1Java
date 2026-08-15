<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <c:set var="pageTitle" value="Danh mục" scope="request" />
      <c:set var="wsChannels" value="broadcast" />
      <%@ include file="_head.jspf" %>

        <c:if test="${not readOnly}">
          <div class="panel">
            <form method="post" action="${pageContext.request.contextPath}/admin/categories">
              <input type="hidden" name="id" value="${editing.categoryId}">
              <div class="form-grid">
                <div><label>Tên danh mục</label>
                  <input type="text" name="categoryName" value="${editing.categoryName}" placeholder="VD: Điện tử"
                    required>
                </div>
              </div>
              <div class="actions">
                <button class="btn" type="submit">${empty editing ? 'Thêm danh mục' : 'Cập nhật'}</button>
                <c:if test="${not empty editing}">
                  <a class="btn gray" href="${pageContext.request.contextPath}/admin/categories">Hủy</a>
                </c:if>
              </div>
            </form>
          </div>
        </c:if>

        <table>
          <tr>
            <th style="width:70px">ID</th>
            <th>Tên danh mục</th>
            <c:if test="${not readOnly}">
              <th style="width:160px"></th>
            </c:if>
          </tr>
          <c:forEach var="c" items="${categories}">
            <tr>
              <td>${c.categoryId}</td>
              <td>${c.categoryName}</td>
              <c:if test="${not readOnly}">
                <td class="r">
                  <a class="btn sm gray" href="?edit=${c.categoryId}">Sửa</a>
                  <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/categories"
                    onsubmit="return confirm('Xóa danh mục này?')">
                    <input type="hidden" name="action" value="delete"><input type="hidden" name="id"
                      value="${c.categoryId}">
                    <button class="btn sm red" type="submit">Xóa</button>
                  </form>
                </td>
              </c:if>
            </tr>
          </c:forEach>
        </table>
        <%@ include file="_foot.jspf" %>