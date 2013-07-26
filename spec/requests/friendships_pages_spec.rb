require 'spec_helper'

describe "FriendshipsPages", js:true do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
  	let(:user2) { FactoryGirl.create(:user) }

  	before do
    	@friendship=user.friendships.build(friend_id:user2.id)
  	end

	describe "click on find friend link" do
    	before do
    		sign_in user
    		visit user_path(user)
    		click_on("Find Friend")
      	end
      	it { should have_content(user2.username) }
      	it { should have_link("Add Friend") }
    end

  
    describe "add friends" do
 		before do
 			sign_in user
 			visit users_path
 		end
    	
    	it " create pending friendship " do
    		expect { click_on("Add Friend") }.to change(Friendship, :count).by(1)
    	end
    end


	describe "see pending/inverse friendship" do
	    
	    before do
	    	@friendship.save
    		sign_in user2
    		visit user_path(user2)
    		click_on("See Pending Request")
    	end
    	it { should have_link("Accept") }
    	it { should have_link("Decline") }
    	it { should have_link(user.username) }
    end

	describe "accept friendship on clicking accept" do
		before do
			@friendship.save
			sign_in user2
			visit user_path(user2)
			click_on("See Pending Request")
			click_on("Accept")
		end 
  		it { should have_selector('div.alert.alert-success', text: 'Accepted') }
  	end

  	describe "accept friendship " do
  		before do
  			@friendship.save
  			sign_in user2
			visit user_path(user2)
			click_on("See Pending Request")
  		end
  		it "should change status" do
  			expect{ click_on("Accept") }.to change{@friendship.reload.status}.from(false).to(true)
  		end
	end

	describe "after clicking accept should not have pending req" do
		before do
			@friendship.save
			sign_in user2
			visit user_path(user2)
			click_on("See Pending Request")
			click_on("Accept")
			click_on("See Pending Request")
			click_on("See Friends")
		end 
  		it { should_not have_link("Accept") }
  		it { should_not have_link("Decline") }
  		it { should have_link(user.username) }
  		it { should have_link("Remove") }

  		describe "click on remove to remove friendship" do
  			before do
  				click_on("Remove")
  				click_on("See Friends")
  			end
  			it { should have_selector('div.alert.alert-success', text: 'Removed') }
  			it { should_not have_link(user.username) }
  			it { should_not have_link("Remove") }
  		end

  		it "should remove friendship" do
  				expect{ click_on("Remove") }.to change(Friendship, :count).by(-1)
  		end
  	end
end
