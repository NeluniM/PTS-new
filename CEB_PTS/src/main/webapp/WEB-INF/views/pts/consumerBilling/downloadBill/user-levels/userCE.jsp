<div id="nav-col" style="position:fixed;overflow-y: auto;overflow-x: hidden;">
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
					
				<!-- 	<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-pencil"></i>
							<span>View Administrative Units</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="addProvince">
									View Provinces
								</a>
							</li>
							
							<li>
								<a href="addArea">
									View Areas
								</a>
							</li>
							
							<li>
								<a href="addCSC">
									View CSCs
								</a>
							</li>
						</ul>
					</li>-->
					
				
					
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
								<a href="viewLineNew">
									View Line
								</a>
							</li>
							
							<li>
								<a href="viewSupportNew">
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
								<a href="viewTMnewApprove">
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
							<span>Maintenance Planning</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Data to be Approved</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="displayLineNew">
										Line
										</a>
									</li>
									<li>
										<a href="displaySupportNew">
										Support
										</a>
									</li>
									<li>
										<a href="editTMnew">
										Maintenance Data
										</a>
									</li>
								</ul>
							</li>
							<li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Approved Data</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="displayLineApprove">
										Line
										</a>
									</li>
									<li>
										<a href="displaySupportApprove">
										Support
										</a>
									</li>
									<li>
										<a href="editTMnewApprove">
										Maintenance Data
										</a>
									</li>
								</ul>
							</li>
							<li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Work Estimates</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<!-- <li>
										<a href="viewDDForInsEstimate">
										Inspection Estimate
										</a>
									</li> -->
									<li>
										<a href="goToViewInsEstimate">
										Inspection Estimate
										</a>
									</li>
									<li>
										<a href="goToViewInsEstimateHOT">
										HotLine Maintenance Estimate
										</a>
									</li>
									<li>
										<a href="goToViewInsEstimateCOLD">
										Cold Line Estimate
										</a>
									</li>
								</ul>
								</li>
								<li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Inprogress</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								</li>
								<li>
							<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Completion Data Approval</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
							</li>
							<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>History Analysis</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewTowerMaintenance">
									Cycle Wise Data Storage
								</a>
							</li>
						<li>
								<a href="viewTowerMaintenance">
									Tower Line Failure Rates
								</a>
							</li>
					
						
								
						</ul>
						
						
					</li>
						<li>
						<a href="upload">
							<i class="fa fa-retweet"></i>
							<span>Breakdown Maintenance</span>
						</a>
					
					</li>
					<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Upload</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="uploadFormLine">
									Line
								</a>
							</li>
						  <li>
								<a href="upSupport">
									Support
								</a>
							</li> 
					<li>
								<a href="upMNT">
									Maintenance
								</a>
							</li> 
						
								
						</ul>
						
						
					</li>
						<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Manage Cycle</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="addCycle">
									Cycle
								</a>
							</li>
						  
								
						</ul>
						
						
					</li>	
						</ul>
						</li>
						
						<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Schedule & Report</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Schedule</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								
								<ul class="submenu">
									<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>PMH Branch Schedule</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										
								<!-- 		<li>
										<a href="#" class="dropdown-toggle">
										<i class="fa fa-retweet"></i>
										<span>Hot Line Maintenance</span>
										<i class="fa fa-chevron-circle-right drop-icon"></i>
										</a>
										<ul class="submenu">
										<li>
										<a href="ViewScheduleAndReport?mode=HOTLINEALL">
										Hot Line Maintenance - Last Avarage
										</a>
										</li>
										<li>
										<a href="ViewScheduleAndReport?mode=HOTLINE2019">
										Hot Line Maintenance - 2019
										</a>
										</li>
										<li>
										<a href="ViewScheduleAndReport?mode=HOTLINE2018">
										Hot Line Maintenance - 2018
										</a>
										</li>
										
										</ul>
										
										
										
										
									</li> -->
									<li>
										<a href="ViewScheduleAndReport?mode=HOTLINE">
										Hot Line Maintenance
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=TTWT">
										Tension Tower Without Tapping
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=CLE">
										Cold Line Electrical
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=CLC">
										Cold Line Civil
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=MW">
										Miscellaneous Works
										</a>
									</li>
								</ul>
								</li>
								
										<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Provincial Schedule</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="ViewScheduleAndReport?mode=EWOP">
										Electrical Works On Poles
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=VR">
										Vegitation Schedule
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=MPL">
										Missing Parts Schedule
										</a>
									</li>
									
									
								</ul>
								</li>
							</ul>
							</li>	
							<li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Reports</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
								<li>
										<a href="ViewScheduleAndReport?mode=TP">
										Tapping Detail Report
										</a>
									</li>
									<li>
										<a href="">
										Insapection History Report
										</a>
									</li>
								
								</ul>
							</li>	
						</ul>
						</li>
						<li>
						
							<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>P&E Summary</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
							<ul class="submenu"> 
								<!-- <li>
										<a href="viewTowerLine">
										Tower Lines
										</a>
									</li>-->
											<li> 
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Tower Lines</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="ViewPESummaryReport?mode=PELT">
									Line Type
								</a>
							</li>
						  <li>
								<a href="ViewPESummaryReport?mode=PECONT">
									Conductor Type
								</a>
							</li> 
					<li>
								<a href="ViewPESummaryReport?mode=PECIRT">
									Circuit Type
								</a>
							</li> 
						
								
						</ul>
						
						
					</li>
									
									
									
									
									
									<li>
										<a href="ViewScheduleAndReport?mode=TTWT">
										Gantries
										</a>
									</li>
								<li>
										<a href="ViewScheduleAndReport?mode=TTWT">
										Switches
										</a>
									</li>
									
									<li>
										<a href="ViewScheduleAndReport?mode=TTWT">
										Pole Lines
										</a>
									</li>
								</ul>
						</li>
						
						
						
						
						
						
						
						
								
							<!-- 	<ul class="submenu">
									<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Reports</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="ViewScheduleAndReport?mode=HOTLINE">
										Electrical Works On Pin Poles
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=TTWT">
										Vegitation Schedule
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=CLE">
										Missing Parts Schedule
										</a>
									</li>
									
								</ul>
									
								</ul>-->
								
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
					
					<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-pencil"></i>
							<span>Line & Support</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="addLine">
									Add Line
								</a>
							</li>
							
							<li>
								<a href="addSupport">
									Add Support
								</a>
							</li>
						</ul>
					</li>-->
					
					<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-pencil"></i>
							<span>Add Maintenance Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="towerMaintenance">
									Tower Maintenance
								</a>
							</li>
							
							<li>
								<a href="insulatorMaintenance">
									Insulator Maintenance
								</a>
							</li>
						</ul>
					</li>-->
					<!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-pencil-square-o"></i>
							<span>Job Creation</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewDDForInsEstimate">
									Inspection Estimate
								</a>
							</li>
							
							<li>
								<a href="CreateMaintenanceEst">
									Maintenance Estimate
								</a>
							</li>
						</ul>
					</li>-->
					
					
						
					<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-pencil-square-o"></i>
							<span>Activity Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<!-- <li>
								<a href="viewNetWork">
									Network View
								</a>
							</li>
						 -->
							<li>
								<a href="#" class="dropdown-toggle">
								<i class="fa fa-pencil-square-o"></i>
								<span>Inspection Request</span>
								<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="">
										Area
										</a>
									</li>
									<li>
										<a href="">
										Line
										</a>
									</li>
								</ul>
							</li>
							<li>
								<a href="#" class="dropdown-toggle">
								<i class="fa fa-pencil-square-o"></i>
								<span>Interuption Request</span>
								<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="">
										Area
										</a>
									</li>
									<li>
										<a href="">
										Line
										</a>
									</li>
								</ul>
							</li>
							<li>
								<a href="#" class="dropdown-toggle">
								<i class="fa fa-pencil-square-o"></i>
								<span>PTW Request</span>
								<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="">
										Area
										</a>
									</li>
									<li>
										<a href="">
										Line
										</a>
									</li>
								</ul>
							</li>
								<li>
								<a href="#" class="dropdown-toggle">
								<i class="fa fa-pencil-square-o"></i>
								<span>Maintenance Cost</span>
								<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="MMS_Map">
										Area
										</a>
									</li>
									
								</ul>
							</li>
						</ul>
						
						
					</li>
					
				
					
					<!-- <li>
						<a href="viewNewMap">
							<i class="fa fa-map-marker"></i>
							<span>View Map</span>
						</a>
					</li>
					 -->
					
					
				<!-- 	<li>
						<a href="addUser">
							<i class="fa fa-user"></i>
							<span>Add Users</span>
						</a>
					</li>-->
					
				</ul>
			</div>

		</div>
	</section>
</div>