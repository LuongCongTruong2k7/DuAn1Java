<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <c:set var="pageTitle" value="Xuất kho" scope="request" />
      <c:set var="wsChannels" value="${not empty current ? 'issue-'.concat(current.issueId) : 'broadcast'}" />
      <%@ include file="_head.jspf" %>

        <c:choose>
          <c:when test="${not empty current}">
            <a class="btn gray sm" href="${pageContext.request.contextPath}/admin/issues">← Danh sách phiếu xuất</a>
            <h2>Phiếu xuất #${current.issueId}
              <span class="badge ${current.pending ? 'pending' : 'approved'}">${current.pending ? 'Chờ duyệt' : 'Đã
                duyệt'}</span>
            </h2>
            <div class="panel">
              <p><b>Người nhận:</b> ${current.recipient} &nbsp;|&nbsp;
                <b>Người tạo:</b> ${current.createdBy.fullName} &nbsp;|&nbsp;
                <b>Ngày tạo:</b>
                <fmt:formatDate value="${current.orderDate}" pattern="dd/MM/yyyy HH:mm" />
              </p>
              <c:if test="${!current.pending}">
                <p><b>Người duyệt:</b> ${current.approvedBy.fullName} &nbsp;|&nbsp;
                  <b>Ngày duyệt:</b>
                  <fmt:formatDate value="${current.approvalDate}" pattern="dd/MM/yyyy HH:mm" />
                </p>
              </c:if>
              <c:if test="${not empty current.remarks}">
                <p><b>Ghi chú:</b> ${current.remarks}</p>
              </c:if>
            </div>

            <c:if test="${current.pending}">
              <div class="panel">
                <form method="post" action="${pageContext.request.contextPath}/admin/issues">
                  <input type="hidden" name="action" value="addDetail"><input type="hidden" name="id"
                    value="${current.issueId}">
                  <div class="form-grid">
                    <div><label>Sản phẩm</label>
                      <select name="productId" required>
                        <option value="">-- Chọn sản phẩm --</option>
                        <c:forEach var="p" items="${products}">
                          <option value="${p.productId}">${p.productName} (${p.unitOfMeasurement})</option>
                        </c:forEach>
                      </select>
                    </div>
                    <div><label>Số lượng</label><input type="number" name="quantity" min="1" value="1" required></div>
                  </div>
                  <div class="actions"><button class="btn" type="submit">Thêm vào phiếu</button></div>
                </form>
              </div>
            </c:if>

            <table>
              <tr>
                <th>Sản phẩm</th>
                <th>ĐVT</th>
                <th class="r">Số lượng</th>
                <c:if test="${current.pending}">
                  <th style="width:90px"></th>
                </c:if>
              </tr>
              <c:forEach var="d" items="${current.details}">
                <tr>
                  <td>${d.product.productName}</td>
                  <td>${d.product.unitOfMeasurement}</td>
                  <td class="r">${d.quantity}</td>
                  <c:if test="${current.pending}">
                    <td class="r">
                      <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/issues">
                        <input type="hidden" name="action" value="removeDetail">
                        <input type="hidden" name="id" value="${current.issueId}">
                        <input type="hidden" name="productId" value="${d.product.productId}">
                        <button class="btn sm red" type="submit">Xóa</button>
                      </form>
                    </td>
                  </c:if>
                </tr>
              </c:forEach>
              <tr>
                <td colspan="2"><b>Tổng số lượng</b></td>
                <td class="r"><b>${current.totalQuantity}</b>
                </td>
                <c:if test="${current.pending}">
                  <td></td>
                </c:if>
              </tr>
            </table>

            <c:if test="${current.pending && currentUser.admin}">
              <div class="actions">
                <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/issues"
                  onsubmit="return confirm('Duyệt phiếu? Sau khi duyệt sẽ không sửa được nữa.')">
                  <input type="hidden" name="action" value="approve"><input type="hidden" name="id"
                    value="${current.issueId}">
                  <button class="btn green" type="submit">✔ Duyệt phiếu xuất</button>
                </form>
                <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/issues"
                  onsubmit="return confirm('Xóa phiếu xuất này?')">
                  <input type="hidden" name="action" value="delete"><input type="hidden" name="id"
                    value="${current.issueId}">
                  <button class="btn red" type="submit">Xóa phiếu</button>
                </form>
              </div>
            </c:if>
          </c:when>

          <c:otherwise>
            <div class="panel">
              <form method="post" action="${pageContext.request.contextPath}/admin/issues">
                <input type="hidden" name="action" value="create">
                <div class="form-grid">
                  <div><label>Người nhận</label><input type="text" name="recipient" required></div>
                  <div><label>Ghi chú</label><input type="text" name="remarks"></div>
                </div>
                <div class="actions"><button class="btn" type="submit">+ Tạo phiếu xuất</button></div>
              </form>
            </div>

            <table>
              <tr>
                <th style="width:60px">Số</th>
                <th>Người nhận</th>
                <th>Người tạo</th>
                <th>Ngày tạo</th>
                <th class="r">SL</th>
                <th>Trạng thái</th>
                <th style="width:90px"></th>
              </tr>
              <c:forEach var="r" items="${issues}">
                <tr>
                  <td>#${r.issueId}</td>
                  <td>${r.recipient}</td>
                  <td>${r.createdBy.fullName}</td>
                  <td>
                    <fmt:formatDate value="${r.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                  </td>
                  <td class="r">${r.totalQuantity}</td>
                  <td><span class="badge ${r.pending ? 'pending' : 'approved'}">${r.pending ? 'Chờ duyệt' : 'Đã
                      duyệt'}</span></td>
                  <td class="r"><a class="btn sm gray" href="?view=${r.issueId}">Chi tiết</a></td>
                </tr>
              </c:forEach>
            </table>
          </c:otherwise>
        </c:choose>
        <%@ include file="_foot.jspf" %>