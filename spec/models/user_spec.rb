require 'spec_helper'



describe User do

  before(:each) do
    @attr = {:name => "Test Me1", :email => "test@tes3t.com", :password => "testme", :password_confirmation => "testme"}
  end

  it 'should create a valid instance given a valid attribute' do
    User.create!(@attr)
  end

  it 'should require a name' do
    no_name = User.new(@attr.merge(:name => ""))
    no_name.should_not be_valid
  end

  it 'should require an email' do
    no_email = User.new(@attr.merge(:email => ""))
    no_email.should_not be_valid
  end

  it 'should have less than 51 length name' do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it 'should have a valid email address' do
    address = %w[user@foot.com the_user@foo.bar.org first.last@foo.jp]
    address.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it 'should reject invalid email' do
    address = %w[user@foot,com the_userfoo.bar.org first.last@foo]
    address.each do |address|
      invalid_email = User.new(@attr.merge(:email => address))
      invalid_email.should_not be_valid
    end
  end

  it 'reject duplicate email address' do
    User.create!(@attr)
    user_with_duplicate_email = User.create(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it 'should reject email address that identical up to case' do
    upcased_email = "USER@FOOT.COM"
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr.merge(:email => "user@foot.com"))
  end

  describe 'password' do

    before(:each) do
      @user = User.new(@attr)
    end

    it 'should have a password attribute' do
      User.new(@attr).should respond_to(:password)
    end

    it 'should have a password confirmation' do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe 'password validation' do
    it 'should rqeuire a password' do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it 'should require a matching password confirmation' do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end

    it 'should reject short password' do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it 'should reject long password' do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe 'encrypted password' do
    before(:each) do
      @user = User.create!(@attr)
    end
    it 'should have encrypted password attribute' do
      @user.should respond_to(:encrypted_password)
    end
  end
end



# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  age                :integer
#  encrypted_password :string(255)
#

