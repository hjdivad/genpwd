require 'rubygems'

require 'fileutils'
require 'ruby-debug'
require 'spec'
require 'yaml'

require 'lang_utils'


$gpd = '--genpwd test/genpwd'
describe 'genpwd' do
	before(:each) do
		FileUtils.rm_r 'test', :force => true
		FileUtils.mkdir_p 'test/genpwd'
		File.open('test/genpwd/password', 'w'){|f| f.puts 'test'}
	end


	describe 'options' do
		it "should allow the option --report-genpwd to report the '.genpwd'
		directory, and default it to ~/.genpwd".compact! do
			File.expand_path( `./bin/genpwd --report-genpwd`.chomp).should == 
				File.expand_path( "~/.genpwd")
		end

		it "Should allow the option --genpwd to set GENPWD to an arbitrary
		location".compact! do
			File.expand_path( 
				`./bin/genpwd #{$gpd} --report-genpwd`.chomp
			).should == 
				File.expand_path( "#{FileUtils.pwd}/test/genpwd")
		end

		it "Should allow the option --alphabet to specify the special characters
		alphabet".compact! do
			`./bin/genpwd #{$gpd} --new test@hjdivad.com \
					--alphabet-ext="[]@#"`.chomp.should ==
				'kdjgnHy5EdGr74l5'
		end

		it "should allow the option --legacy to generate old passwords" do
			`./bin/genpwd --legacy test@hjdivad.com`.should ==
				"4?a*7(d%e~2^e~ef\n" +
				"4#a`7`de\n" +
				"4a7de2ee\n"
		end
	end


	it "Should refuse to run if GENPWD/password does not exist or is
	empty".compact! do
		FileUtils.rm 'test/genpwd/password'
		`./bin/genpwd #{$gpd} --new test@test.com`.chomp.should ==
			"Unable to find test/genpwd/password -- please specify a password"
	end

	it "should allow the option --list to list keys (listings should include
	ALPHABET)".compact! do
		system "./bin/genpwd #{$gpd} --new test@test1.com > /dev/null"
		system "./bin/genpwd #{$gpd} --new test@test2.com \
					-a \"*()\" > /dev/null"
		system "./bin/genpwd #{$gpd} --new test@test3.com > /dev/null"
		YAML::load_file( 'test/genpwd/keys').should ==
			[{ :key => 'test@test1.com' },
			{ :key => 'test@test2.com', :alpha_ext => '*()'},
			{ :key => 'test@test3.com'}]

		`./bin/genpwd #{$gpd} --list`.should ==
			"test@test1.com\n" +
			"test@test2.com\talpha-ext=*()\n" +
			"test@test3.com\n"
	end

	it "should allow list to filter on an optional pattern" do
		system "./bin/genpwd #{$gpd} --new test@test1.com > /dev/null"
		system "./bin/genpwd #{$gpd} --new test@test2.com \
					-a \"*()\" > /dev/null"
		system "./bin/genpwd #{$gpd} --new test@test3.com > /dev/null"

		`./bin/genpwd #{$gpd} --list="test[23]"`.should ==
			"test@test2.com\talpha-ext=*()\n" +
			"test@test3.com\n"
	end

	it "should allow the option --remove to remove keys" do
		system "./bin/genpwd #{$gpd} --new test@hjdivad.com > /dev/null"
		system "./bin/genpwd #{$gpd} --remove test@hjdivad.com"
		File.should be_exist( 'test/genpwd/keys')
		YAML::load_file( 'test/genpwd/keys').should ==
			[]
	end

	it "should allow the option --new to create a new key" do
		system "./bin/genpwd #{$gpd} --new test@hjdivad.com > /dev/null"
		File.should be_exist( 'test/genpwd/keys')
		YAML::load_file( 'test/genpwd/keys').should ==
			[{ :key => 'test@hjdivad.com' }]
	end

	it "should lookup existing values by default" do
		system "./bin/genpwd #{$gpd} --new test@hjdivad.com > /dev/null"
		`./bin/genpwd #{$gpd} test@hjdivad.com`.chomp.should ==
			'XQv(]H?^EpS|74l^'
	end

	it "should not generate a new key without --new" do
		system "./bin/genpwd #{$gpd} --new testa@hjdivad.com > /dev/null"
		system "./bin/genpwd #{$gpd} test@hjdivad.com > /dev/null"
		YAML::load_file( 'test/genpwd/keys').should ==
			[{ :key => 'testa@hjdivad.com' }]
	end
end
