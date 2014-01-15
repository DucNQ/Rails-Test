require 'spec_helper'

describe User do
  before do 
  	@user = User.new(	name: "Example User", 
  						email: "user@example.com", 
  						password: "foobar", 
  						password_confirmation: "foobar")
  end
  
  subject { @user }

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:follow!) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }

  it { should be_valid }  
  it { should_not be_admin }

  describe "with admin attribute set to 'true' " do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it {should be_admin}
  end
  
  describe "When name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "When email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when password is not present" do
	before do
	   @user = User.new(name: "Example User", email: "user@example.com",
	                     password: " ", password_confirmation: " ")
	end

	it { should_not be_valid }
  end

  describe "When name is too long" do
  	before { @user.name = "a"*52}
  	it { should_not be_valid }
  end

  describe "When email is too long" do
  	before { @user.email = "a"*33}
  	it { should_not be_valid }
  end

  describe "When email format is invalid" do
  	it "should be invalid" do
	  	addresses = %w[user@foo,com user_at_foo.org invalliiiid@foo. foo@bar_baz.com duviiiii@bar+baz.com omg@a..a]
	  	addresses.each do |invalid_address|
	  		@user.email = invalid_address
	  		expect(@user).not_to be_valid
	  	end
  	end
  end

  describe "When email format is valid" do
	it "should be valid" do
	  	addresses = %w[user@foo.com user_@foo.org valliiiid@foo.jp]
	  	addresses.each do |valid_address|
	  		@user.email = valid_address
	  		expect(@user).to be_valid 
	  	end
  	end
  end

  describe "When email is not unique" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email.upcase!
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "email address with mixed case" do
  	let(:mixed_case_email) { "Foo@ExAMPle.cOM" }

  	it "should be saved as all lower-case" do
  		@user.email = mixed_case_email
  		@user.save
  		expect(@user.reload.email).to eq mixed_case_email.downcase
  	end
  end

  describe "when password doesn't match confirmation" do
  	before {@user.password_confirmation = "mismatch"}
  	it {should_not be_valid}
  end

  describe "return value of authenticate method" do
  	before {@user.save}
  	let(:found_user) { User.find_by(email: @user.email) }

  	describe "with valid password" do
  		it { should eq found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("invalid")}

  		it { should_not eq user_for_invalid_password }
  		specify { expect(user_for_invalid_password).to be_false }
  	end

  	describe "with a password that's too short" do
  	  before { @user.password = @user.password_confirmation = "a" * 5 }
  	  it { should be_invalid }
  	end
  end

  describe "remember token" do
    before {@user.save}
    its(:remember_token) { should_not be_blank }
  end
  
  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do 
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) } 
  
    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end
    
    describe "and unfollowing" do
      before { @user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end
end
