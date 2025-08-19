<style>
.blinkbutton {
        background-color: #1c87c9;
        -webkit-border-radius: 60px;
        border-radius: 60px;
        border: none;
        color: #eeeeee;
        cursor: pointer;
        display: inline-block;
        font-family: sans-serif;
        font-size: 20px;
        padding: 10px 10px;
        text-align: center;
        text-decoration: none;
      }
      @keyframes glowing {
        0% {
          background-color: #2ba805;
          box-shadow: 0 0 5px #2ba805;
        }
        50% {
          background-color: #49e819;
          box-shadow: 0 0 20px #49e819;
        }
        100% {
          background-color: #2ba805;
          box-shadow: 0 0 5px #2ba805;
        }
      }
      .blinkbutton {
        animation: glowing 1300ms infinite;
      }










</style>


<div id="nav-col" style="height:600px;position:fixed;overflow-y: auto;overflow-x: hidden;">
 <!-- <div id="nav-col">
 -->
	<section id="col-left" class="col-left-nano">
		<div id="col-left-inner" class="col-left-nano-content">
			<div id="user-left-box" class="clearfix hidden-sm hidden-xs">
				 <%-- <img alt="" src="<c:url value="/resources/img/samples/user.png"/>"/>
				  --%><div class="user-box">
					<span class="name">
						 <p style="font-family:verdana;font-size:15px"><strong>Welcome ${sessionScope.userNameUser}</strong></p>
					 
					<%--  Welcome ${sessionScope.userNameUser}
					 --%> 
					 
					 </span>
					 <span class="status">
						 <button class="blinkbutton" onclick="userRegister()"><i
								class="fa fa-user"></i> 
						 </button>   Online
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
					
					<!-- <li>
						<a href="dashboardSPS">
							<i class="fa fa-dashboard"></i>
							<span>SPS Dashboard</span>
							<span class="label label-info label-circle pull-right">28</span>
						</a>
					</li>
					 -->
					
					<!-- <li>
						<a href="WelcomeMMS">
							<i class="fa fa-power-off"></i>
							<span>Log Out</span>
							<span class="label label-info label-circle pull-right">28</span>
						</a>
					</li>
					 -->
					<!-- <li>
						<a href="dashboardAll">
							<i class="fa fa-pencil"></i>
							<span>Divisional Information</span>
							<span class="label label-info label-circle pull-right">28</span>
						</a>
					</li>
					 -->
					
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
							<!-- <li>
								<a href="displayLineTranmission">
									View Tower Line- Transmission
								</a>
							</li>
							 -->
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
							<li>
								<a href="dashboardCom">
									Tower Lines - Combination View
								</a>
							</li>
							
							
							<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-retweet"></i> <span>Add Line Master Data</span> <i
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
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
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
							<i class="fa fa-retweet"></i>
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
							
							
							
							
							
							<!-- <li>
								<a href="addCSC">
									View CSCs
								</a>
							</li> -->
						</ul>
					</li>
					


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
									<span>Approved Data</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="displayLineTranmission">
										Line
										</a>
									</li>
									<li>
										<a href="displaySupportNewTM">
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
										<a href="mntCompletion">
										Completion Data
										</a>
									</li> -->
								</ul>
							</li>
													<li>
								<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Approved Completion Data</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="editTMnewApprove">
										Completion Data
										</a>
									</li>
									
								</ul>
							</li>
							<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Transformer Data </span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="addEquipment"> Add</a></li>

							<li><a href="editEquipment"> Edit</a></li>
							<!-- <li><a href="editEquipmentSampleNo"> Edit Transformer - Sample No </a></li>
							 -->

							<li><a href="addInformationReatedSample">View
									</a></li>
							<!-- <li><a href="uploadEquipment">Upload
									Transformer </a></li>
									<li><a href="uploadEquipmentGPS">Upload
									GPS </a></li>
									<li><a href="uploadEquipmentSINNO">Upload
									SIN No </a></li>
							 -->		
									

						</ul>
						
						
						
						</li>
						</ul>
						</li>
							
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
									<span>Maintenance Plan</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<li>
										<a href="maintenancePlan">
										2020
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
								</li> -->
								<!-- <li>
							<a href="mntCompletion" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Completion Data Approval</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
							</li> -->
							<!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>History Analysis</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="">
									Cycle Wise Data Storage
								</a>
							</li>
						<li>
								<a href="ViewScheduleAndReport?mode=HAR">
									Tower Line Failure Rates
								</a>
							</li>
					
						
								
						</ul>
						
						
					</li> -->


					
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
									<li>
										<a href="EstimateDetails">
										Add
										</a>
									</li>
									<li>
										<a href="EstimateDetailsModify">
										Modify
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
									<span>Maintenance  Plan</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
								<ul class="submenu">
									<!-- <li>
										<a href="downloadPlan">
										2020
										</a>
									</li>
									<li>
										<a href="maintenancePlan2021">
										2021
										</a>
									</li> 
									<li>
										<a href="maintenancePlan">
										2022
										</a>
									</li>
									 --><li>
										<a href="addPlan">
										Add
										</a>
									</li>
									<li>
										<a href="editPlan">
										Edit
										</a>
									</li>
									<li>
										<a href="maintenancePlan">
										View
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
							<span>Job - Finalized</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="jobCompletion">
									Job finish
								</a>
							</li>
						
								
						</ul>
						
						
					</li>
						
								
								
								<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Completion</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						
						<li>
								<a href="editTMnewApproveComplesionUpdate">
									Tower Maintenance
								</a>
							</li>
							
						
							<li>
								<a href="CompletionEE">
									Send Notification
								</a>
							</li>
							<li>
								<a href="viewCompletion?mode=HOTINS">
									Hot Line Inspections
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
								
								<!-- <li>
										<a href="mntViewCompletion">
										Completion  Data
										</a>
									</li>
								 --><!-- <li>
							<a href="mntCompletion" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Completion Data Approval</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
								</a>
							</li> -->
							<!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>History Analysis</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="">
									Cycle Wise Data Storage
								</a>
							</li>
						<li>
								<a href="ViewScheduleAndReport?mode=HAR">
									Tower Line Failure Rates
								</a>
							</li>
					
						
								
						</ul>
						
						
					</li> -->
						<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Inspection Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="breakDownMNT?mode=INS">
									Breakdown Maintenance
								</a>
							</li>
						  <li>
								<a href="viewAllInspectionMntRequest?mode=INS">
									View Inspection Request Status
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
									Breakdown Maintenance
								</a>
							</li>
						  <li>
								<a href="viewAllInspectionMntRequest?mode=MNT">
									View Maintenance Request Status
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
								<a href="viewAllInspectionMntRequest?mode=INT">
									View Interruption Request Status
								</a>
							</li> 
					
						</ul>
					
					</li>
					 -->
					
				<!-- 	<li>
						
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
					
					<!-- <li>
						
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
									Tower Line
								</a>
							</li> 
					 <li>
								<a href="dashboardTowerType">
									Tower Type
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
								<a href="goToInsMntRequest?mode=PHM">
									Create
								</a>
							</li>
							
							
							<li>
								<a href="breakDownMNT?mode=INS">
									Forward
								</a>
							</li>
							<li>
								<a href="viewAllInspectionMntRequestSendReply?mode=INS">
									Send Reply
								</a>
							</li> 
					
						  <li>
								<a href="viewAllInspectionMntRequest?mode=INS">
									View Status
								</a>
							</li> 
					<li>
								<a href="reAllocateResponsibleEE?mode=INS">
									Reallocate Responsible EE
								</a>
							</li> 
					
						</ul>
					
					</li>
					
					<!-- <li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Inspection Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="breakDownMNT?mode=INS">
									Breakdown Maintenance
								</a>
							</li>
						  <li>
								<a href="viewAllInspectionMntRequest?mode=INS">
									View Inspection Request Status
								</a>
							</li> 
					
						</ul>
					
					</li>
					 -->
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Maintenance Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						<li>
								<a href="goToInsMntRequest?mode=PMT">
									Create
								</a>
							</li>
							
							<li>
								<a href="breakDownMNT?mode=MNT">
									Forward
								</a>
							</li>
							<!-- <li>
								<a href="goToInsMntRequest?mode=PMT">
									Generete Maintenance Request
								</a>
							</li>
							 --> 
							<li>
								<a href="viewAllInspectionMntRequestSendReply?mode=MNT">
									Send Reply
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
								<a href="displayAllINSReqA?mode=INT">
									Forward
								</a>
							</li>
						  <li>
								<a href="viewAllInspectionMntRequest?mode=INT">
									View Status
								</a>
							</li> 
							
							<li>
										<a href="ViewScheduleAndReport?mode=INTSUM">
										Interruption Request Summary Report
										</a>
									</li>
						 			
					<li>
										<a href="RequestStatus">
										
								
										View all Requests Status
										
										
										</a>
									</li>
					 
						</ul>
					
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>CWG Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						<li>
								<a href="goToCWGRequest?mode=CWG">
									Create
								</a>
							</li>
							
							<li>
								<a href="breakDownMNT?mode=MNT">
									Forward
								</a>
							</li>
							<!-- <li>
								<a href="goToInsMntRequest?mode=PMT">
									Generete Maintenance Request
								</a>
							</li>
							 --> 
							<li>
								<a href="viewAllInspectionMntRequestSendReply?mode=MNT">
									Send Reply
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
					
									
					
					
								<!-- <li>
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
							</li> -->
						</ul>
						
						
					</li>
					
					
					<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>History Analysis</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						<li>
								<a href="historyAnalysisReport">
									History Analysis
								</a>
							</li>
							<li>
								<a href="historyAnalysisNew">
									History Analysis New
								</a>
							</li>
						
							
							<li>
								<a href="ViewScheduleAndReport?mode=HAR">
									Cycle Wise Data Storage 1
								</a>
							</li>
						<li>
								<a href="ViewScheduleAndReport?mode=HAR2">
									Cycle Wise Data Storage 2
								</a>
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
						
					
							<!-- <li>
								<a href="">
									Upload Data
								</a>
							</li>
							 -->
						   
						</ul>
						</li>
						
						<!--  <li>
						
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
					 -->	<li>
						<a href="getUserDetails">
							<i class="fa fa-user"></i>
							<span>User Registration</span>
							<span class="label label-info label-circle pull-right"></span>
						</a>
					</li>		<li>
						<a href="WelcomeMMS">
							<i class="fa fa-power-off"></i>
							<span>Log Out</span>
							<span class="label label-info label-circle pull-right"></span>
						</a>
					</li>
					
					
<!-- 									<li>
				<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Master Information</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
					
					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Add Line Master Data</span> <i
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
							<i class="fa fa-retweet"></i>
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
					
					</ul>
					</li> -->
					
										
					
			 
				
<!-- 					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Gantry</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>General</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addGeneral"> Add </a></li>
									<li><a href="displayGeneralNew"> Edit </a></li>
								</ul></li>


							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Feeders</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addFeeder"> Add </a></li>
									<li><a href="displayFeederNew"> Edit </a></li>
								</ul></li>
								
								<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSwitch"> Add </a></li>
									<li><a href="displaySwitchNew"> Edit </a></li>
								</ul></li>
							
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Bus bar & Auxiliary</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addBusbar"> Add </a></li>
									<li><a href="displayBusbarNew"> Edit </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Structural & Earthing</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addStructural"> Add </a></li>
									<li><a href="displayStructuralNew"> Edit </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSwitch"> Add </a></li>
									<li><a href="displaySwitchNew"> Edit </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Surge Arrestor </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSurgeArrestor"> Add </a></li>
									<li><a href="displaySurgeArrestorNew"> Edit </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Transformer </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addTransformer"> Add </a></li>
									<li><a href="displayTransformerNew"> Edit </a></li>
								</ul></li>
<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Line AR </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addTransformer"> Add </a></li>
									<li><a href="displayTransformerNew"> Edit </a></li>
								</ul></li>


						</ul></li> -->
						
						<!-- <li>
						<a href="WelcomeMMS">
							<i class="fa fa-dashboard"></i>
							<span>Log Out</span>
							<span class="label label-info label-circle pull-right">28</span>
						</a>
					</li> -->
					
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