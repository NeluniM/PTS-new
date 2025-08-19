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
						<a href="dashboardAM">
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
					
					 --> <li>
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
									
									</ul>
								</li>
					 </ul>
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
							<span>Activity Request</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="goToCWGRequest?mode=CWG">
									Create
								</a>
							</li>
							<c:if test="${sessionScope.loggedUserRole =='EE' }">	
						
							<li>
								<a href="breakDownMNT?mode=MCN">
									Forward
								</a>
							</li>
							</c:if>
							<c:if test="${sessionScope.loggedUserRole =='ES' }">	
						
							<li>
								<a href="breakDownMNT?mode=MCN">
									Create Estimate
								</a>
							</li>
							</c:if>
						
							
							<li>
								<a href="viewAllInspectionMntRequest?mode=MCN">
									Status
								</a>
							</li>
							
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