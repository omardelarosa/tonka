class Tonka

	attr_accessor :options, :site_name, :action, :messages

	attr_reader :version

	def initialize(options=[])

		@version = "0.0.2b1";

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
			puts "\t\tbuilt ".green+"#{site_name}/stylesheets/"

			Dir.mkdir "#{site_name}/javascripts"
			puts "\t\tbuilt ".green+"#{site_name}/javascripts/"
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

		when "-v"

			puts @version

		when "build"
			#handles the 'build' command

			@site_name = @options[1] || 'sites'

			jquery = true if @options[2] == '-jquery'
			css_reset = true if @options[2] == '-jquery'

			make_directories(@site_name)
			make_files(@site_name)

			puts "\n\t\tthe construction of "+"#{@site_name}".green+" is now complete!"		

		when "destroy"
			#handles the 'destroy' command

			@site_name = @options[1] || 'sites'
			if Dir.exist? @site_name
				system("rm -rf #{@site_name}")
				puts "\t\tdemolished ".red+"#{@site_name}"
			else
				"Oops! There is no directory called #{@site_name}!"
			end

		when "add"
			#handles the 'add' command

		else
			puts "Oops! I don't know that one."
			display_usage
		end
	end

	def display_usage
		puts "usage: tonka <action> SITE_NAME [-options] BODY_TEXT\n\nThe most common actions:\n\nbuild\s\t\t\tbuilds a basic static site with the name passed in as SITE_NAME\n\nThe most common options:\n\n-jquery \t\tadds jquery to index.html file.\n-css_reset \t\tadds css resetters to style.css file."
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
		@layout = "<!DOCTYPE html>\n<html>\n<head>\n<title>#{site_name}</title>\n<link rel=\"stylesheet\" type=\"text/css\" href=\"stylesheets/style.css\" />#{ "\n<script type=\"text/javascript\" src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js\"></script>" if jquery == true }\n<script type=\"text/javascript\" src=\"javascripts/scripts.js\"></script>\n</head>\n<body>\n#{ body+"\n" }\</body>\n</html>"
		index_html.puts @layout
		index_html.close
		puts "\t\tbuilt ".green+"#{site_name}/index.html"
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
		puts "\t\tbuilt ".green+"#{site_name}/stylesheets/style.css"
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
		puts "\t\tbuilt ".green+"#{site_name}/javascripts/scripts.js"
	end
end

class String
	# text colorization
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end

	def red
		colorize(31)
	end

	def green
		colorize(32)
	end

	def yellow
		colorize(33)
	end

	def pink
		colorize(35)
	end
end