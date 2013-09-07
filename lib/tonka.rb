# make index page.
class Tonka

	attr_accessor :options, :site_name, :action

	def initialize(options=[])
		@options = options || ARGV
		if !@options[0].nil?

			parse_options(@options)

		else
			display_usage
		end
	end

	def make_directories(site_name)
		if !Dir.exist? site_name
			Dir.mkdir site_name
			Dir.mkdir "#{site_name}/stylesheets"
			Dir.mkdir "#{site_name}/javascripts"

			puts "#{site_name} was successfully created!"
		else
			puts "a '#{site_name}' directory already exists!"
			display_usage
		end
	end

	def make_files(site_name)
		Tonka::HTML.new(site_name,@options)
		Tonka::CSS.new(site_name,@options)
		Tonka::JS.new(site_name,@options)
	end

	def parse_options(options=[])

		@action = @options[0]

		case @action

		when "build"
			#handles the 'build' command

			@site_name = @options[1] || 'sites'

			jquery = true if @options[2] == '-jquery'
			css_reset = true if @options[2] == '-jquery'

			make_directories(@site_name)
			make_files(@site_name)

		when "destroy"
			#handles the 'build' command

			@site_name = @options[1] || 'sites'

			system("rm -rf #{@site_name}")

		when "add"
			#handles the 'build' command

		else
			puts "Oops! I don't know that one."
			display_usage
		end
	end

	def display_usage
		puts "usage: tonka <action> SITE_NAME [-options]\n\nThe most common actions:\n\nbuild\s\t\t\tbuilds a basic static site with the name passed in as SITE_NAME\n\nThe most common options:\n\n-jquery \t\tadds jquery to index.html file.\n-css_reset \t\tadds css resetters to style.css file."
	end

end

class Tonka::HTML
	#CSS processing module
	attr_accessor :layout

	def initialize(site_name,options=[])
		site_name = site_name
		body = options[3] || ""
		jquery = true if options[2] == "-jquery"
		index_html = File.new("#{site_name}/index.html","w")
		@layout = "<!DOCTYPE html>\n<html>\n<head>\n<title>#{site_name}</title>\n<link rel=\"stylesheet\" type=\"text/css\" href=\"/stylesheets/style.css\" />\n<script type=\"text/javascripts\" src=\"/javascripts/scripts.js\"></script>#{ "\n<script type=\"text/javascripts\" src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js\"></script>" if jquery == true }\n</head>\n<body>\n#{ body+"\n" }\</body>\n</html>"
		index_html.puts @layout
		index_html.close
	end
end

class Tonka::CSS
	#CSS processing module
	attr_accessor :layout

	def initialize(site_name,options=[])
		style_css = File.new("#{site_name}/stylesheets/style.css","w")
		style_css_content = "/* html5doctor.com Reset v1.6.1 - http://cssreset.com */\nhtml,body,div,span,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,abbr,address,cite,code,del,dfn,em,img,ins,kbd,q,samp,small,strong,sub,sup,var,b,i,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,figcaption,figure,footer,header,hgroup,menu,nav,section,summary,time,mark,audio,video{margin:0;padding:0;border:0;outline:0;font-size:100%;vertical-align:baseline;background:transparent}body{line-height:1}article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block}nav ul{list-style:none}blockquote,q{quotes:none}blockquote:before,blockquote:after,q:before,q:after{content:none}a{margin:0;padding:0;font-size:100%;vertical-align:baseline;background:transparent}ins{background-color:#ff9;color:#000;text-decoration:none}mark{background-color:#ff9;color:#000;font-style:italic;font-weight:bold}del{text-decoration:line-through}abbr[title],dfn[title]{border-bottom:1px dotted;cursor:help}table{border-collapse:collapse;border-spacing:0}hr{display:block;height:1px;border:0;border-top:1px solid #ccc;margin:1em 0;padding:0}input,select{vertical-align:middle}"
		style_css.puts style_css_content
		style_css.close
	end
end

class Tonka::JS
	#CSS processing module
	attr_accessor :layout

	def initialize(site_name,options=[])
		scripts_js = File.new("#{site_name}/javascripts/scripts.js","w")
		scripts_js_content = "console.log('feed me javascripts')"
		scripts_js.puts scripts_js_content
		scripts_js.close
	end
end