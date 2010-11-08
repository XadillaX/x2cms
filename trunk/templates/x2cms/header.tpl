<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>{__webtitle__}</title>
	<link rel="stylesheet" href="{__skinpath__}css/style.css" type="text/css" media="all" />
	<!--[if lte IE 6]><link rel="stylesheet" href="{__skinpath__}css/ie6.css" type="text/css" media="all" /><![endif]-->
	<meta name="keywords" content="{__keyword__}" />
	<meta name="Description" content="{__description__}" />
	<meta name="Author" content="{__sysauthor__}" />	
	<script src="{__skinpath__}js/jquery-1.4.1.min.js" type="text/javascript"></script>
	<script src="{__skinpath__}js/jquery.jcarousel.pack.js" type="text/javascript"></script>
	<script src="{__skinpath__}js/jquery-func.js" type="text/javascript"></script>
</head>
<body>
	
<!-- Header -->
<div id="header">
	<div class="shell">
		
		<!-- Logo -->
		<h1 id="logo"><a href="#">{__webtitle__}</a></h1>
		<!-- End Logo -->
		
		<!-- Navigation -->
		<div id="navigation">
			<ul>
			    <li><a href="index.asp">首页</a></li>
                {#:__mainnav__}<li><a href="{__mainnav__.url}">{__mainnav__.type}</a></li>{/#:__mainnav__}
			    <li><a href="contact.asp">联系</a></li>
			</ul>
		</div>
		<!-- End Navigation -->
		
	</div>
</div>
<!-- End Header -->

<!-- Slider -->
<div id="slider">
	<div class="shell">
		
		<div class="slider-holder">
			<div class="slides">
				<ul>
									    	
					<!-- Slide -->
				    <li>
				    	<div class="slide-bg">
					    	<div class="slide-image">
					    		<a href="#"><img src="css/images/slide-image.jpg" alt="" /></a>
					    	</div>
					    	<div class="slide-info">
					    		<h2>Lorem ipsum dolor sit amet, consectetur adipiscing elit. </h2>
					    		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras accumsan interdum nulla. Nunc venenatis tincidunt sem, nec tempus purus congue viverra. Nullam venenatis tempus libero, quis venenatis metus rhoncus et. Nulla rutrum luctus ante, quis varius justo aliquam sit amet.</p>
					    		<a href="#" class="notext learn-button">Learn More</a>
					    		
					    	</div>
				    	</div>
				    	<span class="slide-shadow">&nbsp;</span>
				    </li>
				    <!-- End Slide -->
				    
				    <!-- Slide -->
				    <li>
				    	<div class="slide-bg">
					    	<div class="slide-image">
					    		<a href="#"><img src="css/images/slide-image.jpg" alt="" /></a>
					    	</div>
					    	<div class="slide-info">
					    		<h2>Lorem ipsum dolor sit amet, consectetur adipiscing elit. </h2>
					    		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras accumsan interdum nulla. Nunc venenatis tincidunt sem, nec tempus purus congue viverra. Nullam venenatis tempus libero, quis venenatis metus rhoncus et. Nulla rutrum luctus ante, quis varius justo aliquam sit amet.</p>
					    		<a href="#" class="notext learn-button">Learn More</a>
					    		
					    	</div>
				    	</div>
				    	<span class="slide-shadow">&nbsp;</span>
				    </li>
				    <!-- End Slide -->
				    
				    <!-- Slide -->
				    <li>
				    	<div class="slide-bg">
					    	<div class="slide-image">
					    		<a href="#"><img src="css/images/slide-image.jpg" alt="" /></a>
					    	</div>
					    	<div class="slide-info">
					    		<h2>Lorem ipsum dolor sit amet, consectetur adipiscing elit. </h2>
					    		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras accumsan interdum nulla. Nunc venenatis tincidunt sem, nec tempus purus congue viverra. Nullam venenatis tempus libero, quis venenatis metus rhoncus et. Nulla rutrum luctus ante, quis varius justo aliquam sit amet.</p>
					    		<a href="#" class="notext learn-button">Learn More</a>
					    		
					    	</div>
				    	</div>
				    	<span class="slide-shadow">&nbsp;</span>
				    </li>
					<!-- End Slide -->
				    
			    </ul>
			</div>
			
			<!-- Slider Navigation -->
			<div class="slider-nav">
				<a href="#" class="prev">previous</a>
				<a href="#" class="next">next</a>
			</div>
			<!-- End Slider Navigation -->
		</div>
		
	</div>
</div>
<!-- End Slider -->
