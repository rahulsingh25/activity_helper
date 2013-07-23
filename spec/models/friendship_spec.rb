require 'spec_helper'

describe Friendship do
  
	let!(:user)  { FactoryGirl.create(:user) }
	before { @friendship=user.friendships.build(friend_id:2) }

	subject { @friendship }

	it { should respond_to(:user_id) }
	it { should respond_to(:friend_id) }
	it { should respond_to(:status) }
	it { should respond_to(:user) }
	it { should respond_to(:friend) }
	
	it { should be_valid }


	describe "when user_id is not present" do
    	before { @friendship.user_id = nil }
    	it { should_not be_valid }
  	end

  	describe "when frined_id is not present" do
    	before { @friendship.friend_id = nil }
    	it { should_not be_valid }
  	end
end
