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
       select 'Sports', 		    from: "Category"
       fill_in 'Name', 			    with: "Footbal"
       fill_in 'Description', 	with: "I like football" 
   	  end
      it "should create a activity post" do
        expect { click_button "Post" }.to change(Activity, :count).by(1)
      end
    end
  end

  describe "Activities page" do
   # let(:user) { FactoryGirl.create(:user) }
    let!(:a1) { FactoryGirl.create(:activity, user: user, category: "sports", name:"tennis", description:"very popular game") }
    let!(:a2) { FactoryGirl.create(:activity, user: user, category: "movie", name:"pacific rim", description:"released on friday") }

    before { visit root_path }

    it { should have_title(user.name) }

    describe "Activities" do
      it { should have_content(a1.category) }
      it { should have_content(a1.name) }
      it { should have_content(a1.description) }
      it { should have_content(a2.category) }
      it { should have_content(a2.name) }
      it { should have_content(a2.description) }
    end
  end
end

