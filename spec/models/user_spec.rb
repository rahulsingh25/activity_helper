# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  unconfirmed_email      :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

require 'spec_helper'

describe User do

  before do
    @user = User.new(username:"rahulsingh", name: "Rahul Singh", email: "user@example.com", password: "foobar12", password_confirmation: "foobar12")
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:name) }
  it { should respond_to(:confirmation_token) }
  it { should respond_to(:activities) }
  it { should respond_to(:username) }
  
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should be_valid }
  end  

  describe "when username is not present" do
    before { @user.username=" " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 31 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn foo@bar+baz.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password=@user.password_confirmation="" }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before {@user.password_confirmation="rahul123"}
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation=nil }
    it { should be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 7 }
    it { should_not be_valid }
  end 

  describe "remember token" do
    before{ @user.save }
    its(:confirmation_token){ should_not be_blank }
    its(:confirmed_at){ should be_blank }
    its(:confirmation_sent_at){ should_not be_blank }
  end

  describe "activity associations" do

    before { @user.save }
    let!(:older_activity) do 
      FactoryGirl.create(:activity, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_activity) do
      FactoryGirl.create(:activity, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right activities in the right order" do
      @user.activities.should == [newer_activity, older_activity]
    end

    it "should destroy associated activities" do
      activities = @user.activities.to_a
      @user.destroy
      expect(activities).not_to be_empty
      activities.each do |activity|
        expect(Activity.where(id: activity.id)).to be_empty
      end
    end
  end

  describe "when username format is invalid" do
    it "should be invalid" do
      usernames = %w[user@foo,com user_at_foo_ _example.user@foo.
                     foo@bar_baz.com 78foo@barbaz.com]
      usernames.each do |invalid_username|
        @user.username = invalid_username
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when username format is valid" do
    it "should be valid" do
      usernames = %w[rahul123 rahul_singh25 arhul_Singh0 rahulsingh]
      usernames.each do |valid_username|
        @user.username = valid_username
        expect(@user).to be_valid
      end
    end
  end
  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end

    it { should_not be_valid }
  end
end

