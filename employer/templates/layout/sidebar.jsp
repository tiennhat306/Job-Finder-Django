<div class="left-side-menu">
  <div
          class="slimScrollDiv active"
          style="position: relative; width: auto; height: 238px"
  >
    <div
            class="slimscroll-menu in"
            style="overflow: auto; width: auto; height: 238px"
    >
      <!-- User box -->
      <div class="user-box text-center">
        {% if request.COOKIES.avatar != null and request.COOKIES.avatar != '' %}
        <img
                src="{{ request.COOKIES.avatar }}"
                alt="user-img"
                title="Mat Helme"
                class="rounded-circle img-thumbnail avatar-lg"
        />
        {% else %}
        <img
                src="https://api.dicebear.com/6.x/initials/svg?seed={{ request.COOKIES.company_name }}"
                alt="user-img"
                title="Mat Helme"
                class="rounded-circle img-thumbnail avatar-lg"
        />
        {% endif %}

        <div class="dropdown">
          <a
                  href="#"
                  class="text-dark dropdown-toggle h5 mt-2 mb-1 d-block"
                  data-toggle="dropdown"
          >
          {{request.COOKIES.company_name}}
          </a>
        </div>
        <p class="text-muted">Nhà tuyển dụng</p>
      </div>

      <!--- Sidemenu -->
      <div id="sidebar-menu" class="active">
        <ul class="metismenu in" id="side-menu">
          <li class="menu-item">
            <a href="/employer/">
              <i class="fas fa-suitcase"></i>
              <span> Quản lý công việc </span>
            </a>
          </li>
          <li>
            <a href="CVManagementServlet">
                <i class="fas fa-file-alt"></i>
              <span> Quản lý CV </span>
            </a>
          </li>
        </ul>
      </div>
      <!-- End Sidebar -->

      <div class="clearfix"></div>
    </div>
    <div
            class="slimScrollBar"
            style="
				background: rgb(158, 165, 171);
				width: 8px;
				position: absolute;
				top: 85px;
				opacity: 0.4;
				display: none;
				border-radius: 7px;
				z-index: 99;
				right: 1px;
				height: 68.6594px;
			"
    ></div>
    <div
            class="slimScrollRail"
            style="
				width: 8px;
				height: 100%;
				position: absolute;
				top: 0px;
				display: none;
				border-radius: 7px;
				background: rgb(51, 51, 51);
				opacity: 0.2;
				z-index: 90;
				right: 1px;
			"
    ></div>
  </div>
  <!-- Sidebar -left -->
</div>


