require 'spec_helper'

describe "Static pages" do

  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(title)) }
  end


  describe "Home page" do
    before { visit root_path }
    let(:heading) {'Sample App'}
    let(:title) {''}

    it_should_behave_like "all static pages" 
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
   end
  end
  

  describe "Help page" do
    before { visit help_path }
    let(:heading) {'Help'}
    let(:title) {'Help'}

    it_should_behave_like "all static pages" 
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) {'About'}
    let(:title) {'About Us'}

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:title) { 'Contact' }
    
    it_should_behave_like "all static pages"
  end
end
