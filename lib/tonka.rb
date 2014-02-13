require 'net/http'

class Tonka

	attr_accessor :options, :site_name, :action, :messages

	attr_reader :version

	def initialize(options=[])

		@version = "0.0.3";

		@options = options || ARGV
		if !@options[0].nil?

			parse_options(@options)

		else
			display_usage
		end
	end

	def make_directories
		if !Dir.exist? $SITE_NAME
			Dir.mkdir $SITE_NAME
			Dir.mkdir "#{$SITE_NAME}/stylesheets"
			puts "\t\tbuilt ".green+"#{$SITE_NAME}/stylesheets/"

			Dir.mkdir "#{$SITE_NAME}/javascripts"
			puts "\t\tbuilt ".green+"#{$SITE_NAME}/javascripts/"
		else
			puts "a '#{$SITE_NAME}' directory already exists!"
			display_usage
		end
	end

	def make_files
		Tonka::HTML.new(@options).render(@options)
		Tonka::CSS.new(@options)
	end

	def parse_options(options=[])

		@action = @options[0]

		case @action

		when "-v"

			puts @version

		when "build"
			#handles the 'build' command

			$SITE_NAME = @options[1] || 'sites'

			jquery = true if @options[2] == '-jquery'
			css_reset = true if @options[2] == '-jquery'

			make_directories
			make_files

			puts "\n\t\tthe construction of "+"#{$SITE_NAME}".green+" is now complete!"		

		when "destroy"
			#handles the 'destroy' command

			$SITE_NAME = @options[1] || 'sites'
			if Dir.exist? $SITE_NAME
				system("rm -rf #{$SITE_NAME}")
				puts "\t\tdemolished ".red+"#{$SITE_NAME}"
			else
				"Oops! There is no directory called #{$SITE_NAME}!"
			end

		when "add"
			#handles the 'add' command

		else
			puts "Oops! I don't know that one."
			display_usage
		end
	end

	def display_usage
		puts "usage: tonka <action> SITE_NAME [-options] BODY_TEXT\n\nThe most common actions:\n\nbuild\s\t\t\tbuilds a basic static site with the name passed in as SITE_NAME\n\nThe most common options:\n\n-jquery \t\tadds jquery to index.html file.\n-underscore \t\tadds underscore.js to the javascripts folder and the index.html file.\n-backbone \t\tadds backbone.js to the javascripts folder and the index.html file."
	end

end

class Tonka::HTML
	#CSS processing module
	attr_accessor :layout

	def initialize(options=[])
		@layout_arrays = []
		@layout_array_1 = ["<!DOCTYPE html>\n",
										"<html>\n",
										"<head>\n",
										"\t<title>#{$SITE_NAME}</title>\n",
										"\t<link rel=\"stylesheet\" type=\"text/css\" href=\"stylesheets/style.css\" />\n"]
		@script_array = add_js_files(options)
		@layout_array_2 = [
										"</head>\n",
										"<body>\n",
										"\</body>\n",
										"</html>"]



		
	end

	def render(options)
		@index_html = File.new("#{$SITE_NAME}/index.html","w")
		@layout = @layout_array_1.join("") + @script_array.join("") + @layout_array_2.join("")
		@index_html.puts @layout
		@index_html.close
		puts "\t\tbuilt ".green+"#{$SITE_NAME}/index.html"

	end

	def add_js_files(options)
		tags = []
		options.each do |option|
			library_name = option.gsub("-","")
			if library_name == "backbone" && !options.include?("jquery")
				jquery = Tonka::JS.new("jquery")
				tags << jquery.script_tag
			end
			if library_name == "backbone" && !options.include?("underscore")
				underscore = Tonka::JS.new("underscore")
				tags << underscore.script_tag
			end
			Tonka::JS.libraries.each do |library|
				if library[library_name]
					js = Tonka::JS.new(library_name)
					tags << js.script_tag

				end
			end
		end
		tags << Tonka::JS.new("app").script_tag
		return tags
	end


end

class Tonka::CSS
	#CSS processing module
	attr_accessor :layout

	def initialize(options=[])
		style_css = File.new("#{$SITE_NAME}/stylesheets/style.css","w")
		style_css_content = "/* html5doctor.com Reset v1.6.1 - http://cssreset.com */\nhtml,body,div,span,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,abbr,address,cite,code,del,dfn,em,img,ins,kbd,q,samp,small,strong,sub,sup,var,b,i,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,figcaption,figure,footer,header,hgroup,menu,nav,section,summary,time,mark,audio,video{margin:0;padding:0;border:0;outline:0;font-size:100%;vertical-align:baseline;background:transparent}body{line-height:1}article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block}nav ul{list-style:none}blockquote,q{quotes:none}blockquote:before,blockquote:after,q:before,q:after{content:none}a{margin:0;padding:0;font-size:100%;vertical-align:baseline;background:transparent}ins{background-color:#ff9;color:#000;text-decoration:none}mark{background-color:#ff9;color:#000;font-style:italic;font-weight:bold}del{text-decoration:line-through}abbr[title],dfn[title]{border-bottom:1px dotted;cursor:help}table{border-collapse:collapse;border-spacing:0}hr{display:block;height:1px;border:0;border-top:1px solid #ccc;margin:1em 0;padding:0}input,select{vertical-align:middle}"
		style_css.puts style_css_content
		style_css.close
		puts "\t\tbuilt ".green+"#{$SITE_NAME}/stylesheets/style.css"
	end
end

class Tonka::JS
	#CSS processing module
	attr_accessor :layout, :script_tag, :libraries

	def self.libraries
		[
			{"jquery" => "http://code.jquery.com/jquery-1.10.2.min.js"},
			{"underscore" => "https://raw.github.com/jashkenas/underscore/master/underscore.js"},
			{"backbone" => "https://raw.github.com/jashkenas/backbone/master/backbone.js"}
		]
	end

	def initialize(file_name,options=[]) 
		@script_tag = generate_file(file_name)
	end

	def generate_file(file_name)
		
		js_file = File.new("#{$SITE_NAME}/javascripts/#{file_name}.js","w")
		if file_name == "app"
			js_file_content = "console.log('feed me javascripts')"
		else 
			uri = ''
			Tonka::JS.libraries.each do |library|
				uri = library[file_name] if library[file_name]
			end
			js_file_content = Net::HTTP.get(URI(uri))
		end
		js_file.puts js_file_content
		js_file.close
		script_tag = "\t<script src='/javascripts/#{file_name}.js'></script>\n"
		puts "\t\tbuilt ".green+"#{$SITE_NAME}/javascripts/#{file_name}.js"
		return script_tag
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