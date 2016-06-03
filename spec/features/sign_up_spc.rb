require 'rails_helper'

describe 'sign up' do 
  context 'with admin privilege' do 
    it 'increases user count by 1' do 
      binding.pry
      when_current_user_is :admin
      visit create_user_session_url
      fill_in 'user_name', with: 'Blah Smith'
      fill_in 'user_email', with: 'blah@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      select 'Admin', from: 'user_admin'
      #binding.pry
      expect { click_on 'Sign up' }
      .to change { User.count }
      .by 1
      #binding.pry
    end
  end
end