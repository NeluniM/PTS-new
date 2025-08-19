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
						<i class="fa fa-circle"></i> Online
					</span>
				</div>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse" id="sidebar-nav">	
				<ul class="nav nav-pills nav-stacked">
					<li>
						<a href="dashboardOther">
							<i class="fa fa-dashboard"></i>
							<span>Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Asset Information</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
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
							<li>
								<a href="SubstationView">
									View Substation Details
								</a>
							</li>
							
							
							<!-- <li>
								<a href="addCSC">
									View CSCs
								</a>
							</li> -->
						</ul>
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
					
				
					
					<!-- <li>
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
					
					
 -->					
				
				<!-- <li>
				<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Divisional Information</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						
				</li>
				 -->
				
				<c:if test="${sessionScope.loggedUserRole =='EEC' || sessionScope.loggedUserRole =='EE' || sessionScope.loggedUserRole =='CE' || sessionScope.loggedUserRole =='DGM'|| sessionScope.loggedUserRole =='AGM'}">

<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Transformer Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="addEquipment"> Add </a></li>

							<li><a href="editEquipment"> Edit</a></li>
							<!-- <li><a href="editEquipmentSampleNo"> Edit Transformer - Sample No </a></li>
							 -->

							<li><a href="viewTransformer">View
									</a></li>
	<!-- 						<li><a href="uploadEquipment">Upload
									Transformer </a></li>
									<li><a href="uploadEquipmentGPS">Upload
									GPS </a></li>
									<li><a href="uploadEquipmentSINNO">Upload
									SIN No </a></li>
	 -->								
									

						</ul>
						
						
						
						</li>
				

<!-- 				<li>
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
								<a href="addMVPole">
									MV Pole
								</a>
							</li>
							
							<li>
								<a href="">
									GSS
								</a>
							</li>
							
						  <li>
								<a href="displayMVPolesNew">
									Update MV Pole
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
								<a href="addMVPole">
									MV Pole
								</a>
							</li>
							
							<li>
								<a href="">
									GSS
								</a>
							</li>
							
						  <li>
								<a href="displayMVPolesNew">
									Update MV Pole
								</a>
							</li>
							
									</ul>
								</li>
								
																			

						
					
						
						</ul>
						
				</li> -->
				
								
				
										 <li>
					 <a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Schedule & Reports</span>
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
						 -->	<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Provincial Schedule</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="ViewProvincialScheduleOther?mode=VR">
										Vegetation Schedule
										</a>
									</li>
									<li>
										<a href="ViewProvincialScheduleOther?mode=MPL">
										Missing Parts Schedule
										</a>
									</li>
									
									<li>
										<a href="ViewProvincialScheduleOther?mode=EWOP">
										Electrical Works On Poles
										</a>
									</li>
									
									
								</ul>
								</li>
								
									
					
						<!-- </ul>
						</li>
						 --><!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Reports</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Reports</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="estimateSPSReport">
									SPS Reports
								</a>
							</li>
						 
									</ul>
								</li>
						
						</ul>
						</li>
					 -->
					
						
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
						<ul class="submenu">
							<li>
								<a href="ViewPESummaryReportOther?mode=PELT">
									Line Type
								</a>
							</li>
						  <li>
								<a href="ViewPESummaryReportOther?mode=PECONT">
									Conductor Type
								</a>
							</li> 
					<li>
								<a href="ViewPESummaryReportOther?mode=PECIRT">
									Circuit Type
								</a>
							</li> 
						 -->	<li>
								<a href="ViewPESummaryReportOther?mode=PECIRCONT">
									Tower Lines
								</a>
							</li> 
					
						
								
						<!-- </ul>
						
						
					</li>
					 -->
					
						
						
					
										
				</ul>
				</li>
				</c:if>
				
				<c:if test="${sessionScope.loggedUserRole =='ES' || sessionScope.loggedUserRole =='DEO'}">
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
							<span>Data to be Validate</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="displayMVPoleNew">
									MV Pole
								</a>
							</li>
							
							<!-- <li>
								<a href="">
									GSS
								</a>
							</li>
							 --></ul>
							</li>
							</ul>
							</li>
							</c:if>
			
							
						  <!-- <li>
								<a href="displayMVPolesNew">
									Update MV Pole
								</a>
							</li>
							 -->
																	<!-- <li>
							
							<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Approved Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="addMVPole">
									MV Pole
								</a>
							</li>
							
							<li>
								<a href="">
									GSS
								</a>
							</li>
							
						  <li>
								<a href="displayMVPolesNew">
									Update MV Pole
								</a>
							</li>
							
									</ul>
								</li>
							 -->	
								<!-- <li>
							
							<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Upload Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="upMvPole">
									MV Pole
								</a>
							</li>
							
							<li>
								<a href="">
									GSS
								</a>
							</li>
							
						  <li>
								<a href="displayMVPolesNew">
									Update MV Pole
								</a>
							</li>
							
									</ul>
								</li>
							
								<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Download APK</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="downloadAPK">
									Download
								</a>
							</li>
						  
								
						</ul>
						
						
					</li>	
					
						
						</ul>
						
				</li>
				 -->
				
				
				
					<!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Download APK</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="downloadAPK">
									Download
								</a>
							</li>
						  
								
						</ul>
						
						
					</li>
					 -->
					 
					 
					 	
					
				<%-- 
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
									<span>Interruption Request</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<c:if test="${sessionScope.loggedUserRole =='EE' || sessionScope.loggedUserRole =='PE' || sessionScope.loggedUserRole =='PCE' || sessionScope.loggedUserRole =='CE' || sessionScope.loggedUserRole =='DGM' || sessionScope.loggedUserRole =='EEC'}">
				
									<li>
										<a href="displayAllInsRequestAE?mode=${province}">
										Action on Request
										</a>
									</li>
									</c:if>
				
									
									
									<!-- <li>
										<a href="IntSumReportCC?mode=INTSUM">
										Interruption Request Summary Report
										</a>
									</li>
						 	 -->
									
									<!-- <li>
										<a href="manageIntRequestAE?mode=FWD">
										Forward Request
										</a>
									</li>
									 --><li>
										<a href="viewAllIntProvince?mode=${province}">
										View Status -Interruption Request
										</a>
									</li>
									<li>
										<a href="RequestStatusOther">
										
								
										View All Requests  Status
										
										
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
									
										<a href="createIntSchedule?mode=${province}">
										Interruption Schedule
										</a>
										<ul class="submenu">
										 <c:if test="${sessionScope.loggedUserRole =='DEO'}">
				
									<li>
										<a href="createIntSchedule?mode=${province}&type=EDIT">
										  Edit
										</a>
									</li>
									
									<li>
										<a href="createIntSchedule?mode=${province}&type=SFVDEO">
										  Send for Validation
										</a>
									</li>
									<li>
										<a href="createIntScheduleView?mode=${province}&type=VIEW">
										  View
										</a>
									</li>
									
									</c:if>
									
									<c:if test="${sessionScope.loggedUserRole =='ES'}">
				
									 <li>
										<a href="createIntSchedule?mode=${province}&type=EDIT">
										  Edit
										</a>
									</li>
									 
									<li>
										<a href="createIntSchedule?mode=${province}&type=SFVES">
										  Send for Validation
										</a>
									</li>
									<li>
										<a href="createIntScheduleView?mode=${province}&type=VIEW">
										  View
										</a>
									</li>
									
									</c:if>
									
									<c:if test="${sessionScope.loggedUserRole =='EE'}">
				
									 <li>
										<a href="createIntScheduleEdit?mode=${province}&type=EDIT">
										  Edit
										</a>
									</li>
									 
									<li>
										<a href="createIntSchedule?mode=${province}&type=SFVES">
										  Recommend & Forward
										</a>
									</li>
									</c:if>
									
									<c:if test="${sessionScope.loggedUserRole =='EEC'}">
				
									 <li>
										<a href="createIntScheduleEdit?mode=${province}&type=EDIT">
										  Edit
										</a>
									</li>
									 
									<li>
										<a href="createIntSchedule?mode=${province}&type=SFVES">
										  Recommend & Forward
										</a>
									</li>
									<li>
										<a href="createIntScheduleView?mode=${province}&type=VIEW">
										  View
										</a>
									</li>
									
									</c:if>
				
									<c:if test="${sessionScope.loggedUserRole =='PCE'}">
				
									<li>
										<a href="createIntSchedule?mode=${province}&type=EDIT">
										  Edit
										</a>
									</li>
									
									<li>
										<a href="createIntSchedule?mode=${province}&type=SFVES">
										  Recommend & Forward
										</a>
									</li>
									<li>
										<a href="createIntScheduleView?mode=${province}&type=VIEW">
										  View
										</a>
									</li>
									
									</c:if>
									<c:if test="${sessionScope.loggedUserRole =='PE'}">
				
									<li>
										<a href="createIntSchedule?mode=${province}&type=EDIT">
										  Edit
										</a>
									</li>
									
									<li>
										<a href="createIntSchedule?mode=${province}&type=SFVES">
										  Recommend & Forward
										</a>
									</li>
									<li>
										<a href="createIntScheduleView?mode=${province}&type=VIEW">
										  View
										</a>
									</li>
									
									</c:if>
									
									<c:if test="${sessionScope.loggedUserRole =='DGM'}">
				
									<li>
										<a href="createIntSchedule?mode=${province}&type=EDIT">
										  Edit
										</a>
									</li>
									
									<li>
										<a href="createIntSchedule?mode=${province}&type=SFVES">
										  Approve
										</a>
									</li>
									</c:if>
									
									<li>
										<a href="createIntScheduleView?mode=${province}&type=VIEW">
										  View
										</a>
									</li>
									
				
				
				
									<!-- <li>
										<a href="IntSumReportCC?mode=INTSUM">
										Interruption Schedule Report
										</a>
									</li>
						 	 -->
										</ul>
										
									</li>
								
										
								<!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Reports</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="estimateSPSReport">
									SPS Reports
								</a>
							</li>
						 
									</ul>
								</li>
						 -->
								
								
										
									
								</ul>
								</li> --%>
								<!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Interruption Cycle</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="addIntCycle">
									Add
								</a>
							</li>
						  
								
						</ul>
						
						
					</li> -->
								
							<!-- 	<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Tripping Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="addTripping">
									Add Tripping Data
								</a>
							</li>
						 
									</ul>
								</li>
						 -->
								
								
														<!-- <li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>PCB Reports </span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="viewReportsPCB?mode=IOTI">Transformer inventory </a></li>
							<li><a href="viewReportsPCB?mode=IOTIV">Sampled Equipment List</a></li>
							

							<li><a href="viewReportsPCB?mode=IOTII">Contaminated Equipment List</a></li>
							<li><a href="viewReportsPCB?mode=IOTIIV">Contaminated Equipment Details</a></li>
							

							<li><a href="viewReportsPCB?mode=IOTIII">Samples to be sent to ITI
</a></li>
							
							
							
							 <li><a href="viewReportsPCB?mode=STORE">Store Report</a></li>
							 <li><a href="viewReportsPCB?mode=SUMMARY">Summary Report</a></li>
							  
							<li><a href="viewReportsPCB?mode=DEVSUMMARY">Divisional Report</a></li>
							 <li><a href="viewReportsPCB?mode=PROSUMMARY">Provincial Report</a></li>
							
						</ul></li>
 -->								
		<%-- 		 <c:if test="${sessionScope.loggedUserRole =='EE' || sessionScope.loggedUserRole =='PE' || sessionScope.loggedUserRole =='PCE' || sessionScope.loggedUserRole =='CE' || sessionScope.loggedUserRole =='DGM' || sessionScope.loggedUserRole =='EEC'}">
				
				<li>
						
							<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Approval</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
							<ul class="submenu"> 
						
						
									<li>
										<a href="estimateApproval">
										Estimate Approval
										</a>
									</li>
									
									 <li>
										<a href="estimateStdApproval">
										Std. Estimate Approval
										</a>
									</li>
									 <li>
										<a href="">
										Job Revise Approval
										</a>
									</li>
									<li>
										<a href="estimatePSApproval">
										PS Approval
										</a>
									</li>
									
									
									
								</ul>
								</li>
								
							</c:if>	
		 --%>		 			
						
														
							
						
						<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Upload</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="upMvPole">
									MV Pole
								</a>
							</li>
						  
									</ul>
								</li>
							
					
					 -->
					 
					 		
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
								<a href="upMvPole">
									MV Pole
								</a>
							</li>
							
							
							<!-- <li>
							
							<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Upload</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="upMvPole">
									MV Pole
								</a>
							</li>
							
							<li>
								<a href="">
									GSS
								</a>
							</li>
							
						  <li>
								<a href="displayMVPolesNew">
									Update MV Pole
								</a>
							</li>
							
									</ul>
								</li>
					 -->
						  
								
						</ul>
						
						
					</li>
					
					<li>
						<a href="WelcomeMMS">
							<i class="fa fa-power-off"></i>
							<span>Log Out</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
					</li>
					<br>
					
					 
								
						
			</div>

		</div>
	</section>
</div>