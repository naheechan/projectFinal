<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
  <!-- plugins:js -->
  <script src="${path }/resources/admin/vendors/base/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page-->
  <script src="${path }/resources/admin/vendors/chart.js/Chart.min.js"></script>
  <script src="${path }/resources/admin/vendors/datatables.net/jquery.dataTables.js"></script>
  <script src="${path }/resources/admin/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
  <!-- End plugin js for this page-->
  <!-- inject:js -->
  <script src="${path }/resources/admin/js/off-canvas.js"></script>
  <script src="${path }/resources/admin/js/hoverable-collapse.js"></script>
  <script src="${path }/resources/admin/js/template.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="${path }/resources/admin/js/dashboard.js"></script>
  <script src="${path }/resources/admin/js/data-table.js"></script>
  <script src="${path }/resources/admin/js/jquery.dataTables.js"></script>
  <script src="${path }/resources/admin/js/dataTables.bootstrap4.js"></script>
  <!-- End custom js for this page-->
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://kit.fontawesome.com/27fabf8f47.js" crossorigin="anonymous"></script>