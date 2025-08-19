<!-- <div id="nav-col"	style="height:700px;position:fixed;overflow-y: auto;overflow-x: hidden;">

 -->	<div id="nav-col">
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
					</span> <span class="status">
						 <button class="blinkbutton" onclick="userRegister()"><i
								class="fa fa-user"></i> 
						 </button>   Online
					</span>
				</div>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse"
				id="sidebar-nav">
				<ul class="nav nav-pills nav-stacked">
					<li><a href="dashboardSUB"> <i class="fa fa-dashboard"></i> <span>Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
					</a></li>
					<c:if test="${sessionScope.loggedUserRole =='ES'}">
				
					<li>
						<a href="dashboardSPS">
							<i class="fa fa-dashboard"></i>
							<span>SPS Dashboard</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
					</li>
					</c:if>
					
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
					
					
					<!-- <li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Line & Support</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Line</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addLine"> Add </a></li>
									<li><a href="displayLineNew"> Edit </a></li>
								</ul></li>


							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Support</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSupport"> Add </a></li>
									<li><a href="displaySupportNew"> Edit </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Pole</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addPole"> Add </a></li>
									<li><a href="displayPoleNew"> Edit </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Gantry</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addGantry"> Add </a></li>
									<li><a href="displayGantryNew"> Edit </a></li>
								</ul></li>


						</ul></li>
 -->						
 
 <li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
 
						<li><a href="#" class="dropdown-toggle"> <i
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
									<c:if test="${sessionScope.loggedUserRole =='ES' || sessionScope.loggedUserRole =='DEO' }">
					                <li><a href="displayGeneralNewApproval">Send for Validation </a></li>
									
									</c:if>
									<c:if test="${sessionScope.loggedUserRole =='EE'}">
					                <li><a href="displayGeneralNewApproval">Data to be Approved</a></li>
									<li><a href="displayGeneralNewApprovedData">Approve Data</a></li>
									
									</c:if>
									
									<li><a href="viewAllGantry">View & Remove</a></li>
									
									
								</ul></li>


							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Feeders</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addFeeder"> Add </a></li>
									<li><a href="displayFeederNew"> Edit </a></li>
									<c:if test="${sessionScope.loggedUserRole =='ES' || sessionScope.loggedUserRole =='DEO' }">
					                <li><a href="displayFeederNewApprove">Send for Validation </a></li>
									
									</c:if>
									<c:if test="${sessionScope.loggedUserRole =='EE'}">
					                <li><a href="displayFeederNewApprove">Data to be Approved</a></li>
									<li><a href="displayFeederNewApprovedData">Approve Data</a></li>
									
									</c:if>
									
								</ul></li>
								
								<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSwitch"> Add </a></li>
									<li><a href="displaySwitchNew"> Edit </a></li>
									<c:if test="${sessionScope.loggedUserRole =='ES' || sessionScope.loggedUserRole =='DEO' }">
					                <li><a href="displaySwitchNewApprove">Send for Validation </a></li>
									
									</c:if>
									<c:if test="${sessionScope.loggedUserRole =='EE'}">
					                <li><a href="displaySwitchNewApprove">Data to be Approved</a></li>
									<li><a href="displaySwitchNewApprovedData">Approve Data</a></li>
									
									</c:if>
									
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
								
							<!-- <li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSwitch"> Add </a></li>
									<li><a href="displaySwitchNew"> Edit </a></li>
								</ul></li>
							 -->	
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


						</ul></li>
						
					<%-- <c:if test="${sessionScope.loggedUserRole =='ES' || sessionScope.loggedUserRole =='DEO' }">
							
						<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Validation/Approval</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
						
						<li><a href="displayAllGantryApprove">Gantry </a></li>
												
<li><a href="displayAllFeeder">Feeders </a></li>
												
<li><a href="displayAllSwitch">Switches </a></li>

							<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Gantry</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>General</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addGeneral"> Add </a></li>
									 --><li><a href="displayGeneralNewApproval"> Approve </a></li>
								</ul></li>


							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Feeders</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addFeeder"> Add </a></li>
									 --><li><a href="displayFeederNew"> Approve </a></li>
								</ul></li>
								
								<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addSwitch"> Add </a></li>
									 --><li><a href="displaySwitchNew"> Approve </a></li>
								</ul></li>
							
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Bus bar & Auxiliary</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addBusbar"> Add </a></li>
									 --><li><a href="displayBusbarNew"> Approve </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Structural & Earthing</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addStructural"> Add </a></li>
									 --><li><a href="displayStructuralNew"> Approve </a></li>
								</ul></li>
								
							<!-- <li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSwitch"> Add </a></li>
									<li><a href="displaySwitchNew"> Edit </a></li>
								</ul></li>
							 -->	
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Surge Arrestor </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addSurgeArrestor"> Add </a></li>
									 --><li><a href="displaySurgeArrestorNew"> Approve </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Transformer </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addTransformer"> Add </a></li>
									 --><li><a href="displayTransformerNew"> Approve </a></li>
								</ul></li>
<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Line AR </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addTransformer"> Add </a></li>
									 --><li><a href="displayTransformerNew"> Approve </a></li>
								</ul></li>


						</ul></li>
							

							

						</ul></li>
						</c:if>
						
						<c:if test="${sessionScope.loggedUserRole =='EE'}">
						<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Data to be Approved</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
						
						<li><a href="displayGeneralNewApproval">Approve Gantry</a></li>
						<li><a href="displayFeederNewApprove"> Approve Feeder </a></li>
						<li><a href="displaySwitchNewApprove"> Approve Switches </a></li>
						
						
<li><a href="displayAllGantry">Gantry </a></li>

<li><a href="displayAllFeeder">Feeders </a></li>

<li><a href="displayAllSwitch">Switches </a></li>

						<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Gantry</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>General</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addGeneral"> Add </a></li>
									 --><li><a href="displayGeneralNewApproval"> Approve </a></li>
								</ul></li>


							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Feeders</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addFeeder"> Add </a></li>
									 --><li><a href="displayFeederNewApprove"> Approve </a></li>
								</ul></li>
								
								<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addSwitch"> Add </a></li>
									 --><li><a href="displaySwitchNew"> Approve </a></li>
								</ul></li>
							
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Bus bar & Auxiliary</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addBusbar"> Add </a></li>
									 --><li><a href="displayBusbarNew"> Approve </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Structural & Earthing</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addStructural"> Add </a></li>
									 --><li><a href="displayStructuralNew"> Approve </a></li>
								</ul></li>
								
							<!-- <li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSwitch"> Add </a></li>
									<li><a href="displaySwitchNew"> Edit </a></li>
								</ul></li>
							 -->	
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Surge Arrestor </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addSurgeArrestor"> Add </a></li>
									 --><li><a href="displaySurgeArrestorNew"> Approve </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Transformer </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addTransformer"> Add </a></li>
									 --><li><a href="displayTransformerNew"> Approve </a></li>
								</ul></li>
<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Line AR </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addTransformer"> Add </a></li>
									 --><li><a href="displayTransformerNew"> Approve </a></li>
								</ul></li>


						</ul></li>



									
								</ul>
								</li>
						
						</c:if>
						
						
						<c:if test="${sessionScope.loggedUserRole =='EE'}">
						<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Approved Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
<li><a href="displayAllGantryApprove">Gantry </a></li>

<li><a href="displayAllFeederApprove">Feeders </a></li>

<li><a href="displayAllSwitchApprove">Switches </a></li>

						<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Gantry</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>General</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addGeneral"> Add </a></li>
									 --><li><a href="displayGeneralNew"> Approve </a></li>
								</ul></li>


							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Feeders</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addFeeder"> Add </a></li>
									 --><li><a href="displayFeederNew"> Approve </a></li>
								</ul></li>
								
								<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addSwitch"> Add </a></li>
									 --><li><a href="displaySwitchNew"> Approve </a></li>
								</ul></li>
							
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Bus bar & Auxiliary</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addBusbar"> Add </a></li>
									 --><li><a href="displayBusbarNew"> Approve </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Structural & Earthing</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addStructural"> Add </a></li>
									 --><li><a href="displayStructuralNew"> Approve </a></li>
								</ul></li>
								
							<!-- <li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSwitch"> Add </a></li>
									<li><a href="displaySwitchNew"> Edit </a></li>
								</ul></li>
							 -->	
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Surge Arrestor </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addSurgeArrestor"> Add </a></li>
									 --><li><a href="displaySurgeArrestorNew"> Approve </a></li>
								</ul></li>
								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Transformer </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addTransformer"> Add </a></li>
									 --><li><a href="displayTransformerNew"> Approve </a></li>
								</ul></li>
<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Line AR </span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<!-- <li><a href="addTransformer"> Add </a></li>
									 --><li><a href="displayTransformerNew"> Approve </a></li>
								</ul></li>


						</ul></li>



									
								</ul>
								</li>
						
						</c:if>
 --%>						
						
						
						
						
						
						
						
						
						
						
												<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-tasks"></i> <span>Line Switches</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							

								
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Switches</span> <i
									class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href="addSwitch"> Add </a></li>
									<li><a href="displaySwitchNew"> Edit </a></li>
								</ul></li>
							
								
													</ul></li>

					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-pencil-square"></i> <span>Maintenance Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
							<li><a href="#" class="dropdown-toggle"> <i
									class="fa fa-pencil-square"></i> <span>Gantry Maintenance</span>
									<i class="fa fa-chevron-circle-right drop-icon"></i>
							</a>
								<ul class="submenu">
									<li><a href=""> Add </a></li>
									<li>
										<!-- 	<a href="editTowerMaintenance">--> <a href="">

											Edit </a>
									</li>


									<li><a href=""> View </a></li>


								</ul></li>

							</ul></li>

					
					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Transformer Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="addEquipment"> Add</a></li>

							<li><a href="editEquipment"> Edit</a></li>
							<!-- <li><a href="editEquipmentSampleNo"> Edit Transformer - Sample No </a></li>
							 -->

							<li><a href="viewTransformer">View
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
					
					</ul></li>
					
					
					
					
					
					
					<c:if test="${sessionScope.loggedUserRole =='ES' || sessionScope.loggedUserRole =='EE' || sessionScope.loggedUserRole =='CE'}">
				
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
									Cretae Breakdown Estimate
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
									Create
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
					
					<%-- <li>
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
					 --%>
					
					<li>
					</ul>
					</li>
					</c:if>
					<c:if test="${sessionScope.loggedUserRole =='EE'}">
				
					<li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-pencil-square-o"></i>
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
								<a href="viewAllInspectionMntRequest?mode=INS">
									View Status
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
								<a href="breakDownMNT?mode=MNT">
									Forward
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
							
									
					<!-- <li>
										<a href="RequestStatus">
										
								
										View All Requests Status
										
										
										</a>
									</li>
					
					 -->	</ul>
					
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
					
					</c:if>	
					<c:if test="${sessionScope.loggedUserRole =='EE' || sessionScope.loggedUserRole =='ES' || sessionScope.loggedUserRole =='DEO'}">
				
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
						  
								<!-- <li>
								<a href="downloadTestingAPK">
									Download Testing APK
								</a>
							</li> -->
						  
						</ul>
						
						
					</li>
						</c:if>	
				
					
					
							<!-- <li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Master Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
					
					<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Line Master Data</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="addLineType">Line type </a></li>
							
							<li><a href="addPoleType">Pole type </a></li>

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
						</ul></li>
 -->										
					
						 <!-- <li>
						
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Reports</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
						
						<li>
										<a href="ViewScheduleAndReport?mode=INTSUM">
										Interruption Request Summary Report
										</a>
									</li>
						 	
							<li>
								<a href="estimateSPSReport">
									SPS Reports
								</a>
							</li>
						  
						
								
						</ul>
						
						
					</li> 
					 -->
						<!-- <li>
						
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
						<a href="WelcomeMMS">
							<i class="fa fa-power-off"></i>
							<span>Log Out</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
					</li>
					<br>
					
								
								
								
								<li>
			
					
					

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
			</div>

		</div>
	</section>
</div>