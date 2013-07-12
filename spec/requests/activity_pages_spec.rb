require 'spec_helper'

describe "ACTIVITY pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "activity creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a avtivity Post" do
        expect { click_button "Post" }.not_to change(Activity, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
       fill_in 'Category', 		with: "Sports"
       fill_in 'Name', 			with: "Footbal"
       fill_in 'Description', 	with: "I like football" 
   	  end
      it "should create a activity post" do
        expect { click_button "Post" }.to change(Activity, :count).by(1)
      end
    end
  end
end

