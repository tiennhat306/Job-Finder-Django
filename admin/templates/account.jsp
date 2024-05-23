<%@ page import="DTO.AdminSessionItem" %>
<%@ page import="model.bean.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>
    Cài đặt tài khoản
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
    .card-box {
      width: 100%;
      height: 100%;
      position: relative;
      top: 5px;
      overflow: auto;
    }

    /*.form-group {*/
    /*  display: inline-block;*/
    /*}*/

    #account-settings-form {
      min-height: 470px;
      background: #fff;
      margin: 0 auto;
      padding: 15px 30px;
      position: relative;
      box-shadow: 2px 5px 20px rgba(119, 119, 119, 0.5);
    }

    p {
      font-family: 'Roboto', sans-serif;
      color: #323a46;
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

    .rounded-circle.img-thumbnail.picture-form {
      display: block;
      width: 12vw;
      height: 12vw;
      position: absolute;
      top:0;
      right:10%;
    }

    .input-box {
      position: relative;
    }

    .before-input{
      max-width: fit-content;
      position: absolute;
      z-index: 1;
      font-size: 1.1em;
      left: 7px;
      top:50%;
      transform: translateY(-70%);

    }

    .after-input{
      max-width: fit-content;
      position: absolute;
      z-index: 1;
      font-size: 1.1em;
      right: 7px;
      top:50%;
      transform: translateY(-70%);

    }

    .col-sm-12.input-info{
      padding: 7px 14px 7px 34px;
      border: 1px solid #ccc;
      border-radius: 5px;
      margin-bottom: 10px;
    }

    .col-sm-12.input-info:focus {
      outline:none;
      border: 2px solid #71b6f9 !important;
      border-radius: 5px !important;
      box-shadow: 0 0 5px #71b6f9 !important;
    }

    input[type='password']{
      padding: 7px 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
      margin-bottom: 10px;
    }

    input[type='password']:focus {
      outline:none;
      border: 2px solid #71b6f9 !important;
      border-radius: 5px !important;
      box-shadow: 0 0 5px #71b6f9 !important;
    }

    select {
      padding: 9px 0;
    }

    input[type='radio'] {
      width: 20px;
      height: 20px;
      margin-right: 5px;
      position: relative;
      left: 1em;
      bottom: -5px;
    }

    .radioText {
      margin-left: 24px;
      font-weight: normal;
      font-size: 16px;
    }

    .radioBox {
      width: 110px;
      display: inline-block;
      margin-right: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
    }

    span.error {
      color: red;
      display: inline-block;
      font-size: 12px;
    }

    .btn.btn-sm.update-info-btn {
      text-transform: uppercase;
      padding: 7px 15px;
      margin-left: 25px;
      border-radius: 5px;
      cursor: pointer;
      box-shadow: 0px 2px 4px 0px rgb(0, 0, 0, 0.2);
      margin-top: 15px;
    }

    .btn.btn-sm.edit-btn {
      background-color: #ccc;
      color: #000000;
      padding: 7px 15px;
      margin-left: 10px;
      border-radius: 50px;
      border: 0;
      cursor: pointer;
      box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.2);
      margin-top: 27px;
    }

    .tabs {
      display: flex;
      position: relative;
    }
    .line {
      position: absolute;
      z-index: 1;
      bottom: 0;
      width: calc(50% - 12px);
      height: 3px;
      border-radius: 15px;
      background-color: #00a2ff;
      transition: all 0.2s ease;
    }
    .tab-item {
      padding: 16px 20px 11px 20px;
      font-size: 20px;
      text-align: center;
      color: #00b7ff;
      background-color: #fff;
      border-top-left-radius: 5px;
      border-top-right-radius: 5px;
      border-bottom: 5px solid transparent;
      opacity: 0.6;
      cursor: pointer;
      transition: all 0.5s ease;
    }
    .tab-icon {
      font-size: 24px;
      width: 32px;
      position: relative;
      top: 2px;
    }
    .tab-item:hover {
      opacity: 1;
      background-color: rgba(0, 162, 255, 0.05);
      border-color: rgba(0, 221, 255, 0.1);
    }
    .tab-item.active {
      opacity: 1;
    }

    .tab-pane {
      color: #333;
      display: none;
    }
    .tab-pane.active {
      display: block;
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
        <%
          Admin user = (Admin) request.getAttribute("admin");
          if (user == null) {
            response.sendRedirect("/error.jsp");
            return;
          }
        %>

        <div class="row">
          <div class="col-12">
            <div class="card-box">
              <h3>Cài đặt tài khoản</h3>
              <div class="row">
                <div class="col-12">
                  <form
                          id="account-settings-form"
                          class="form-horizontal"
                          enctype="multipart/form-data"
                  >
                    <div class="form-group col-12">
                      <!-- Tab items -->
                      <div class="form-group col-12 tabs">
                        <div class="tab-item col-sm-6 active">
                          <i class="tab-icon fas fa-user"></i>
                          Thông tin cá nhân
                        </div>
                        <div class="tab-item col-sm-6">
                          <i class="tab-icon fas fa-shield-alt"></i>
                          Mật khẩu và bảo mật
                        </div>
                        <div class="line"></div>
                      </div>

                      <!-- Tab content -->
                      <div class="form-group col-12 ">
                        <div class="personal-info tab-pane active">
                          <div class="form-group row col-12">
                            <div class="col-xl-6 col-md-12 d-inline-block">
                              <label for="name">Họ tên:</label>
                              <span
                                      class="error"
                                      id="name-error"
                              ></span>
                              <div class="input-box">
												<span class="before-input">
													<i class="fas fa-user-tag"></i>
												</span>
                                <input
                                        type="text"
                                        class="col-sm-12 input-info"
                                        id="name"
                                        name="name"
                                        placeholder="Họ và tên"
                                        value="<%= user.getName() %>"
                                />
                              </div>
                            </div>
                            <div class="form-group col-xl-6 col-md-12 picture-row">
                              <label>Ảnh:</label>
                              <div>
                                <input
                                        type="file"
                                        name="avatar"
                                        id="fileInput"
                                        accept="image/jpg, image/jpeg, image/png"
                                        style="margin-top:10px; max-width:95%; display:none;"
                                />
                                <label for="fileInput" class="btn btn-sm btn-primary" style="width: 90px;">Thay đổi</label>

                                <button id="remove-picture" class="btn btn-sm btn-secondary" style="width: 90px; margin-bottom:8px; margin-left:10px;">XÓA ẢNH</button>
                              </div>
                              <div>
                                <% if (user.getAvatar() != null && !user.getAvatar().equals("")) { %>
                                <img
                                        id="preview"
                                        src="<%= user.getAvatar() %>"
<%--                                        src="https://api.dicebear.com/6.x/initials/svg?seed=<%= user.getName() %>"--%>

                                        alt="user-image"
                                        class="rounded-circle img-thumbnail picture-form"
                                />
                                <% } else { %>
                                <img
                                        id="preview"
                                        src="https://api.dicebear.com/6.x/initials/svg?seed=<%= user.getName() %>"
                                        alt="avatar"
                                        class="rounded-circle img-thumbnail picture-form"
                                />

                                <% } %>

                              </div>
                            </div>
                          </div>
                          <div class="form-group row col-12">
                            <div class="col-xl-6 col-md-12">
                              <label for="birthday"
                              >Ngày sinh:</label
                              >
                              <span
                                      class="error"
                                      id="birthday-error"
                              ></span>
                              <div class="input-box">
												<span class="before-input">
													<i class="fas fa-calendar"></i>
												</span>
                                <input
                                        type="date"
                                        class="col-sm-12 input-info"
                                        id="birthday"
                                        name="birthday"
                                        value="<%= user.getBirthday() %>"
                                />
                              </div>

                            </div>
                            <div class="col-xl-6 col-md-12">
                              <label>
                                Giới tính:
                              </label>
                              <span
                                      class="error"
                                      id="gender-error"
                              ></span>
                              <br />
                              <div class="radioBox">
                                <input
                                        type="radio"
                                        class="col-sm-12"
                                        id="male"
                                        name="gender"
                                        value="1"
                                        <% if (user.isGender()) { %>
                                        checked
                                        <% } %>
                                />
                                <label
                                        class="radioText"
                                        for="male"
                                >Nam</label
                                >
                              </div>
                              <div class="radioBox">
                                <input
                                        type="radio"
                                        class="col-sm-12"
                                        id="female"
                                        name="gender"
                                        value="0"
                                        <% if (!user.isGender()) { %>
                                        checked
                                        <% } %>
                                />
                                <label
                                        class="radioText"
                                        for="female"
                                >Nữ</label
                                >
                              </div>
                            </div>
                          </div>
                          <div class="form-group row col-12">

                            <div class="col-xl-6 col-md-12">
                              <label for="phone_number"
                              >Số điện thoại:</label
                              >
                              <span
                                      class="error"
                                      id="phone-error"
                              ></span>
                              <span>
												<i class=""></i>
											</span>
                              <div class="input-box">
												<span class="before-input">
													<i class="fas fa-phone"></i>
												</span>
                                <input
                                        type="number"
                                        class="col-sm-12 input-info"
                                        id="phone_number"
                                        name="phone_number"
                                        placeholder="Số điện thoại"
                                        value="<%= user.getPhoneNumber() %>"
                                />
                              </div>
                            </div>
                            <div class="col-xl-6 col-md-12">
                              <label for="email">Email:</label>
                              <span
                                      class="error"
                                      id="email-error"
                              ></span>
                              <div class="input-box">
												<span class="before-input">
													<i class="fas fa-envelope"></i>
												</span>
                                <input
                                        type="text"
                                        class="col-sm-12 input-info"
                                        id="email"
                                        name="email"
                                        placeholder="email@gmail.com"
                                        value="<%= user.getEmail() %>"
                                />
                              </div>
                            </div>
                          </div>
                          <div
                                  class="form-group row"
                                  style="
											display: flex;
											justify-content: start;
											align-items: center;
										"
                          >
                            <button
                                    type="button"
                                    id="save-btn"
                                    class="btn btn-sm btn-primary update-info-btn"
                            >
                              Cập nhật
                            </button>
                          </div>
                        </div>

                        <div class="login-info tab-pane">
                          <div class="form-group row col-12">
                            <div class="col-8">
                              <div>
                                <i
                                        class="tab-icon mdi mdi-account-circle"
                                        style="color: #333"
                                ></i>
                                <label for="username"
                                >Tài khoản đăng nhập</label
                                >
                                <span
                                        class="error"
                                        id="username-error"
                                ></span>
                              </div>
                              <div class="input-box">
												<span class="before-input">
													<i class="fas fa-user-edit"></i>
												</span>
                                <input
                                        type="text"
                                        class="col-sm-12 input-info"
                                        id="username"
                                        name="username"
                                        style="outline: none;"
                                        placeholder="Tên đăng nhập"
                                        value="<%= user.getUsername() %>"
                                        disabled
                                />
                              </div>

                            </div>
                            <div class="col-4">
                              <button
                                      class="btn btn-sm edit-btn"
                                      id="edit-username-btn"
                              >
                                Chỉnh sửa
                              </button>
                              <div
                                      id="confirm-edit-username-btn"
                                      style="display: none"
                              >
                                <button
                                        type="reset"
                                        id="cancel-username-btn"
                                        class="btn btn-sm edit-btn"
                                        style="
														display: inline-block;
													"
                                >
                                  Hủy
                                </button>
                                <button
                                        type="submit"
                                        id="save-username-btn"
                                        class="btn btn-sm edit-btn"
                                        style="
														display: inline-block;
													"
                                >
                                  Lưu
                                </button>
                              </div>
                            </div>
                          </div>
                          <div class="form-group row col-12">
                            <div class="col-8">
                              <div>
                                <i
                                        class="tab-icon fas fa-key fa-lg"
                                ></i>
                                <label
                                >Đổi mật khẩu</label
                                >
                                <span
                                        class="error"
                                        id="password-error"
                                ></span>
                              </div>

                              <p style="margin-left: 0.2em">
                                Bạn nên sử dụng mật khẩu mạnh mà
                                mình chưa sử dụng ở đâu khác
                              </p>
                              <div
                                      class="col-12"
                                      id="change-password-form"
                                      style="display: none"
                              >
                                <table style="border: 0">
                                  <tbody>
                                  <tr>
                                    <td align="right">
                                      Mật khẩu cũ:
                                    </td>
                                    <td>
                                      <input
                                              type="password"
                                              class="col-sm-12"
                                              id="old-password"
                                              name="old_password"
                                              placeholder="Mật khẩu hiện tại"
                                      />
                                    </td>
                                    <td>
                                      <span
                                              class="error"
                                              id="old-password-error"
                                      ></span>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right">
                                      Mật khẩu mới:
                                    </td>
                                    <td>
                                      <input
                                              type="password"
                                              class="col-sm-12"
                                              id="new-password"
                                              name="new_password"
                                              placeholder="Mật khẩu mới"
                                      />
                                    </td>
                                    <td>
																<span
                                                                        class="error"
                                                                        id="new-password-error"
                                                                ></span>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td align="right">
                                      Xác nhận mật
                                      khẩu:
                                    </td>
                                    <td>
                                      <input
                                              type="password"
                                              class="col-sm-12"
                                              id="confirm-password"
                                              name="confirm_password"
                                              placeholder="Xác nhận mật khẩu"
                                      />
                                    </td>
                                    <td>
                                      <span
                                              class="error"
                                              id="confirm-password-error"
                                      ></span>
                                    </td>
                                  </tr>
                                  </tbody>
                                </table>
                                <div>
                                  <button
                                          type="reset"
                                          class="btn btn-sm edit-btn"
                                          id="cancel-password-btn"
                                  >
                                    Hủy
                                  </button>
                                  <button
                                          type="submit"
                                          class="btn btn-sm edit-btn"
                                          id="save-password-btn"
                                  >
                                    Lưu
                                  </button>
                                </div>
                              </div>
                            </div>
                            <div class="col-4">
                              <button
                                      class="btn btn-sm edit-btn"
                                      id="change-password-btn"
                              >
                                Chỉnh sửa
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
          
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="employer/assets/js/vendor.min.js"></script>
<script src="employer/assets/js/app.min.js"></script>
<script src="employer/assets/libs/toastr/toastr.min.js"></script>
<script src="employer/assets/js/pages/toastr.init.js"></script>

<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>--%>

<script>
  $(document).ready(function () {
    $('#fileInput').change(function() {
      var input = this;
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
          $('#preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]); // convert to base64 string
      }
    });
    $('#remove-picture').click(function(e){
      // prevent default action
      e.preventDefault();

      console.log('remove');
      $('#preview').attr('src', 'https://api.dicebear.com/6.x/initials/svg?seed=<%= user.getName() %>');
        $('#fileInput').val('');
    });

    const tabs = $('.tab-item');
    const panes = $('.tab-pane');

    const tabActive = $('.tab-item.active');
    const line = $('.tabs .line');

    tabs.each(function (index, tab) {
      const pane = panes.eq(index);

      $(tab).click(function () {
        $('.tab-item.active').removeClass('active');
        $('.tab-pane.active').removeClass('active');

        line.css('left', $(this)[0].offsetLeft + 'px');

        $(this).addClass('active');
        pane.addClass('active');
      });
    });

    $(window).resize(function () {
      const tabActive = $('.tab-item.active');

      line.css('left', tabActive[0].offsetLeft + 'px');
    });

    const form = $('#account-settings-form');


    toastr.options = {
      closeButton: true,
      debug: false,
      newestOnTop: false,
      progressBar: false,
      positionClass: 'toast-bottom-left',
      preventDuplicates: true,
      onclick: null,
      showDuration: '300',
      hideDuration: '1000',
      timeOut: '5000',
      extendedTimeOut: '1000',
      showEasing: 'swing',
      hideEasing: 'linear',
      showMethod: 'fadeIn',
      hideMethod: 'fadeOut',
    };

    function successNotify(){
      let form = $('#account-settings-form')[0];
      // let data = new FormData(form);

      const name = $('#name').val();
      // const avatar = $('#preview').attr('src');
      const email = $('#email').val();
      const phone_number = $('#phone_number').val();
      // const gender =
      let gender = '';
      $('input[name="gender"]').each(function (index, item) {
        if ($(item).prop('checked')) {
          gender = $(item).val();
        }
      });
      const birthday = $('#birthday').val();
      const username = $('#username').val();
      const oldPassword = $('#old-password').val();
      const newPassword = $('#new-password').val();
      const confirmPassword = $('#confirm-password').val();

        var data = {
            name:  name,
            // avatar: avatar,
            email: email,
            phone_number: phone_number,
            gender: gender,
            birthday: birthday,
            username: username,
            old_password: oldPassword,
            new_password: newPassword,
            confirm_password: confirmPassword,
        }
        console.log(data);
      $.ajax({
        method: 'POST',
        url: 'AdminAccountServlet',
        type: 'post',
        data: data,
        // encode: true,
        // enctype: 'multipart/form-data',
        // processData: false,
        // contentType: false,
        success: function (response) {
          console.log(response.error);

          if(response.error){
            toastr['error'](
                    'Không thể cập nhật tài khoản này',
                    'Thất bại'
            );
            return;
          } else {
            toastr['success'](
                    'Cập nhật tài khoản thành công',
                    'Thành công'
            );
          }
        },
        error: function (xhr, status, error) {
          toastr['error'](
                  'Không thể cập nhật tài khoản này',
                  'Thất bại'
          );
        },
      });

    }

    $('#save-btn').click(function (e)  {
      e.preventDefault();

      let valid = true;

      if ($('#name').val() === '') {
        valid = false;
        $('#name-error').html('Vui lòng nhập tên người dùng');
      } else {
        $('#name-error').html('');
      }

      let selectedGender = '';
      $('input[name="gender"]').each(function (index, item) {
        if ($(item).prop('checked')) {
          selectedGender = $(item).val();
        }
      });
      if (selectedGender === '') {
        valid = false;
        $('#gender-error').html('Giới tính không hợp lệ');
      } else {
        $('#gender-error').html('');
      }

      if ($('#birthday').val() === '') {
        valid = false;
        $('#birthday-error').html('Ngày sinh không hợp lệ');
      } else {
        $('#birthday-error').html('');
      }

      if ($('#phone_number').val() === '' || $('#phone_number').val().length < 10) {
        valid = false;
        $('#phone-error').html('Số điện thoại không hợp lệ');
      } else {
        $('#phone-error').html('');
      }

      if ($('#email').val() === '') {
        valid = false;
        $('#email-error').html('Vui lòng nhập email');
      } else if (!$('#email').val().match(/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/)) {
        valid = false;
        $('#email-error').html('Email không hợp lệ');
      } else {
        $('#email-error').html('');
      }

      if (valid) {
        successNotify();
      }
    });

    form.on('reset', function (e) {
      e.preventDefault;
      $('.error').each(function (index, item) {
        $(item).html('');
      });
    });

    const editUsernameButton = $('#edit-username-btn');
    const cancelUsernameButton = $('#cancel-username-btn');
    const saveUsernameButton = $('#save-username-btn');
    const usernameInput = $('#username');

    const changePasswordForm = $('#change-password-form');
    const changePasswordButton = $('#change-password-btn');
    const cancelPasswordButton = $('#cancel-password-btn');
    const savePasswordButton = $('#save-password-btn');

    editUsernameButton.click(function (e) {
      e.preventDefault();
      editUsernameButton.hide();
      usernameInput.prop('disabled', false);
      usernameInput.focus();
      $('#confirm-edit-username-btn').show();
    });

    cancelUsernameButton.click(function () {
      editUsernameButton.show();
      usernameInput.prop('disabled', true);
      $('#confirm-edit-username-btn').hide();
    });

    saveUsernameButton.click(function (e) {
      e.preventDefault();
      if (usernameInput.val() === '') {
        $('#username-error').html('Tên người dùng không hợp lệ');
        return;
      } else {
        $('#username-error').html('');
        successNotify();
      }
      usernameInput.prop('disabled', true);
      $('#confirm-edit-username-btn').hide();
      editUsernameButton.show();
    });

    changePasswordButton.click(function (e) {
      e.preventDefault();

      changePasswordButton.hide();
      changePasswordForm.show();
    });

    cancelPasswordButton.click(function () {
      changePasswordButton.show();
      changePasswordForm.hide();
    });

    savePasswordButton.click(function (e) {
      e.preventDefault();

      let valid = true;

      const oldPasswordInput = $('#old-password').val();
      const newPasswordInput = $('#new-password').val();
      const confirmPasswordInput = $('#confirm-password').val();

      if (oldPasswordInput === '') {
        valid = false;
        $('#old-password-error').html('Vui lòng nhập mật khẩu cũ');
      } else {
        $('#old-password-error').html('');
      }
      if (newPasswordInput === '') {
        valid = false;
        $('#new-password-error').html('Vui lòng nhập mật khẩu mới');
      }
      else if (!newPasswordInput.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,}$/)) {

        valid = false;
        $('#new-password-error').html('Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ và số, chứa ký tự đặc biệt');
      }
      else {
        $('#new-password-error').html('');
      }
      if (confirmPasswordInput === '') {
        valid = false;
        $('#confirm-password-error').html('Vui lòng nhập lại mật khẩu mới');
      } else {
        $('#confirm-password-error').html('');
      }

      if (
              newPasswordInput !== '' &&
              !confirmPasswordInput !== '' &&
              newPasswordInput !== confirmPasswordInput
      ) {
        valid = false;
        $('#confirm-password-error').html('Mật khẩu không khớp');
      }

      if (valid) {
        successNotify();
        changePasswordButton.show();
        changePasswordForm.hide();
      }
    });
  });
</script>
</body>
</html>

