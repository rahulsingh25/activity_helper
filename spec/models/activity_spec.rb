# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  category    :string(255)
#  name        :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Activity do

  let(:user) { FactoryGirl.create(:user) }
  
  before { @activity = user.activities.build(category: 'sports', name: 'football', description: "I like football") }
  

  subject { @activity }

  it { should respond_to(:category) }
  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user) }
  it { should respond_to(:comments) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @activity.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank category" do
    before { @activity.category = " " }
    it { should_not be_valid }
  end

  describe "with blank activity name" do
    before { @activity.name = " " }
    it { should_not be_valid }
  end

  describe "with blank description" do
    before { @activity.description = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @activity.description = "a" * 201 }
    it { should_not be_valid }
  end

  describe "Comment associations" do

    before do
      user.save
      @activity.save
    end
    let!(:older_comment) do 
       FactoryGirl.create(:comment, content:"good game", user:user, activity:@activity, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, content:"nice game", user:user, activity:@activity, created_at: 1.hour.ago)
    end

    it "should have the right comments in the right order" do
      @activity.comments.should == [newer_comment, older_comment]
    end

    it "should destroy associated comments" do
      comments=@activity.comments.to_a
      @activity.destroy
      expect(comments).not_to be_empty
      comments.each do |comment|
        expect(Comment.where(id: comment.id)).to be_empty
      end
    end
  end

end
