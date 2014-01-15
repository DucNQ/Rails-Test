require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "Home page" do
  	before {visit root_url}
   	
    it { should have_content "Blog website" }
    it { should have_link "Help" }
    it { should have_link "Contact" }
    it { should have_link "About" }
  end
end
