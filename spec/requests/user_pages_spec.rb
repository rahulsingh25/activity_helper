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
        fill_in "Username",      with: "rahul692000"
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

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:a1) { FactoryGirl.create(:activity, user: user, category: "sports", name:"tennis", description:"very popular game") }
    let!(:a2) { FactoryGirl.create(:activity, user: user, category: "movie", name:"pacific rim", description:"released on friday") }

    before { visit user_path(user) }

    it { should have_title(user.name) }

  describe "Activities" do
      it { should have_content(a1.category) }
      it { should have_content(a1.name) }
      it { should have_content(a1.description) }
      it { should have_content(a2.category) }
      it { should have_content(a2.name) }
      it { should have_content(a2.description) }
      it { should have_content(user.activities.count) }
    end
  end
end
