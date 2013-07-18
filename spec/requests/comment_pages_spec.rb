require 'spec_helper'

describe "CommentPages" do
 
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	# describe "after activity creation" do
	# 	let!(:a1) { FactoryGirl.create(:activity, user: user, category: "sports", name:"tennis", description:"very popular game") }
 #    let!(:a2) { FactoryGirl.create(:activity, user: user, category: "movie", name:"pacific rim", description:"released on friday") }

 #    before { visit root_path }

 #    description "should have link to comment" do
 #    	it { should have_link("Comment") }
 #    end
 #  end
end
