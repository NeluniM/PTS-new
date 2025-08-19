<div id="nav-col" style="height:700px;position:fixed;overflow-y: auto;overflow-x: hidden;">
	<section id="col-left" class="col-left-nano">
		<div id="col-left-inner" class="col-left-nano-content">
			<div id="user-left-box" class="clearfix hidden-sm hidden-xs">
				<%-- <img alt="" src="<c:url value="/resources/img/samples/user.png"/>"/>
				 --%><div class="user-box">
					<span class="name">
						<p style="font-family:verdana;font-size:15px"><strong>Welcome ${sessionScope.userNameUser}</strong></p>
					</span>
					<span class="status">
						 <button class="blinkbutton" onclick="viewUserRegister()"><i
						 		class="fa fa-user"></i> 
						 </button> Online
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
						<a href="dashboardSPS">
							<i class="fa fa-dashboard"></i>
							<span>SPS Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
					</li>
					
					
				<!-- 	<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-cubes"></i>
							<span>View Administrative Units</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewProvinces">
									View Provinces
								</a>
							</li>
							
							<li>
								<a href="viewAreas">
									View Areas
								</a>
							</li>
							
							<li>
								<a href="viewCSC">
									View CSCs
								</a>
							</li>
						</ul>
					</li>-->
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-table"></i>
							<span>Asset Information</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
					<li>
								<a href="dashboardAll">
									Tower Lines
								</a>
							</li>
							
							<li>
								<a href="PCBdashboard">
									Distribution Transformer
								</a>
							</li>
							<li>
								<a href="dashboardCom">
									Tower Lines - Combination View
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
									Line type
								</a>
							</li>
							
							<li>
								<a href="viewSupporttypes">
									Support type
								</a>
							</li>
							
							<li>
								<a href="viewConTypes">
									Conductor type
								</a>
							</li>
							
							<li>
								<a href="viewEarthConTypes">
									Earth Conductor type
								</a>
							</li>
							
							<li>
								<a href="viewInsulators">
									Insulator type
								</a>
							</li>
							
							<li>
								<a href="viewTowerConfigs">
									Tower Configuration
								</a>
							</li>
							
							<li>
								<a href="viewTowerInsulators">
									Tower Insulator
								</a>
							</li>
							
							<li>
								<a href="viewStatusTypes">
									Status Type
								</a>
							</li>
							
							<li>
								<a href="viewStatus">
									Status
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
									Line
								</a>
							</li>
							
							<li>
								<a href="viewSupportNew">
									Support
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
								<a href="">
									Tower Maintenance
								</a>
							</li>
							
							<li>
								<a href="#">
									Insulator Maintenance
								</a>
							</li>
						</ul>
					</li></ul></li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Data</span>
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
							
							<!-- <li>
								<a href="editTMnewComp">
									Completion Data
								</a>
							</li>
							 -->
							
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
					
					
					<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Validate Maintenance Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="editTMnew">
									Maintenance Data
								</a>
							</li>
							
							
						</ul>
					</li>
					 --><!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Maintenance Plan 2020</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="downloadPlan">
									Download
								</a>
							</li>
						  
								
						</ul>
						
						
					</li>
					 -->
					
					<!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Maintenance Data Completion</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="mntCompletion">
									Maintenance Data Completion
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
					
					 -->
						
					
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
										Hot Line Inspection
										</a>
									</li>
									<li>
										<a href="goToViewInsEstimate">
										Cold Line Inspection
										</a>
									</li>
									
									<li>
										<a href="goToViewInsEstimateHOT">
										Hot Line Maintenance
										</a>
									</li>
									<li>
										<a href="goToViewInsEstimateCOLD">
										Cold Line Maintenance
										</a>
									</li>
									<li>
										<a href="goToViewInsEstimateCIVIL">
										Cold Line Civil
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
					
					<!-- <li>
					
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Download</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="downloadAPK">
									Download APK
								</a>
							</li>
						  
								
						</ul>
						
						
					</li>	
					 -->
					
					<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Validate Line & Support</span>
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
						</ul>
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Validate Maintenance Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="editTMnew">
									Maintenance Data
								</a>
							</li>
							
							
						</ul>
					</li>
					 --><li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Maintenance Plan</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="downloadPlan">
									2020
								</a>
							</li>
						  
								
						</ul>
						
						
					</li>
					
					<!-- <li>
						
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
					 -->
					<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Completion</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<!-- <li>
								<a href="editTMnewComp">
									Add
								</a>
							</li>
							 --><li><a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Maintenance</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						<li>
								<a href="editTMnewApproveComplesion">
									Add
								</a>
							</li>
							<li>
								<a href="editTMnewApproveComplesionUpdate">
									Send for Validation
								</a>
							</li>
						
							</ul>
							</li>
						<li>
								<a href="viewCompletion?mode=HOTINS">
									Hot Line Inspections
								</a>
							</li>
							<li>
								<a href="viewCompletion?mode=COLINS">
									Cold Line Inspections
								</a>
							</li>
							<li>
								<a href="viewCompletion?mode=HOTMNT">
									Hot Line Maintenance
								</a>
							</li>
							<li>
								<a href="viewCompletion?mode=COLMNT">
									Cold Line Maintenance
								</a>
							</li>
							<li>
								<a href="viewCompletion?mode=COLCIV">
									Cold Line Civil
								</a>
							</li>
						  
							
							
						  <!-- <li>
								<a href="upSupport">
									Support
								</a>
							</li> 
					<li>
								<a href="upMNT">
									Maintenance
								</a>
							</li> 
						 -->
								
						</ul>
						
						
					</li>
					
					
						
					
					</ul>
					</li>
					<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Breakdown Maintenance</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="breakDownMNT">
									Inspeciton Estimate
								</a>
							</li>
							
							
						</ul>
					</li>
					 -->
					 <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Schedules & Reports</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<!-- <li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Schedule</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								
								<ul class="submenu">
							 -->		<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>P&HM Branch Schedules</span>
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
										Hot Line 
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=CLE">
										Cold Line
										</a>
									</li>
									
									<li>
										<a href="ViewScheduleAndReport?mode=TTWT">
										Tension  Towers without Tappings
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=CLC">
										Cold Line Civil
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=MW">
										Miscellaneous  Works
										</a>
									</li>
								</ul>
								</li>
								
										<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Provincial Schedules</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="ViewScheduleAndReport?mode=VR">
										Vegetation  Schedule
										</a>
									</li>
									<li>
										<a href="ViewScheduleAndReport?mode=MPL">
										Missing Parts
										</a>
									</li>
									
									
									<li>
										<a href="ViewScheduleAndReport?mode=EWOP">
										Electrical Works on Poles
										</a>
									</li>
									
									
								</ul>
								</li>
							<!-- </ul>
							</li>	
							 --><li>
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
										<a href="estimateSPSReport">
										SPS Reports
										</a>
									</li>
									<li>
										<a href="estimateStatus">
										SPS Estimate Status/Print
										</a>
									</li>
								
								
									<!-- <li>
										<a href="">
										Inspection History Report
										</a>
									</li>
								<li>
										<a href="ViewScheduleAndReport?mode=INTSUM">
										Interruption Request Summary Report
										</a>
									</li>
								 -->
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
											<!-- <li> 
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Tower Lines</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu"> -->
							<!-- <li>
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
							</li> --> 
						<li>
								<a href="ViewPESummaryReport?mode=PECIRCONT">
									Tower Lines
								</a>
							</li> 
					
								
						<!-- </ul>
						
						
					</li> -->
									
									
									
									
									
									<!-- <li>
										<a href="">
										Gantries
										</a>
									</li>
								<li>
										<a href="">
										Switches
										</a>
									</li>
									
									<li>
										<a href="">
										Pole Lines
										</a>
									</li> -->
								</ul>
						</li>
					
					 
					 
					<li>
						
							<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Activity Request</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
							<ul class="submenu"> 
						
						
						<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Inspection Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="breakDownMNT?mode=INS">
									Create Breakdown Estimate
								</a>
							</li>
						  <li>
								<a href="viewAllInspectionMntRequest?mode=INS">
									View Status
								</a>
							</li> 
					
						</ul>
					
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Maintenance Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="breakDownMNT?mode=MNT">
									Create Breakdown Estimate
								</a>
							</li>
						  <li>
								<a href="viewAllInspectionMntRequest?mode=MNT">
									View Status
								</a>
							</li> 
					
						</ul>
					
					</li>
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Interruption Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						<li>
								<a href="goToInterruptionRequest?mode=INTERRUPTION">
									Generate
								</a>
							</li> 
					
							
						  <li>
								<a href="viewAllInspectionMntRequest?mode=INT">
									View Status
								</a>
							</li> 
							<li>
										<a href="RequestStatus">
										
								
										View All Requests Status
										
										</a>
									</li>
					
					
						</ul>
					
					</li>
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Interruption Schedule</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						
							
						  <li>
								<a href="createIntScheduleViewPhm?mode=${province}&type=VIEW">
									View 
								</a>
							</li> 
							 <li>
								<a href="createIntScheduleRecommended?mode=${province}&type=VIEW">
									Recommended Schedule
								</a>
							</li> 
						
					
						</ul>
					
					</li>
					
					
					
					
					<li>
					</ul>
					</li>
					
					
					
					
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Download & Upload</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
					
					<li>
					
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Download</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="downloadAPK">
									Download APK
								</a>
							</li>
						  
								
						</ul>
						
						
					</li>	
					
					
					<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Upload</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						<li>
								<a href="uploadSupportImage">
									Support Image
								</a>
							</li> 
					
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
					
					</ul>
					</li>
					
					<li>
						<a href="WelcomeMMS">
							<i class="fa fa-power-off"></i>
							<span>Log Out</span>
							<span class="label label-info label-circle pull-right"></span>
						</a>
					</li>
						
						<!-- <a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Completion Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="mntCompletion">
									Add
								</a>
							</li>
						  <li>
								<a href="">
									Edit
								</a>
							</li> 
					<li>
								<a href="">
									Send for Validation
								</a>
							</li> 
						
								
						</ul> -->
						
						
					
					
					
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
					
				<!-- 	<li>
						<a href="MMS_Map">
							<i class="fa fa-map-marker"></i>
							<span>View Map</span>
						</a>
					</li>-->
					<!-- <li>
						<a href="viewReports">
							<i class="fa fa-table"></i>
							<span>Reports</span>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewLine">
									Hot Line
								</a>
							</li>
							
							<li>
								<a href="viewSupport">
									Cold Line
								</a>
							</li>
							
				</ul>
				</li>-->
			</div>

		</div>
	</section>
</div>