<!-- <div id="nav-col" style="height:700px;position:fixed;overflow-y: auto;overflow-x: hidden;">
 -->	<div id="nav-col">
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
						<a href="dashboardEM">
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
							
							
						</ul>
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Master Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="">
									Manufacturer
								</a>
							</li>
							
							<li>
								<a href="">
									Meter Model
								</a>
							</li>
							
							
						</ul>
					</li>
					
					<li>
						<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Meter Data</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="ExistingMeterAdd">
									Add Existing Meter 
								</a>
							</li>
							
							<li>
								<a href="ExistingMeterModify">
									Modify Existing Meter
								</a>
							</li>
							
							
						</ul>
					</li>
					
					 
				
					
									
				
						<li>
							
							<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Meter Test Report</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<!-- <li>
								<a href="addMeter">
									Add
								</a>
							</li>
							
							<li>
								<a href="AddMeterDetails">
									Add Meter
								</a>
							</li>
							<li>
								<a href="AddMeterTestData">
									Add Meter Test
								</a>
							</li>
							
							<li>
								<a href="meterReport">
									Meter Test Report
								</a>
							</li>
							 --><li>
								<a href="createMeterReport">
									Create
								</a>
							</li>
							<li>
								<a href="newMeterReport">
									Test Report
								</a>
							</li>
							<li>
								<a href="addMetertestingreportGet">
									Test Report 1
								</a>
							</li>
							<c:if test="${sessionScope.loggedUserRole=='ES'}">
					
							<li>
								<a href="sendTestReport">
									Forward
								</a>
							</li>
							</c:if>
							<c:if test="${sessionScope.loggedUserRole=='EE' || sessionScope.loggedUserRole=='CE'}">
					
							<li>
								<a href="sendTestReport">
									Approve
								</a>
							</li>
							</c:if>
					<li>
								<a href="viewApprovedTestReport">
									View Approved Test Report
								</a>
							</li>
							
							<li>
								<a href="viewTestReport">
									View
								</a>
							</li>
							<li>
								<a href="cancelTestReport">
									Cancel
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
																<li><a href="viewTransformer">View
									</a></li>
							</ul>
						
						
						
						</li>
							
							
							
						  	 
					 
					 	
					<li><a href="#" class="dropdown-toggle"> <i class="fa fa-retweet"></i>
					 <span>Meter Order Card</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">
					
				    <c:if test="${sessionScope.loggedUserRole=='DEO' || sessionScope.loggedUserRole=='EE'}">
					
					<li>
						
						<a href="MeterTestingRequest?mode=EMT"><i class="fa fa-retweet"></i>
							
							<span>Create</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						
					</li>
					<li>
						
						<a href="MeterTestingRequestEdit?mode=EMT"><i class="fa fa-retweet"></i>
							
							<span>Edit</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						
					</li>
					
					</c:if>
					
					<c:if test="${sessionScope.loggedUserRole=='EE'}">
													
					<li>
					    						
						<a href="viewMeterRequest"><i class="fa fa-retweet"></i>
							<span>Recommend & Forward</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						
					</li>	
					
					<li>
					    						
						<a href="esDeallocation"><i class="fa fa-retweet"></i>
							<span>ES De-allocation</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						
					</li>	
					
					
					<li>
						<a href="viewMeterRequestAll"><i class="fa fa-retweet"></i>
							<span>View & Remove</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
					<li>
						<a href="RequestStatusMeterES"><i class="fa fa-retweet"></i>
							<span>Order Card ES Summary</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
					
						</c:if>
						
						
						
						<c:if test="${sessionScope.loggedUserRole=='CE'}">
													
					<li>
					    						
						<a href="viewMeterRequest"><i class="fa fa-retweet"></i>
							<span>Recommend & Forward</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						
					</li>	
					
					<li>
					    						
						<a href="esDeallocation"><i class="fa fa-retweet"></i>
							<span>ES De-allocation</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						
					</li>	
					
					
					<li>
						<a href="viewMeterRequestAll"><i class="fa fa-retweet"></i>
							<span>View & Remove</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
						<li>
						<a href="RequestStatusMeterES"><i class="fa fa-retweet"></i>
							<span>Order Card ES Summary</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
					
					
						</c:if>
					
						
						
						  <c:if test="${sessionScope.loggedUserRole=='DEO'}">
						 <li>
						<a href="viewMeterRequestAll"><i class="fa fa-retweet"></i>
							<span>View</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
						<li>
						<a href="RequestStatusMeterES"><i class="fa fa-retweet"></i>
							<span>Order Card ES Summary</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
					
					
						 
						
						</c:if>
						 
						<c:if test="${sessionScope.loggedUserRole=='ES'}">
						<li>
						<a href="viewMeterRequest"><i class="fa fa-retweet"></i>
							<span>Order cards to be executed</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
						<li>
						<a href="viewMeterRequestAttended"><i class="fa fa-retweet"></i>
							<span>Attended Order cards</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
						
						<li>
						<a href="viewMeterRequestAll"><i class="fa fa-retweet"></i>
							<span>View</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
						<li>
						<a href="RequestStatusMeterES"><i class="fa fa-retweet"></i>
							<span>Order Card ES Summary</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
					
					
						</c:if>
						
							<li>
						<a href="RequestStatusMeterAll"><i class="fa fa-retweet"></i>
							<span>View All</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
						
						<li>
						<a href="viewMeterRequestReport"><i class="fa fa-retweet"></i>
							<span>Report</span>
							<!--<span class="label label-info label-circle pull-right">28</span>-->
						</a>
						</li>
						
						<!-- <li><a href="uploadEquipmentSINNO">Upload
									SIN No </a></li>
							<li><a href="uploadEquipmentAreaCode">Change Area Code
								 </a></li>
								<li><a href="uploadEquipmentAreaCode">ES Deallocation
								 </a></li>
						 -->	
					</ul>
					</li>	 			
						
						<c:if test="${sessionScope.loggedUserRole=='EE'}">
														
							<li>
						<a href="getUserDetails">
							<i class="fa fa-user"></i>
							<span>User Registration</span>
							<span class="label label-info label-circle pull-right"></span>
						</a>
					</li>	
					</c:if>	
					
					<c:if test="${sessionScope.loggedUserRole=='CE'}">
														
							<li>
						<a href="getUserDetails">
							<i class="fa fa-user"></i>
							<span>User Registration</span>
							<span class="label label-info label-circle pull-right"></span>
						</a>
					</li>	
					</c:if>
								
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