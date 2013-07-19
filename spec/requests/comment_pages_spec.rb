require 'spec_helper'

describe "CommentPages" do
 
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "activity creation", js:true do

		let!(:a1) { FactoryGirl.create(:activity, user: user) }
    	
    	before do
    		visit root_path
    		a1.save
       	end

    	describe "should have link to comment" do
    		it { should have_link("Comment") }
    	end

    	describe "with valid information" do
      		let!(:c1) { FactoryGirl.create(:comment, user: user, activity: a1) }

      		before do
        		c1.save
        		visit root_path
      		end

      		it { should have_content("hello") } 
    	end
  	end
end
