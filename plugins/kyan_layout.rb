# Add Robin's prefered layout for the home page

KYAN_LAYOUT = <<-KYAN_LAYOUT
<!DOCTYPE html>

<html lang="en">

<head>

	<meta charset="utf-8" />

	<title></title>

	<link rel="stylesheet" href="/styles/core.css" />

	<!--[if lt IE 9]><script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

	<script src="/javascripts/jquery.js"></script>

	<script src="/javascripts/site.js"></script>

</head>

<body>

	<div id="container">

		<header id="header"></header>

		<section id="content">
      <%= yield %>
    </section>

		<footer id="footer"></footer>

	</div>

</body>

</html>
KYAN_LAYOUT


INDEX_VIEW = <<-INDEX_VIEW
<div>
	<h1>Hello Kyan!</h1>
  <img src="<%= magickly_image('http://localhost:3001/images/logo.png').src %>" />
</div>
INDEX_VIEW

run "padrino g controller main get:index"
inject_into_file destination_root('app/controllers/main.rb'), "\t\trender 'index'\n", :after => "get :index do\n"
inject_into_file destination_root('app/controllers/main.rb'), ", :map => '/' ", :after => "get :index"
create_file "app/views/layouts/application.html.erb", KYAN_LAYOUT
create_file "app/views/index.html.erb", INDEX_VIEW
