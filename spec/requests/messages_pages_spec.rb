require 'spec_helper'

describe "MessagesPages" do
  
  	subject { page }
  	let(:user) { FactoryGirl.create(:user) }
  	let(:user2) { FactoryGirl.create(:user) }
  	before do
  		sign_in user
  	end

  	describe "current user profile page after sign in and visit their friends profile" do
  		before do
  			FactoryGirl.create(:friendship, user:user, friend_id:user2.id)
  			visit user_path(user2) 
  		end
		it { should have_selector("form") }
    	it { should have_selector("textarea") }
    	it { should have_selector("button", text:'Send') }
  	end
end
