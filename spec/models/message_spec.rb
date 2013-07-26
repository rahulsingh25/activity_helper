# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  message      :text
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  recipient_id :integer
#

require 'spec_helper'

describe Message do
  
	let!(:user)  { FactoryGirl.create(:user) }
	let!(:user2)  { FactoryGirl.create(:user) }
	before do
		@message=user.messages.build(message: "hi",recipient_id:user2.id)
	end

	subject { @message }

	it { should respond_to(:user_id) }
	it { should respond_to(:message) }
	it { should respond_to(:recipient_id) }
	it { should respond_to(:user) }
	it { should respond_to(:recipient) }

	
	it { should be_valid }


	describe "when recipient_id is not present" do
    	before { @message.recipient_id = nil }
    	it { should_not be_valid }
  	end

  	describe "when message is not present" do
    	before { @message.message = nil }
    	it { should_not be_valid }
  	end

  	describe "when user id is not present" do
    	before { @message.user_id = nil }
    	it { should_not be_valid }
  	end
end
