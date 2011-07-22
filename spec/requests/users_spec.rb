require 'spec_helper'

describe "Users" do

  describe 'sign up' do

    describe 'failure' do
      it 'should not create a user' do
        lambda do
          visit signup_path
          fill_in "name",       :with => ""
          fill_in "Email",      :with => ""
          fill_in "Password",   :with => ""
          fill_in "Confirm",    :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector('div .error')
        end.should_not change(User, :count)
      end
    end

    describe 'success' do
      it 'should create a user' do
        lambda do
          visit signup_path
          fill_in "name",       :with => "Example User"
          fill_in "Email",      :with => "foobar@yahoo.com"
          fill_in "Password",   :with => "foobar1"
          fill_in "Confirm",    :with => "foobar1"
          click_button
          response.should have_selector('div.success', :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end

  end


end

