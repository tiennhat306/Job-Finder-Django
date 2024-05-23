<%@ page import="DTO.JobListInfoItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.City" %>
<%@ page import="model.bean.Career" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="DTO.CandidateSessionItem" %>
<%@ page import="DTO.CVDataItem" %>
<%@ page import="enums.CVStatus" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Danh sách CV</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="candidate/img/logo_title.png">
    <!-- Place favicon.ico in the root directory -->

    <!-- CSS here -->
    <link rel="stylesheet" href="candidate/css/bootstrap.min.css">
    <link rel="stylesheet" href="candidate/css/owl.carousel.min.css">
    <link rel="stylesheet" href="candidate/css/magnific-popup.css">
    <link rel="stylesheet" href="candidate/css/font-awesome.min.css">
    <link rel="stylesheet" href="candidate/css/themify-icons.css">
    <link rel="stylesheet" href="candidate/css/nice-select.css">
    <link rel="stylesheet" href="candidate/css/flaticon.css">
    <link rel="stylesheet" href="candidate/css/jquery-ui.css">
    <link rel="stylesheet" href="candidate/css/gijgo.css">
    <link rel="stylesheet" href="candidate/css/animate.min.css">
    <link rel="stylesheet" href="candidate/css/slicknav.css">

    <link rel="stylesheet" href="candidate/css/style.css">
    <!-- <link rel="stylesheet" href="css/responsive.css"> -->
</head>

<body>
<!--[if lte IE 9]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
<![endif]-->

<!-- header-start -->
<header>
    <div class="header-area ">
        <div id="sticky-header" class="main-header-area">
            <div class="container-fluid ">
                <div class="header_bottom_border">
                    <div class="row align-items-center">
                        <div class="col-xl-2 col-lg-2">
                            <div class="logo">
                                <a href="CandidateHomepageServlet">
                                    <img src="candidate/img/logo.png" alt="" style="max-height: 80px">
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-6 col-lg-7">
                            <div class="main-menu  d-none d-lg-block">
                                <nav>
                                    <ul id="navigation">
                                        <li><a href="CandidateHomepageServlet">Trang chủ</a></li>
                                        <li><a href="JobListServlet">Tìm việc làm</a></li>
                                        <li><a href="#">Hồ sơ & CV <i class="ti-angle-down"></i></a>
                                            <ul class="submenu">
                                                <li><a href="#">Quản lý CV </a></li>
                                                <li><a href="#">Mẫu CV </a></li>
                                                <li><a href="#">Hướng dẫn viết CV theo ngành nghề</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="#">Công ty <i class="ti-angle-down"></i></a>
                                            <ul class="submenu">
                                                <li><a href="#">Danh sách công ty</a></li>
                                                <li><a href="#">Top nhà tuyển dụng</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="#">Hỗ trợ</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <div class="col-xl-4 col-lg-4 d-none d-lg-block">
                            <div class="Appointment">
                                <%
                                    CandidateSessionItem candidateSession = (CandidateSessionItem) session.getAttribute("candidateSession");
                                    if (candidateSession == null) {
                                %>
                                <div class="phone_num d-none d-xl-block">
                                    <a href="CandidateLoginServlet">Log in</a>
                                </div>

                                <div class="phone_num d-none d-xl-block ml-2">
                                    <a href="CandidateSignUpServlet">Sign up</a>
                                </div>
                                <%
                                } else {
                                %>
                                <div class="d-flex align-items-center">
                                    <div class="phone_num d-none d-xl-block">
                                        <a href="CandidateLogoutServlet">
                                            <i class="fe-log-out"></i>
                                            <span>Đăng xuất</span>
                                        </a>
                                    </div>
                                    <div class="thumb">
                                        <img src="<%=candidateSession.getAvatar()%>" alt=""
                                             width="40px" height="40px" class="rounded-circle">
                                    </div>
                                    <span
                                            style="font-weight: bold; font-size: 20px; margin-left: 5px; margin-right: 15px; color: white;"><%=candidateSession.getName()%></span>
                                </div>
                                <%
                                    }
                                %>
                                <div class="d-none d-lg-block">
                                    <a href="AnotherLoginServlet" class="boxed-btn3">Người
                                        dùng khác</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="mobile_menu d-block d-lg-none"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</header>
<%--<!-- header-end -->--%>

<%--<!-- bradcam_area  -->--%>
<div class="bradcam_area bradcam_bg_1">
    <div class="container">
        <div class="row">
            <div class="col-xl-12">
                <div class="bradcam_text">
                    <h3>Đơn xin việc đã gửi</h3>
                </div>
            </div>
        </div>
    </div>
</div>
<!--/ bradcam_area  -->

<!-- job_listing_area_start  -->
<div class="job_listing_area plus_padding">
    <div class="container">
        <div class="table-responsive">
            <table id="jobboard-table" class="table table-bordered table-hover mb-0 text-center">
                <thead class="thead-dark">
                <tr>
                    <th>Tên công việc</th>
                    <th>Tên ứng viên</th>
                    <th>Số điện thoại</th>
                    <th>Email</th>
                    <th>Gửi lúc</th>
                    <th>Trạng thái</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<CVDataItem> list = (ArrayList<CVDataItem>) request.getAttribute("listCVCandidate");
                    if (list.size() != 0) {
                %>
                <% for (int i = 0; i < list.size(); ++i) { %>
                <tr >
                    <td><%= list.get(i).getTitle() %></td>
                    <td><%= list.get(i).getNameCandidate() %></td>
                    <td><%= list.get(i).getPhone() %></td>
                    <td><%= list.get(i).getEmail() %></td>
                    <td><%= new SimpleDateFormat("dd/MM/yyyy").format(list.get(i).getCreated_time()) %></td>
                    <% if (CVStatus.getByValue(list.get(i).getStatus()) == CVStatus.KIEM_TRA_HO_SO) { %>
                    <td class="text-secondary">Chờ xử lý</td>
                    <% } else if (CVStatus.getByValue(list.get(i).getStatus()) == CVStatus.DA_DUYET) { %>
                    <td class="text-primary">Đã duyệt</td>
                    <% } else if (CVStatus.getByValue(list.get(i).getStatus()) == CVStatus.TU_CHOI) { %>
                    <td class="text-danger">Từ chối</td>
                    <% } %>
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
        </div>
    </div>
</div>
<!-- job_listing_area_end  -->

<!-- footer start -->
<jsp:include page="layout/footer.jsp"></jsp:include>

<!-- link that opens popup -->
<!-- JS here -->
<script src="candidate/js/vendor/modernizr-3.5.0.min.js"></script>
<script src="candidate/js/vendor/jquery-1.12.4.min.js"></script>
<script src="candidate/js/popper.min.js"></script>
<script src="candidate/js/bootstrap.min.js"></script>
<script src="candidate/js/owl.carousel.min.js"></script>
<script src="candidate/js/isotope.pkgd.min.js"></script>
<script src="candidate/js/ajax-form.js"></script>
<script src="candidate/js/waypoints.min.js"></script>
<script src="candidate/js/jquery.counterup.min.js"></script>
<script src="candidate/js/imagesloaded.pkgd.min.js"></script>
<script src="candidate/js/scrollIt.js"></script>
<script src="candidate/js/jquery.scrollUp.min.js"></script>
<script src="candidate/js/wow.min.js"></script>
<script src="candidate/js/nice-select.min.js"></script>
<script src="candidate/js/jquery.slicknav.min.js"></script>
<script src="candidate/js/jquery.magnific-popup.min.js"></script>
<script src="candidate/js/plugins.js"></script>
<!-- <script src="js/gijgo.min.js"></script> -->
<script src="candidate/js/range.js"></script>



<!--contact js-->
<script src="candidate/js/contact.js"></script>
<script src="candidate/js/jquery.ajaxchimp.min.js"></script>
<script src="candidate/js/jquery.form.js"></script>
<script src="candidate/js/jquery.validate.min.js"></script>
<script src="candidate/js/mail-script.js"></script>


<script src="candidate/js/main.js"></script>


<script>
    window.onload = function() {
        var urlParams = new URLSearchParams(window.location.search);
        var searchText = urlParams.get('searchText');
        if (searchText) {
            document.querySelector('input[name="searchText"]').value = searchText;
        }
    }
    function goToPage(index) {
        // Lấy URL hiện tại
        var currentUrl = window.location.href;

        // Tách các tham số truy vấn thành một mảng
        var urlParts = currentUrl.split('?');
        var baseUrl = urlParts[0];
        var queryParams = urlParts[1] ? urlParts[1].split('&') : [];

        // Tạo một mảng mới để lưu trữ các tham số truy vấn đã cập nhật
        var updatedParams = [];

        // Lặp qua các tham số truy vấn hiện tại
        for (var i = 0; i < queryParams.length; i++) {
            var param = queryParams[i];
            var paramName = param.split('=')[0];

            // Kiểm tra xem tham số truy vấn có phải là 'index' hay không
            if (paramName === 'index') {
                // Bỏ qua tham số truy vấn 'index' hiện tại
                continue;
            }

            // Thêm tham số truy vấn khác vào mảng đã cập nhật
            updatedParams.push(param);
        }

        // Thêm tham số truy vấn 'index' mới vào mảng đã cập nhật
        updatedParams.push('index=' + index);

        // Xây dựng URL mới bằng cách kết hợp baseUrl và các tham số truy vấn đã cập nhật
        var newUrl = baseUrl + '?' + updatedParams.join('&');

        // Chuyển hướng đến URL mới
        window.location.href = newUrl;
    }
</script>
</body>

</html>