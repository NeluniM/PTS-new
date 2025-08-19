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
						<i class="fa fa-circle"></i> Online <!-- <button class="blinkbutton" onclick="userRegister()"> <i
								class="fa fa-user"></i> 
						</button> -->
				 
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
								
								
								
								<li>
						<a href="getUserDetails">
							<i class="fa fa-user"></i>
							<span>User Registration</span>
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