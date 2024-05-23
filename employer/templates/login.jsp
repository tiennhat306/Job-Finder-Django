<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Tuyển dụng nhanh chóng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="candidate/img/logo_title.png">

        <!-- App css -->
        <link href="employer/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="employer/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <link href="employer/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    </head>


    <body class="authentication-bg">

        <div class="home-btn d-none d-sm-block">
            <a href="CandidateHomepageServlet"><i class="fas fa-home h2 text-dark"></i></a>
        </div>

        <div class="account-pages mt-5 mb-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6 col-xl-5">
                        <div class="text-center">
                            <a href="EmployerHomepageServlet">
                                <span><img src="candidate/img/logo.png" alt="" height="22"></span>
                            </a>
                            <p class="text-muted mt-2 mb-4">JobFinder - Tìm kiếm việc làm nhanh chóng</p>
                        </div>
                        <div class="card">

                            <div class="card-body p-4">
                                
                                <div class="text-center mb-4">
                                    <h4 class="text-uppercase mt-0">Đăng nhập</h4>
                                </div>

                                <form id="login-form" action="CandidateLoginServlet" method="post">

                                    <div class="form-group mb-3">
                                        <label for="username">Địa chỉ Email</label>
                                        <input class="form-control" type="email" id="username" name="username" required="" placeholder="Nhập email của bạn">
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="password">Mật khẩu</label>
                                        <input class="form-control" type="password" required="" id="password" name="password" placeholder="Nhập mật khẩu của bạn">
                                    </div>

                                    <div class="form-group mb-3">
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input" id="checkbox-signin" checked>
                                            <label class="custom-control-label" for="checkbox-signin">Ghi nhớ đăng nhập</label>
                                        </div>
                                    </div>

                                    <div class="form-group mb-0 text-center">
                                        <button class="btn btn-primary btn-block" type="submit"> Đăng nhập </button>
                                    </div>

                                </form>

                            </div> <!-- end card-body -->
                        </div>
                        <!-- end card -->

                        <div class="row mt-3">
                            <div class="col-12 text-center">
                                <p> <a href="pages-recoverpw.html" class="text-danger ml-1"><i class="fa fa-lock mr-1"></i>Quên mật khẩu?</a></p>
                                <p class="text-white">Chưa có tài khoản? <a href="register.jsp" class="text-dark ml-1"><b>Đăng ký</b></a></p>
                            </div> <!-- end col -->
                        </div>
                        <!-- end row -->

                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- end container -->
        </div>
        <!-- end page -->
    

        <!-- Vendor js -->
        <script src="employer/assets/js/vendor.min.js"></script>

        <!-- App js -->
        <script src="employer/assets/js/app.min.js"></script>
        
    </body>
</html>