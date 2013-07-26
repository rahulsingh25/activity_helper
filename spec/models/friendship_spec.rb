# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  status     :boolean          default(FALSE)
#

require 'spec_helper'

describe Friendship do
  
	let!(:user)  { FactoryGirl.create(:user) }
	let!(:user2)  { FactoryGirl.create(:user) }


	before do
		ActionMailer::Base.deliveries = []
		@friendship=user.friendships.build(friend_id:user2.id)
		@friendship.save
	end


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

  	# describe "should sends a e-mail" do
  	# 	before{ FriendshipMailer.friendship_email(user2).deliver }
   #  	ActionMailer::Base.deliveries.should_not be_empty
   #  	ActionMailer::Base.deliveries.last.should == "rahul"
   #  	@mail.subject.should == I18n.t('emailer.friendship_email.subject')
   #  	last_email.to.should include(user.email)
  	# end
end
