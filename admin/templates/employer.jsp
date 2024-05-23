<%@ page import="DTO.EmployerSessionItem" %>
<%@ page import="DTO.UpdatedJobBoardItem" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.AdminSessionItem" %>
<%@ page import="DTO.EmployerItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>
    Danh sách nhà tuyển dụng
  </title>
  <link rel="shortcut icon" type="image/x-icon" href="candidate/img/logo_title.png">
  <link href="employer/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
  <link href="employer/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
  <link href="employer/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <link
            href="employer/assets/libs/toastr/toastr.min.css"
            rel="stylesheet"
            type="text/css"
    />

    <style>
        .form-group {
            display: inline-block;
        }


        p {
            font-family: 'Roboto', sans-serif;
            color: #71b6f9;
            font-size: 16px;
            font-weight: normal;
        }

        label {
            display: inline-block;
            font-family: 'Roboto', sans-serif;
            text-transform: uppercase;
            margin-bottom: 10px;
            font-weight: bold;
            font-size: 16px;
            margin-left: 2px;
        }

        .input-box{
            position: relative;
        }

        select {
            padding: 9px 0;
        }
    </style>
</head>
<body>
<div id="wrapper">
  <%
    AdminSessionItem admin = (AdminSessionItem) session.getAttribute("adminSession");
    if(admin == null){
      response.sendRedirect("../ErrorServlet");
      return;
    }
  %>
  <!-- Topbar Start -->
  <jsp:include page="layout/topbar.jsp"></jsp:include>
  <!-- end Topbar -->

  <!-- ========== Left Sidebar Start ========== -->
  <jsp:include page="layout/sidebar.jsp"></jsp:include>
  <!-- Left Sidebar End -->

  <!-- ============================================================== -->
  <!-- Start Page Content here -->
  <!-- ============================================================== -->

  <div class="content-page">
    <!-- content start -->
    <div class="content">
      <!-- Start Content-->
      <div class="container-fluid">
        <!-- content goes here -->
      <%--        -------------------------------------------------------------------------------------------%>
        <div class="row">
          <div class="col-12">
            <div class="card-box">
              <h3 class="mt-0 mb-2">Danh sách nhà tuyển dụng</h3>
              <div class="row">
                <div class="col-md-2 mb-1">
                  <a href="EmployerViewServlet">
                    <i class="dripicons-clockwise"> Tải lại </i>
                  </a>
                </div>
              </div>

              <form id="form-filter" method="GET" class="form-inline">
                <div class="row" id="employer-management" data-id="<%= admin.getId() %>">
                  <div class="form-group">
                    <div class="col-md-1 mb-1 ml-0 pl-0 mb-1 ml-auto form-group">
                      <div class="form-group app-search-box">
                        <div class="input-group">
                          <%
                            String search = (String) request.getAttribute("search");
                            if (search == null) { %>
                          <input
                                  type="text"
                                  class="form-control"
                                  name="search"
                                  placeholder="Nhập tên để tìm kiếm..."
                          />
                          <% } else { %>
                          <input
                                  type="text"
                                  class="form-control"
                                  name="search"
                                  value="<%= search %>"
                                  placeholder="Nhập tên để tìm kiếm..."
                          />
                          <% } %>
                          <div class="input-group-append bg-primary">
                            <button class="btn" type="submit">
                              <i class="fe-search"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </form>

              <div class="table-responsive">
                <table id="jobboard-table" class="table table-bordered table-hover mb-0 text-center">
                  <thead class="thead-dark">
                  <tr>
                    <th>ID</th>
                    <th>Tên công ty</th>
                    <th>Số liên hệ</th>
                    <th>Địa chỉ</th>
                  </tr>
                  </thead>
                  <tbody>
                  <%
                    List<EmployerItem> employerList = (List<EmployerItem>) request.getAttribute("employerList");
                    if (employerList.size() != 0) { %>
                    <% for (EmployerItem employer : employerList) { %>
                  <tr >
                    <th scope="row"><%= employer.getId() %></th>
                    <td><%= employer.getCompanyName() %></td>
                    <td><%= employer.getCompanyAddress() %></td>
                    <td><%= employer.getContactNumber() %></td>
                  </tr>
                  <% } %> <% } else { %>
                  <tr>
                    <td colspan="7" class="text-center">
                      <h4>Không có dữ liệu</h4>
                    </td>
                  </tr>
                  <% } %>
                  </tbody>
                </table>
                <!-- pagination -->
                <div class="row pt-2">
                  <div class="col-12">
                    <nav aria-label="...">
                      <% int current = (int) request.getAttribute("current"); %>
                        <% int pages = (int) request.getAttribute("pages"); %>
                      <% if (pages > 0) { %>
                      <ul class="pagination text-center">
                        <% if (current == 1) { %>
                        <li class="page-item disabled">
                          <a class="page-link" href="#" tabindex="-1">Đầu</a>
                        </li>
                        <% } else { %>
                        <li class="page-item">
                          <a
                                  class="page-link"
                                  href="EmployerViewServlet?page=1&search=<%=search%>"
                                  tabindex="-1"
                          >
                            Đầu
                          </a>
                        </li>
                        <% } %>
                        <% var i = current > 5 ? current - 4 : 1; %> <% if (i != 1) { %>
                        <li class="page-item disabled">
                          <a class="page-link">...</a>
                        </li>
                        <% } %> <% for (; i <= pages && i <= current + 4; i++) {
                      %> <% if (i == current) { %>
                        <li class="page-item active">
                          <a class="page-link"><%=i%></a>
                        </li>
                        <% } else { %>
                        <li class="page-item">
                          <a
                                  class="page-link"
                                  href="EmployerViewServlet?page=<%= i %>&search=<%=search%>"
                          ><%=i%>
                          </a>
                        </li>
                        <% } %> <% if (i == current + 4 && i < pages ) { %>
                        <li class="page-item disabled">
                          <a class="page-link">...</a>
                        </li>
                        <% } %> <% } %> <% if (current == pages) { %>
                        <li class="page-item disabled">
                          <a class="page-link">Cuối</a>
                        </li>
                        <% } else { %>
                        <li class="page-item">
                          <a
                                  class="page-link"
                                  href="EmployerViewServlet?page=<%= pages %>&search=<%=search%>"
                          >
                            Cuối
                          </a>
                        </li>
                        <% } %>
                      </ul>
                      <% } %>
                    </nav>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
          
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
      <script src="employer/assets/js/vendor.min.js"></script>
      <script src="employer/assets/js/app.min.js"></script>
      <script src="employer/assets/libs/toastr/toastr.min.js"></script>
      <script src="employer/assets/js/pages/toastr.init.js"></script>
          
      </div>
      <!-- container-fluid -->
    </div>

    <!-- Footer Start -->
    <jsp:include page="layout/footer.jsp"></jsp:include>
    <!-- end Footer -->
  </div>

  <!-- ============================================================== -->
  <!-- End Page content -->
  <!-- ============================================================== -->
</div>


</body>
</html>

