# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User | Login' do
  describe 'When I visit /login;'
  it 'I see a form to login' do
    visit login_path

    expect(page).to have_field(:user_email)
    expect(page).to have_field(:user_password)
    expect(page).to have_button('Login')
  end

  context 'Happy Path' do
    it 'should take the user to their dashboard page after they login' do
      User.create!(name: 'dominic', email: 'dominicod@gmail.com', password: 'password_1', password_confirmation: 'password_1')
      visit login_path

      fill_in :user_email, with: 'dominicod@gmail.com'
      fill_in :user_password, with: 'password_1'
      click_on 'Login'

      expect(page.current_path).to eq user_path(User.last)
      expect(page).to have_content("Welcome #{User.last.name}")
    end
  end

  context 'Sad Path' do
    it 'should return user to login form if information is incorrect' do
      User.create!(name: 'dominic', email: 'dominicod@gmail.com', password: 'password_1', password_confirmation: 'password_1')
      visit login_path

      fill_in :user_email, with: 'dominicod@gmail.com'
      fill_in :user_password, with: 'password_10000'
      click_on 'Login'

      expect(page.current_path).to eq login_path
      expect(page).to have_content('Error: Incorrect Credentials')
    end
  end
end
