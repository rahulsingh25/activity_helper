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

end
