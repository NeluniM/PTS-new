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
						<a href="dashboardEM">
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
							
							
						</ul>
					</li>
					
					<!-- <li>
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
					 -->
				
					
									
				
						<li>
							
							<a href="#" class="dropdown-toggle">
							<i class="fa fa-retweet"></i>
							<span>Commercial</span>
							<i class="fa fa-chevron-circle-right drop-icon"></i>
						</a>
						<ul class="submenu">
							<li>
								<a href="sendToBillingController">
									Create Order Card
								</a>
							</li>
							<li>
								<a href="">
									Energize
								</a>
							</li>
							<li>
								<a href="">
									Send to billing
								</a>
							</li>
							
							
							
							</ul>
							</li>
							
							
							<li><a href="#" class="dropdown-toggle"> <i
							class="fa fa-sliders"></i> <span>Approval</span> <i
							class="fa fa-chevron-circle-right drop-icon"></i>
					</a>
						<ul class="submenu">

							<li><a href="">Estimate </a></li>

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