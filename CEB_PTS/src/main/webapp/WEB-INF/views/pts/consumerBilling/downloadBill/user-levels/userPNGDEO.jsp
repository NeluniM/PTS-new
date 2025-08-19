<div id="nav-col" style="height: 500px;position:fixed;overflow-y: auto;">
	<section id="col-left" class="col-left-nano">
		<div id="col-left-inner" class="col-left-nano-content">
			<div id="user-left-box" class="clearfix hidden-sm hidden-xs">
				<img alt="" src="<c:url value="/resources/img/samples/user.png"/>"/>
				<div class="user-box">
					<span class="name">
						<p><strong>Welcome <br/>
						${sessionScope.userNameUser}</strong></p>
					</span>
					<span class="status">
						<i class="fa fa-circle"></i> Online
					</span>
				</div>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse" id="sidebar-nav">	
				<ul class="nav nav-pills nav-stacked">
					<li>
						<a href="dashboard">
							<i class="fa fa-dashboard"></i>
							<span>Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-pencil-square-o"></i>
							<span>Add Administrative Units</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="addProvince">
									Add Province
								</a>
							</li>
							
							<li>
								<a href="addArea">
									Add Area
								</a>
							</li>
							
							<li>
								<a href="addCSC">
									Add CSC
								</a>
							</li>
						</ul>
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-sliders"></i>
							<span>Customer Registration</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
					
							<li>
								<a href="addLineType">
									Add Customer
								</a>
							</li>
							
							

						</ul>
					</li>
					
							
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-sliders"></i>
							<span>Job Assign</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
					
							<li>
								<a href="jobAssign">
									Job Assign
								</a>
							</li>
							
							

						</ul>
					</li>
					
					<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-tasks"></i>
							<span>Line & Support</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							
							<li>
							<a href="#" class="dropdown-toggle">
								<i class="fa fa-pencil-square"></i>
								<span>Line</span>
								<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
							<ul class="submenu">
							<li>
								<a href="addLine">
									Add
								</a>
							</li>
							<li>
								<a href="editLine">
									Edit
								</a>
							</li>
							</ul>
							</li>
							
							
														<li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-pencil-square"></i>
									<span>Support</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
								<li>
									<a href="addSupport">
										Add
									</a>
								</li>
								<li>
									<a href="displaySupportNew">
										Edit
									</a>
								</li>
								</ul>
							</li>
							
							
						</ul>
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-pencil-square"></i>
							<span>Maintenance Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
							<a href="#" class="dropdown-toggle">
								<i class="fa fa-pencil-square"></i>
								<span>Tower Maintenance</span>
								<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
							<ul class="submenu">
							<li>
								<a href="towerMaintenance">
									Add
								</a>
							</li>
							<li>
								<a href="editTowerMaintenance">
									Edit
								</a>
							</li>
							</ul>
							</li>
							
							<li>
								<a href="insulatorMaintenance">
									Insulator Maintenance
								</a>
							</li>
						</ul>
					</li>
						<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>View Line & Support</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewLine">
									View Line
								</a>
							</li>
							
							<li>
								<a href="viewSupport">
									View Support
								</a>
							</li>
						</ul>
					</li>
					
					<li>
						<a href="MMS_Map">
							<i class="fa fa-map-marker"></i>
							<span>View Map</span>
						</a>
					</li>
					
					<li>
						<a href="GenerateReportNew">
							<i class="fa fa-table"></i>
							<span>Reports</span>
						</a>
					</li> -->
					
				</ul>
			</div>

		</div>
	</section>
</div>