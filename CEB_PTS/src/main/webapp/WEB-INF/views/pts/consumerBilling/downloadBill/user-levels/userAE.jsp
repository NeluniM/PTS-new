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

<!-- <div id="nav-col" style="height:700px;position:fixed;overflow-y: auto;overflow-x: hidden;">
 --><div id="nav-col"">
 	<section id="col-left" class="col-left-nano">
		<div id="col-left-inner" class="col-left-nano-content">
			<div id="user-left-box" class="clearfix hidden-sm hidden-xs">
				<%-- <img alt="" src="<c:url value="/resources/img/samples/user.png"/>"/>
				 --%><div class="user-box">
					<span class="name">
						<p style="font-family:verdana;font-size:15px"><strong>Welcome ${sessionScope.userNameUser}</strong></p>
					</span>
					<span class="status">
						<button class="blinkbutton" onclick="userRegister()"><i class="fa fa-user"></i></button> Online  <!-- <button class="blinkbutton" onclick="userRegister()"> <i
								class="fa fa-user"></i> 
						</button>  -->
				 
					</span>
				</div>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse" id="sidebar-nav">	
				<ul class="nav nav-pills nav-stacked">
					<li>
						<a href="dashboardAE">
							<i class="fa fa-dashboard"></i>
							<span>Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
					</li>
					
					
					<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Project Costing</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">


<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Approval</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="estApprovalNewAE">
										Estimate
										</a>
									</li>
									<li>
										<a href="reviseApprovalNewAE">
										Revise Job
										</a>
									</li>
					</ul>
					</li>
					<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Job Completion</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="jobCompletion">
										Physical Completion
										</a>
									</li>
									
					</ul>
					</li>
					
					<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Search</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="estApprovalNewStatus?mode=CM">
										Estimate
										</a>
									</li>
									<li>
										<a href="reviseApprovalNewAEStatus">
										Job
										</a>
									</li>
									<!-- <li>
										<a href="estApprovalCommercialStatus">
										Standard Estimate
										</a>
									</li>
									 -->
									
								</ul>
								</li>
				
					
					</ul>
					</li>
					
			<!-- 		<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>SPS - Search</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="estApprovalNewStatus?mode=AE">
										Estimate
										</a>
									</li>
									<li>
										<a href="reviseApprovalNewAEStatus">
										Job
										</a>
									</li>
									<li>
										<a href="estApprovalCommercialStatus">
										Standard Estimate
										</a>
									</li>
									
									
								</ul>
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
									Tower Lines
								</a>
							</li>
							
							<li>
								<a href="PCBdashboard">
									Distribution Transformer
								</a>
							</li>
							
							<li>
								<a href="SubstationView">
									Substation -PHM
								</a>
							</li>
							
							
							<!-- <li>
								<a href="addCSC">
									View CSCs
								</a>
							</li> -->
						</ul>
					</li>
<!-- 					<li>
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
								<a href="addPole">
									Add LV Pole
								</a>
							</li>
							<li>
								<a href="displayPoleNew">
									Edit LV Pole
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
								<a href="">
									LV Pole
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
							<span>Upload Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="">
									LV Pole
								</a>
							</li>
							
							
						  <li>
								<a href="displayMVPolesNew">
									Update MV Pole
								</a>
							</li>
							
									</ul>
								</li>
								
								<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Transformer Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="addEquipment"> Add </a></li>

							<li><a href="editEquipment"> Edit</a></li>
							<li><a href="editEquipmentSampleNo"> Edit Transformer - Sample No </a></li>
							

							<li><a href="addInformationReatedSample">View
									</a></li>
							<li><a href="uploadEquipment">Upload
									Transformer </a></li>
									<li><a href="uploadEquipmentGPS">Upload
									GPS </a></li>
									<li><a href="uploadEquipmentSINNO">Upload
									SIN No </a></li>
									
									

						</ul>
						
						
						
						</li>
								
							
									
					
						
						</ul>
						
				</li>
				 -->
					
					
					
					<!-- <li>
					 <a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Schedule & Reports</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
					 -->	
					
					
									<li>
									<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Provincial Schedule</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
									</a>
									<ul class="submenu">
									<li>
										<a href="ViewProvincialScheduleAE?mode=VR">
										Vegetation Schedule
										</a>
									</li>
									<li>
										<a href="ViewProvincialScheduleAE?mode=MPL">
										Missing Parts Schedule
										</a>
									</li>
									
									<li>
										<a href="ViewProvincialScheduleAE?mode=EWOP">
										Electrical Works On Poles
										</a>
									</li>
									</ul>
									</li>
								
				<!-- 				<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Reports</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						
					<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Maintenance Summary</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewHotlineMaintenanceAE?mode=HAR">
									Cycle Wise Data Storage 1
								</a>
							</li>
							<li>
								<a href="viewHotlineMaintenanceAE?mode=HAR2">
									Cycle Wise Data Storage 2
								</a>
							</li>
						<li>
								<a href="">
									Tower Line Failure Rates
								</a>
							</li>
					
					
				</ul>	</li>
				
				
				<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Reports</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="estimateSPSReport">
									SPS Report
								</a>
							</li>
						  
								
						</ul>
						
						
					</li>
				
					
					
									
								</ul>
								</li>
					 -->
								
								
								<!-- </ul>	
								</li>
								 -->
								
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
										<!-- 	<li> 
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Tower Lines</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewTowerLineAE?mode=PECIRCONT">
									Circuit/Conductor Type
								</a>
							</li> 
					
								
						</ul>
						
						
					</li>
					 -->				
									
									<li>
								<a href="viewTowerLineAE?mode=PECIRCONT">
									Tower Lines
								</a>
							</li> 
					
									
									<!-- 
									<li>
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
						
						
						<!-- <li>
						
							<a href="#" class="dropdown-toggle">
									<i class="fa fa-retweet"></i>
									<span>Inspection Request</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
							<ul class="submenu"> 
								<li>
										<a href="viewTowerLine">
										Tower Lines
										</a>
									</li>
											<li> 
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Tower Lines</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="viewTowerLineAE?mode=PECIRCONT">
									Circuit/Conductor Type
								</a>
							</li> 
					
								
						</ul>
						
						
					</li>
									
									
									<li>
										<a href="goToInsMntRequest?mode=INS">
										Create
										</a>
									</li>
									
					<li>
										<a href="viewAllInspectionMntRequestAE?mode=INS">
										View Status
										</a>
									</li>
									
									
									
									<li>
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
									</li>
								</ul>
						</li>
					 -->
						
										
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
										<a href="goToInsMntRequest?mode=INS">
										Create
										</a>
									</li>
									<li>
										<a href="viewAllInspectionMntRequestAEAE?mode=INS">
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
										<a href="goToInsMntRequest?mode=MNT">
										Create
										</a>
									</li>
									<li>
										<a href="viewAllInspectionMntRequestAEAE?mode=MNT">
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
										<a href="displayAllInsRequestAE?mode=INT">
										Action on Request
										</a>
									</li>
									
									<!-- <li>
										<a href="manageIntRequestAE?mode=FWD">
										Forward Request
										</a>
									</li>
									 --><!-- <li>
										<a href="manageIntRequestAE?mode=APP">
										Approve Request
										</a>
									</li>
									<li>
										<a href="manageIntRequestAE?mode=NAP">
										Not Approve Request
										</a>
									</li>
									<li>
										<a href="manageIntRequestAE?mode=RSD">
										Reschedule Request
										</a>
									</li>
									 -->
									<!-- <li>
										<a href="goToInterruptionRequest?mode=INTERRUPTIONAE">
										Reschedule Request
										</a>
									</li>
									 -->
									
									<!-- <li>
										<a href="displayAllInsRequestAE?mode=INT">
										View Request
										</a>
									</li>
									 --><li>
										<a href="viewAllInspectionMntRequestAEAE?mode=INT">
										View Status
										</a>
									</li>
									
									<li>
										<a href="RequestStatus">
										
								
										View All RequestsStatus
										
										
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
									
									
								</ul>
								</li>
								
								<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-retweet"></i> <span>Transformer Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="addEquipment"> Add </a></li>

							<li><a href="editEquipment"> Edit</a></li>
																<li><a href="viewTransformerArea">View
									</a></li>
							</ul>
						
						
						
						</li>
								
								
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
								<!-- <li>
						
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
						  
								
						</ul>
						
						
					</li> -->
								
								
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
						 --> 
								
								
								
								 <li>
						<a href="historyAnalysisReportArea">
							<i class="fa fa-retweet"></i>
							<span>History Analysis</span>
							<span class="label label-info label-circle pull-right"></span>
						</a>
					</li> 
								
								
								<li>
						<a href="WelcomeMMS">
							<i class="fa fa-power-off"></i>
							<span>Log Out</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
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
									SPS Report
								</a>
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
					
				
				<!--  <li><a href="#" class="dropdown-toggle"> <i
class="fa fa-pencil-square"></i> <span>Pole</span> <i
class="fa fa-chevron-circle-right drop-icon"></i>
</a>
<ul class="submenu">
<li><a href="addPole"> Add </a></li>
<li><a href="displayPoleNew"> Edit </a></li>
</ul></li>
	 -->			
			</div>

		</div>
	</section>
</div>