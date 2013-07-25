require 'spec_helper'

describe Message do
  
	let!(:user)  { FactoryGirl.create(:user) }
	before do 
		@friendship=user.friendships.build(friend_id:2)
		@friendship.save 
		@message=@friendship.messages.create(message: "hi")
	end

	subject { @message }

	it { should respond_to(:friendship_id) }
	it { should respond_to(:message) }
	it { should respond_to(:friendship) }
	
	it { should be_valid }


	describe "when friendship_id is not present" do
    	before { @message.friendship_id = nil }
    	it { should_not be_valid }
  	end

  	describe "when message is not present" do
    	before { @message.message = nil }
    	it { should_not be_valid }
  	end
end