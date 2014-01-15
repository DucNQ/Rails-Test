require 'spec_helper'

describe Entry do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@entry = Entry.new(title: "Title.No1", body: "Body.No.1", user_id: user.id)
  end

  subject { @entry }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user id is not present" do
  	before { @entry.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when title is not present" do
  	before { @entry.title = " " }
  	it { should_not be_valid }
  end

  describe "when title is too long" do
  	before { @entry.title = "a"*51 }
  	it { should_not be_valid }
  end
  describe "when body is not present" do
  	before { @entry.body = " " }
  	it { should_not be_valid }
  end
end
