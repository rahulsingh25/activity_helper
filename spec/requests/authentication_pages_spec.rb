require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit user_session_path }

    it { should have_selector('h2',    text: 'Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit user_session_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-alert', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Sign In" }
        it { should_not have_selector('div.alert.alert-alert') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in(user)                # utilities.rb function
      end

      it { should have_title(user.username) }
      it { should have_link('Activities',    href: "#") }
      it { should have_link('Logout', href: destroy_user_session_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should_not have_link('Sign In', href: user_session_path) }

      describe "followed by signout" do
        before { click_link "Logout" }
        it { should have_link('Sign In') }
      end
    end
  end

  describe "authorization" do

    describe "for non signed users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in activities controller" do
        describe "submitting to the create action" do
          before { post user_activities_path(user) }
          specify { expect(response).to redirect_to(new_user_session_path) }
        end

        describe "submitting to the destroy action" do
          before { delete user_activity_path(user,FactoryGirl.create(:activity)) }
          specify { expect(response).to redirect_to(new_user_session_path) }
        end
      end
    end

    # describe "as non-admin user" do
    #   let(:user) { FactoryGirl.create(:user) }
    #   let(:non_admin) { FactoryGirl.create(:user) }

    #   before { sign_in non_admin }

    #   describe "submitting a DELETE request to the Users#destroy action" do
    #     before { delete user_path(user) }
    #     specify { response.should redirect_to(root_path) }
    #   end
    # end

  #   describe "for non-signed-in users" do
  #     let(:user) { FactoryGirl.create(:user) }

  #     describe "when attempting to visit a protected page" do
  #       before do
  #         visit edit_user_path(user)
  #         fill_in "Email",    with: user.email
  #         fill_in "Password", with: user.password
  #         click_button "Sign in"
  #       end

  #       describe "after signing in" do

  #         it "should render the desired protected page" do
  #           page.should have_title('Edit user')
  #         end
  #         # A test for forwarding to the default page after friendly forwarding. 
  #         describe "when signing in again" do
  #           before do
  #             delete signout_path
  #             visit signin_path
  #             fill_in "Email",    with: user.email
  #             fill_in "Password", with: user.password
  #             click_button "Sign in"
  #           end

  #           it "should render the default (profile) page" do
  #             page.should have_title(user.name)
  #           end
  #         end
  #       end
  #     end

  #     describe "in the Users controller" do

  #       describe "visiting the edit page" do
  #         before { visit edit_user_path(user) }
  #         it { should have_title('Sign in') }
  #       end

  #       describe "submitting to the update action" do
  #         before { put user_path(user) }
  #         specify { response.should redirect_to(signin_path) }
  #       end

  #       describe "visiting the user index" do
  #         before { visit users_path }
  #         it { should have_title('Sign in') }
  #       end
  #     end
  #   end

  #   describe "as wrong user" do
  #     let(:user) { FactoryGirl.create(:user) }
  #     let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
  #     before { sign_in user }

  #     describe "visiting Users#edit page" do
  #       before { visit edit_user_path(wrong_user) }
  #       it { should_not have_selector('title', text: full_title('Edit user')) }
  #     end

  #     describe "submitting a PUT request to the Users#update action" do
  #       before { put user_path(wrong_user) }
  #       specify { response.should redirect_to(root_path) }
  #     end
     end
   end
