<div id="nav-col" style="position:fixed;overflow-y: auto;overflow-x: hidden;">
	<section id="col-left" class="col-left-nano">
		<div id="col-left-inner" class="col-left-nano-content">
			<div id="user-left-box" class="clearfix hidden-sm hidden-xs">
				<img alt="" src="<c:url value="/resources/img/samples/user.png"/>"/>
				<div class="user-box">
					<span class="name">
						<p style="font-family:verdana;font-size:15px"><strong>Welcome ${sessionScope.userNameUser}</strong></p>
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
							<i class="fa fa-table"></i>
							<span>View Line Master Data </span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
					
							<li>
								<a href="viewLinetypes">
									View Line type
								</a>
							</li>
							
							<li>
								<a href="viewSupporttypes">
									View Support type
								</a>
							</li>
							
							<li>
								<a href="viewConTypes">
									View Conductor type
								</a>
							</li>
							
							<li>
								<a href="viewEarthConTypes">
									View Earth Conductor type
								</a>
							</li>
							
							<li>
								<a href="viewInsulators">
									View Insulator type
								</a>
							</li>
							
							<li>
								<a href="viewTowerConfigs">
									View Tower Configuration
								</a>
							</li>
							
							<li>
								<a href="viewTowerInsulators">
									View Tower Insulator
								</a>
							</li>
							
							<li>
								<a href="viewStatusTypes">
									View Status Type
								</a>
							</li>
							
							<li>
								<a href="viewStatus">
									View Status
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
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-sliders"></i>
							<span>View Maintenance Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewTowerMaintenance">
									Tower Maintenance
								</a>
							</li>
							
							<li>
								<a href="#">
									Insulator Maintenance
								</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Approve Line & Support</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewLine">
									Approve Line
								</a>
							</li>
							
							<li>
								<a href="viewSupport">
									Approve Support
								</a>
							</li>
						</ul>
					</li>
					<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Approve</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewLine">
									Approve Maintenance Data
								</a>
							</li>
							
							<li>
								<a href="viewSupport">
									Approve Inspection Estimate
								</a>
							</li>
							<li>
								<a href="viewSupport">
									Approve Maintenance Estimate
								</a>
							</li>
						</ul>
					</li>-->
					
					<li>
						<a href="MMS_Map">
							<i class="fa fa-map-marker"></i>
							<span>View Map</span>
						</a>
					</li>
					
					<li>
						<a href="viewTowerMaintenance">
							<i class="fa fa-table"></i>
							<span>Reports</span>
						</a>
					</li>
					
					
					
					
					
				</ul>
			</div>

		</div>
	</section>
</div>