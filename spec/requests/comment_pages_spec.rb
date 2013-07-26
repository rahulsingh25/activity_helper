require 'spec_helper'

describe "CommentPages" do
 
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "activity creation followed by comment", js:true do
    describe "activity with valid information" do
      before do
        select 'Sports',         from: "Category"
        fill_in 'Name',          with: "Footbal"
        fill_in 'Description',   with: "I like football" 
        click_button "Post" 
      end
      it { should have_content("I like football") }
      it { should have_link("Comment") }

      describe "with valid information" do
        before do
          click_on("Comment")
          fill_in "comment[content]", with: "hiee rahul" 
          page.execute_script("$('form.create-comment-form').submit()") 
        end
        it { should have_content("hiee rahul") }
      end
    end
  end
end
