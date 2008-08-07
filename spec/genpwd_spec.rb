require 'spec'

describe 'genpwd' do

	it "Should refuse to run if $GENPWD/password does not exist or is
	empty".compact!

	it "Should default $GENPWD to ~/.genpwd"

	it "Should allow the option --genpwd to set $GENPWD to an arbitrary location"

	it "Should allow the option --alphabet to specify the special characters alphabet"

	it "should allow the option --legacy to generate old passwords"


	it "should allow the option --list to list keys (listings should include ALPHABET)"

	it "should allow the option --remove to remove keys"

	it "should allow the option --new to create a new key"

	it "should give an error if an unknown key is specified without --new"
end
