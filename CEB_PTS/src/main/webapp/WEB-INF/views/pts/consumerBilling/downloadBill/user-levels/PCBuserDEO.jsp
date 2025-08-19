<div id="nav-col"
	style="height: 500px; position: fixed; overflow-y: auto;">
	<section id="col-left" class="col-left-nano">
		<div id="col-left-inner" class="col-left-nano-content">
			<div id="user-left-box" class="clearfix hidden-sm hidden-xs">
				<img alt="" src="<c:url value="/resources/img/samples/user.png"/>" />
				<div class="user-box">
					<span class="name">
						<p>
							<strong>Welcome <br /> ${sessionScope.loggedUser}
							</strong>
						</p>
					</span> <span class="status"> <i class="fa fa-circle"></i> Online
					</span>
				</div>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse"
				id="sidebar-nav">
				<ul class="nav nav-pills nav-stacked">
					<li><a href="PCB_dashboard"> <i class="fa fa-dashboard"></i> <span>Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
					</a></li>
					
					

					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Manage Equipment Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="addEquipment"> Add Equipment Info </a></li>

							<li><a href="editEquipment"> Edit Equipment Info </a></li>

							<li><a href="addInformationReatedSample">Manage
									Equipment Info </a></li>
							<li><a href="uploadEquipment">Upload
									Equipment Info </a></li>

						</ul></li>



				</ul>
			</div>

		</div>
	</section>
</div>