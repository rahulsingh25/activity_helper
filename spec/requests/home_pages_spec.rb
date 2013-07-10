require 'spec_helper'

describe "Home page" do

subject{ page }

	describe "after visiting home page" do

	 	 before{ visit root_path }

	 	 it { should have_title("ActivityHelper") }
	 	 it { should have_link("Activities", href: "#") }
	 	 it { should have_link("Register", href: "#") }
	 	 it { should have_link("Sign In", href: "#") }
	 	 it { should have_selector("input") }
	 	 
	end

	
end
