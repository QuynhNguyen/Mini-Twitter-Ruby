require 'spec_helper'



describe User do

  before(:each) do
    @attr = {:name => "Test User", :email => "test@test.com"}
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
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

