# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User | Login' do
  let!(:user) { User.create!(name: 'dominic', email: 'dominicod@gmail.com', password: 'password_1', password_confirmation: 'password_1') }

  describe 'When I visit /login;'
  it 'I see a form to login' do
    visit login_path

    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_button('Log In')
  end

  context 'Happy Path' do
    it 'should take the user to their dashboard page after they login' do
      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: 'password_1'
      click_on 'Log In'

      expect(page.current_path).to eq user_path
      expect(page).to have_content("Welcome, #{User.last.name}")
    end
  end

  context 'Sad Path' do
    it 'should return user to login form if information is incorrect' do
      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: 'password_10000'
      click_on 'Log In'

      expect(page.current_path).to eq login_path
      expect(page).to have_content('Error: Incorrect Credentials')
    end

    it 'If I am not logged in I cannot go to other pages' do
      visit user_path

      expect(page).to have_content('You must be a registered user to access this page')
      expect(page.current_path).to eq root_path
    end
  end
end
