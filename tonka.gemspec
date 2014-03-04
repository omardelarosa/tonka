require './lib/tonka.rb'

Gem::Specification.new do |s|
	s.name			= "tonka"
	s.version 	= Tonka.version
	s.date			= (Time.now.strftime "%Y-%m-%d")
	s.summary		= "Tonka!"
	s.description	= "A static site builder, destroyer and server."
	s.authors		= ["Omar Delarosa", "Eric Streske", "Brendan Soffientini", "Daniel Bushkanets"]
	s.email			= "thedelarosa@gmail.com"
	s.files			= ["lib/tonka.rb"]
	s.homepage		= "http://github.com/omardelarosa/tonka"
	s.license		= "MIT"
	s.executables << "tonka"
end