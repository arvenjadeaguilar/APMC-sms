<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Ocom Application"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<r:require module="ocom-bootstrap"/>
		
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
				
		<g:layoutHead/>
		<r:layoutResources />
		
		<style type="text/css">
	      body {
	        padding-top: 40px;
	        padding-bottom: 40px;
	      }
	      .sidebar-nav {
	        padding: 9px 0;
	      }
	
	      @media (max-width: 980px) {
	        /* Enable use of floated navbar text */
	        .navbar-text.pull-right {
	          float: none;
	          padding-left: 5px;
	          padding-right: 5px;
	        }
	      }
	    </style>
	</head>
	<body class="ng-cloak" data-ng-app="${pageProperty(name: 'body.data-ng-app')}"
		  data-base-url="${pageProperty(name: 'body.data-base-url', default: createLink(action: 'index').replaceAll(/index$/, ''))}"
		  data-template-url="${pageProperty(name: 'body.data-template-url', default: controllerName ? createLink(action: 'template') : "")}"
		  data-common-template-url="${pageProperty(name: 'body.data-common-template-url', default: createLink(uri: '/ng-templates'))}">

		<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="navbar-header">
    			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
	      			<span class="sr-only">Toggle navigation</span>
	      			<span class="icon-bar"></span>
	      			<span class="icon-bar"></span>
	      			<span class="icon-bar"></span>
    			</button>
    			<g:link uri="/" class="navbar-brand">Project name</g:link>
  			</div>
  			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    			<ul class="nav navbar-nav">
					<li class="active"><a href="${createLink(uri: '/')}"><i
							class="glyphicon glyphicon-home"></i></a></li>
				</ul>
				<ul class="nav navbar-nav">
					<g:pageProperty name="page.buttons" />
					<li class="divider-vertical"></li>
				</ul>
				<g:pageProperty name="page.navForm" />
				<ul class="nav navbar-nav">
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown">Menu<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><g:link action="index" controller="option1">Option1</g:link></li>
						</ul></li>
				</ul>
			</div><!--/.nav-collapse -->
		</div>		
		<div class="header-main-bar"></div>
		<div class="container-fluid">
			<div class="row-fluid">
	
				<g:layoutBody />
	
			</div><!--/row-->
	
			<hr>
	
			<footer>
				<p>
					&copy; <a href="http://ocom.com.au">Ocom Software </a> 2014
				</p>
			</footer>
	
		</div><!--/.fluid-container-->
		<r:layoutResources />
	</body>
</html>
