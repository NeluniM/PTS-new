<!-- <div id="nav-col"	style="height: 500px; position: fixed; overflow-y: auto;">
 -->	
 <div id="nav-col" style="height:700px;position:fixed;overflow-y: auto;overflow-x: hidden;">
 
 <section id="col-left" class="col-left-nano">
		<div id="col-left-inner" class="col-left-nano-content">
			<div id="user-left-box" class="clearfix hidden-sm hidden-xs">
				<%-- <img alt="" src="<c:url value="/resources/img/samples/user.png"/>" />
				 --%><div class="user-box">
					<span class="name">
						<p style="font-family:verdana;font-size:15px">
							<strong>Welcome ${sessionScope.userNameUser}
							</strong>
						</p>
					</span> <span class="status"> <i class="fa fa-circle"></i> Online
					</span>
				</div>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse"
				id="sidebar-nav">
				<ul class="nav nav-pills nav-stacked">
					<li><a href="dashboard"> <i class="fa fa-dashboard"></i> <span>Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
					</a></li>
					
					<li>
						<a href="dashboardSPS">
							<i class="fa fa-dashboard"></i>
							<span>SPS Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
					</li>
					
					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-pencil-square-o"></i> <span>Asset Information</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
						
						<li>
								<a href="dashboardAll">
									Tower Lines - All Division
								</a>
							</li>
							
							<li>
								<a href="PCBdashboard">
									Distribution Transformer - All Division
								</a>
							</li>
							
					

					<!-- <li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-pencil-square-o"></i> <span>Add
								Administrative Units</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
							<li><a href="addProvince">Province </a></li>

							<li><a href="addArea">Area </a></li>

							<li><a href="addCSC">CSC </a></li>
						</ul></li>
 -->
					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Line Master Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="addLineType">Line type </a></li>

							<li><a href="addSupportType">Support type </a></li>

							<li><a href="addConductorType">Conductor type </a></li>

							<li><a href="addEarthConType">Earth Conductor type
							</a></li>

							<li><a href="addInsulatorType">Insulator type </a></li>

							<li><a href="addTowerConfig">Tower Configuration </a></li>

							<li><a href="addTowerInsulator">Tower Insulator </a></li>

							<li><a href="addStatusType">Status Type </a></li>

							<li><a href="addStatus">Status </a></li>

						</ul></li>

					
											

					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-retweet"></i> <span>View Line & Support</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
							<li><a href="viewLineNew">Line </a></li>

							<li><a href="viewSupportNew">Support </a></li>
						</ul></li>
						
						</ul></li>
		
		
		<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						
						
						<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Add</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Line</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addLine"> Add </a></li>
									<li><a href="displayLineNew"> Edit & Send for Validation </a></li>
								</ul></li>


							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Support</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSupport"> Add </a></li>
									<li><a href="displaySupportNew"> Edit & Send for Validation </a></li>
								</ul></li>
								
								<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Tower Maintenance</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="towerMaintenance"> Add </a></li>
									 --><li>
										<!-- 	<a href="editTowerMaintenance">--> <a href="editTMnew">

											Edit & Send for Validation </a>
									</li>


									<li><a href="viewTMnewApprove"> View </a></li>


								</ul></li>
								
<!-- <li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Gantry</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addGantry"> Add </a></li>
									<li><a href="addGantry"> Edit </a></li>
								</ul></li>
 -->



						</ul></li>
						
						<!-- <li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-pencil-square"></i> <span>Maintenance Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Tower Maintenance</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="towerMaintenance"> Add </a></li>
									<li>
											<a href="editTowerMaintenance"> <a href="editTMnew">

											Edit </a>
									</li>


									<li><a href="viewTMnewApprove"> View </a></li>


								</ul></li>

							<li><a href="insulatorMaintenance"> Insulator
									Maintenance </a></li>
						</ul></li>
 -->						
						
		
						

					
					
					
					<!-- <li>
						
						<a href="#" class="dropdown-toggle">
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
						
								
						</ul>
						
						
					</li> -->

					<!-- <li>
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
					</li>-->

				</ul>
				</li>
				
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
							<span>Download & Upload</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="downloadAPK">
									Download APK
								</a>
							</li>
							<li>
								<a href="uploadSupportImage">
									Upload Support Image
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
						
						
							<li>
								<a href="displaySupportTapping">
									Tapping
								</a>
							</li>
							
							<li>
								<a href="displaySupportTapping">
									SPS
								</a>
							</li>
						  
						  
						
								
						
					</ul>
					</li>
							
							
						  
								
						</ul>
						
						
					</li>	
			
					


				
						
			</div>

		</div>
	</section>
</div>