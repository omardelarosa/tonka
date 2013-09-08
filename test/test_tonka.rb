require 'test/unit'
require 'tonka'

class TonkaTest < Test::Unit::TestCase

	attr_accessor :site

	def test_build_site_command
		#build a site called 'test_site'
		@site = Tonka.new(["build","test_site"])
		#assert its existence in the working directory
		assert_equal Dir["test_site"],["test_site"]
	end

	def test_destroy_site_command
		#destroys a site called 'test_site'
		Tonka.new(["destroy","test_site"])
		assert_equal Dir["test_site"],[]
	end


end