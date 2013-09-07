# make index page.
class Tonka

	def initialize(options=[])
		options = options || ARGV
		if !options[0].nil?

			site_name = options[0] || 'sites'

			jquery = true if options[1] == '-jquery'
			css_reset = true if options[1] == '-jquery'

			if !Dir.exist? site_name

				Dir.mkdir site_name
				Dir.mkdir "#{site_name}/stylesheets"
				Dir.mkdir "#{site_name}/javascripts"

				index_html = File.new("#{site_name}/index.html","w")
				style_css = File.new("#{site_name}/stylesheets/style.css","w")
				scripts_js = File.new("#{site_name}/javascripts/scripts.js","w")

				index_page_content = "<!DOCTYPE html>
			<html>
			<head>
				<title>#{site_name}</title>
				<link rel=\"stylesheet\" type=\"text/css\" href=\"/stylesheets/style.css\" />
				<script type=\"text/javascripts\" src=\"/javascripts/scripts.js\"></script>#{ "\n\t<script type=\"text/javascripts\" src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js\"></script>" if jquery }
			</head>
			<body>
			<h1>#{site_name}</h1>
			</body>
			</html>"

				style_css_content = "/* html5doctor.com Reset v1.6.1 - http://cssreset.com */
				html,body,div,span,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,abbr,address,cite,code,del,dfn,em,img,ins,kbd,q,samp,small,strong,sub,sup,var,b,i,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,figcaption,figure,footer,header,hgroup,menu,nav,section,summary,time,mark,audio,video{margin:0;padding:0;border:0;outline:0;font-size:100%;vertical-align:baseline;background:transparent}body{line-height:1}article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block}nav ul{list-style:none}blockquote,q{quotes:none}blockquote:before,blockquote:after,q:before,q:after{content:none}a{margin:0;padding:0;font-size:100%;vertical-align:baseline;background:transparent}ins{background-color:#ff9;color:#000;text-decoration:none}mark{background-color:#ff9;color:#000;font-style:italic;font-weight:bold}del{text-decoration:line-through}abbr[title],dfn[title]{border-bottom:1px dotted;cursor:help}table{border-collapse:collapse;border-spacing:0}hr{display:block;height:1px;border:0;border-top:1px solid #ccc;margin:1em 0;padding:0}input,select{vertical-align:middle}"

				scripts_js_content = "console.log('feed me javascripts')"

				index_html.puts index_page_content
				index_html.close

				style_css.puts style_css_content
				style_css.close

				scripts_js.puts scripts_js_content
				scripts_js.close

				puts "#{site_name} was successfully created!"

			else
				puts "a '#{site_name}' directory already exists!"
			end
		else
			puts "usage: tonka.rb SITE_NAME [-options]

		The most common options:
		    -jquery		adds jquery to index.html file.
		    -css_reset	adds css resetters to style.css file.
		"
		end
	end
end