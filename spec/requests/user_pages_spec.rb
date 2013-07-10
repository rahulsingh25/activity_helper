require 'spec_helper'

describe "UserPages" do
  
	subject { page }

	let(:user) { FactoryGirl.create(:user) }

	describe "signup page" do
    	before { visit new_user_registration_path }

    	it { should have_selector('h2',text: 'Sign up') }
    	it { should have_title('Sign Up') }
  	end

  	describe "profile page" do
    	before { visit user_path(user) }

    	it { should have_selector('h1',text: user.name) }
    	it { should have_title(user.name) }
  	end

  	describe "signup" do

    before { visit new_user_registration_path }

    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar12"
        fill_in "Password confirmation", with: "foobar12"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-notice', text: 'Welcome') }
        it { should have_link('Logout') }
      end

    end
  end

end
