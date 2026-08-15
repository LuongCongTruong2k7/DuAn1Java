<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <c:set var="pageTitle" value="Báo cáo" scope="request" />
      <c:set var="wsChannels" value="broadcast" />
      <%@ include file="_head.jspf" %>

        <div class="toolbar">
          <a class="btn ${type=='stock' ? '' : 'gray'}" href="?type=stock">Tồn kho hiện tại</a>
          <a class="btn ${type=='flow' ? '' : 'gray'}" href="?type=flow">Nhập / xuất theo kỳ</a>
        </div>

        <c:choose>
          <c:when test="${type=='flow'}">
            <div class="panel">
              <form method="get" style="display:flex;gap:10px;align-items:end;flex-wrap:wrap">
                <input type="hidden" name="type" value="flow">
                <div><label>Từ ngày</label><input type="date" name="from" value="${from}"></div>
                <div><label>Đến ngày</label><input type="date" name="to" value="${to}"></div>
                <button class="btn" type="submit">Xem</button>
              </form>
            </div>
            <table>
              <tr>
                <th>Sản phẩm</th>
                <th>ĐVT</th>
                <th class="r">Nhập trong kỳ</th>
                <th class="r">Xuất trong kỳ</th>
                <th class="r">Chênh lệch</th>
              </tr>
              <tbody id="flowBody">
                <c:forEach var="f" items="${flow}">
                  <tr>
                    <td>${f.productName}</td>
                    <td>${f.unit}</td>
                    <td class="r ok-text">+${f.received}</td>
                    <td class="r danger">-${f.issued}</td>
                    <td class="r">${f.net}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:when>
          <c:otherwise>
            <table>
              <tr>
                <th>Sản phẩm</th>
                <th>ĐVT</th>
                <th class="r">Tổng nhập</th>
                <th class="r">Tổng xuất</th>
                <th class="r">Tồn kho</th>
                <th class="r">Min</th>
                <th class="r">Max</th>
                <th>Cảnh báo</th>
              </tr>
              <tbody id="stockBody">
                <c:forEach var="s" items="${stock}">
                  <tr>
                    <td>${s.productName}</td>
                    <td>${s.unit}</td>
                    <td class="r">${s.received}</td>
                    <td class="r">${s.issued}</td>
                    <td class="r"><b>${s.stock}</b></td>
                    <td class="r">${s.minStock}</td>
                    <td class="r">${s.maxStock}</td>
                    <td>
                      <c:if test="${s.low}"><span class="badge pending">Dưới mức tối thiểu</span></c:if>
                      <c:if test="${s.over}"><span class="badge off">Vượt mức tối đa</span></c:if>
                      <c:if test="${!s.low && !s.over}"><span class="ok-text">✓</span></c:if>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:otherwise>
        </c:choose>
        <%@ include file="_foot.jspf" %>