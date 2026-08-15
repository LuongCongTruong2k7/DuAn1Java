<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <c:set var="pageTitle" value="Tổng quan" scope="request" />
      <c:set var="wsChannels" value="broadcast" />
      <%@ include file="_head.jspf" %>
        <div class="cards">
          <div class="card">
            <div class="ic blue"><a href="${pageContext.request.contextPath}/admin/products">📋</a></div>
            <div>
              <div class="num">${productCount}</div>Sản phẩm
            </div>
          </div>
          <div class="card">
            <div class="ic violet"><a href="${pageContext.request.contextPath}/admin/categories">🗂️</a></div>
            <div>
              <div class="num">${categoryCount}</div>Danh mục
            </div>
          </div>
          <c:if test="${currentUser.admin}">
            <div class="card">
              <div class="ic rose"><a href="${pageContext.request.contextPath}/admin/users">👥</a></div>
              <div>
                <div class="num">${userCount}</div>Nhân viên
              </div>
            </div>
          </c:if>
          <div class="card">
            <div class="ic green"><a href="${pageContext.request.contextPath}/admin/receipts">📥</a></div>
            <div>
              <div class="num">${pendingReceipts}</div>Phiếu nhập chờ duyệt
            </div>
          </div>
          <div class="card">
            <div class="ic amber"><a href="${pageContext.request.contextPath}/admin/issues">📤</a></div>
            <div>
              <div class="num">${pendingIssues}</div>Phiếu xuất chờ duyệt
            </div>
          </div>
        </div>

        <h2>⚠️ Sản phẩm dưới mức tồn tối thiểu</h2>
        <c:choose>
          <c:when test="${empty lowStock}">
            <p class="muted">Không có sản phẩm nào dưới mức tồn tối thiểu.</p>
          </c:when>
          <c:otherwise>
            <table>
              <tr>
                <th>Sản phẩm</th>
                <th>ĐVT</th>
                <th class="r">Tồn kho</th>
                <th class="r">Tồn tối thiểu</th>
              </tr>
              <c:forEach var="s" items="${lowStock}">
                <tr>
                  <td>${s.productName}</td>
                  <td>${s.unit}</td>
                  <td class="r danger">${s.stock}</td>
                  <td class="r">${s.minStock}</td>
                </tr>
              </c:forEach>
            </table>
          </c:otherwise>
        </c:choose>
        <%@ include file="_foot.jspf" %>