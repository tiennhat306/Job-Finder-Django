<div class="navbar-custom">
  <ul class="list-unstyled topnav-menu float-right mb-0">
    <li class="d-none  d-sm-block">
      <div>
        <a href="/" class="nav-link waves-effect d-flex">
          <i class="mdi mdi-home" style="font-size: 30px"></i>
          <span>Cho người tìm việc</span>
        </a>
      </div>
    </li>
    <li class="dropdown notification-list">
      <a
              class="nav-link dropdown-toggle nav-user mr-0 waves-effect"
              data-toggle="dropdown"
              href="#"
              role="button"
              aria-haspopup="false"
              aria-expanded="false"
      >
      {% if request.COOKIES.avatar != null and request.COOKIES.avatar != '' %}
        <img
                src="{{ request.COOKIES.avatar }}"
                alt="user-image"
                class="rounded-circle"
        />
        {% else %}
        <img
                src="https://api.dicebear.com/6.x/initials/svg?seed={{ request.COOKIES.name }}"
                alt="user-image"
                class="rounded-circle"
        />
        {% endif %}

        <span class="pro-user-name ml-1">
					{{request.COOKIES.name}}
					<i class="mdi mdi-chevron-down"></i>
				</span>
      </a>
      <div class="dropdown-menu dropdown-menu-right profile-dropdown">
        <!-- item-->
        <div class="dropdown-header noti-title">
          <h6 class="text-overflow m-0">Xin chào !</h6>
        </div>

        <!-- item-->
        <a href="/admin/account" class="dropdown-item notify-item">
          <i class="fe-user"></i>
          <span>Tài khoản</span>
        </a>

        <div class="dropdown-divider"></div>

        <!-- item-->
        <a href="/admin/logout" class="dropdown-item notify-item">
          <i class="fe-log-out"></i>
          <span>Đăng xuất</span>
        </a>
      </div>
    </li>
  </ul>

  <!-- LOGO -->
  <div class="logo-box">
    <a href="/" class="logo text-center">
			<span class="logo-lg">
				<img src="{%static 'candidate/img/logo.png' %}" alt="" height="32" />
			</span>
    </a>
  </div>

  <ul class="list-unstyled topnav-menu topnav-menu-left m-0">
    <li>
      <button class="button-menu-mobile disable-btn waves-effect">
        <i class="fe-menu"></i>
      </button>
    </li>
  </ul>
</div>

