require 'spec_helper'

describe "MessagesPages", js: true do
  
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user) }

	before do
		sign_in user
	end

	describe "current user after sign in and visit their friends profile" do
		before do
			FactoryGirl.create(:friendship, user:user, friend_id:user2.id)
			visit user_path(user2) 
		end
        it { should have_selector("form") }
        it { should have_selector("textarea") }
        it { should have_selector("button", text:'Send') }

        describe "message creation with invalid info" do
            it "should not create a message" do
                expect { click_button "Send" }.not_to change(Message, :count)
            end
            describe "error messages" do
                before { click_button "Send" }
                it { should have_selector('div.alert.alert-error', text: 'Failed') }
            end
        end

        describe "message creation with valid info" do
            before do
                fill_in 'text[message]', with: "hiii"
            end
            it "should create a message" do
                expect { click_button "Send" }.to change(Message, :count).by(1)
            end
        
            describe "it shout have flash" do
                before do
                    fill_in 'text[message]', with: "hello"
                    click_button "Send"        
                end
                it { should have_selector('div.alert.alert-success', text: 'Message sent Successfully!') }
            end
        end
    end

    describe "current user after sign in and visit others user profile should not have" do
        before do
            visit user_path(user2) 
        end
        it { should have_link("See Friends") }
        it { should_not have_selector("textarea") }
        it { should_not have_selector("button", text:'Send') }
    end
end
