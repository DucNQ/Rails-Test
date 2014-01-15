require 'spec_helper'

describe "User pages" do
  subject {page}
  describe "profile page" do
  	let(:user) { FactoryGirl.create :user }
  	let!(:e1) { FactoryGirl.create :entry, user: user}
  	let!(:e2) { FactoryGirl.create :entry, user: user}
  	
  	before { visit user_path user }

  	it { should have_content user.name }
  
    describe "Entries" do
      it { should have_content(e1.title) }
      it { should have_content(e1.body) }
      it { should have_content(e2.title) }
      it { should have_content(e2.body) }
      it { should have_content(user.entries.count) }
    end
  end
end