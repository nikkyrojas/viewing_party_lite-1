# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User | Register/New' do
  describe 'When I visit /register;'
  it 'I see a form to register' do
    visit register_path

    expect(page).to have_field(:name)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_field(:password_confirmation)
    expect(page).to have_button('Register')
  end
  context 'Happy Path' do
    it 'should take the user to their dashboard page after they register' do
      visit register_path

      fill_in :name, with: 'Katy Perry'
      fill_in :email, with: 'katyperry@email.com'
      fill_in :password, with: 'password_1'
      fill_in :password_confirmation, with: 'password_1'
      click_on 'Register'

      test = User.last

      expect(current_path).to eq("/dashboard")
      expect(test.email).to eq('katyperry@email.com')
    end
  end
  context 'Sad Path' do
    it 'should not register the user if the email address is already in use' do
      visit register_path

      User.create(name: 'Michael Jackson', email: 'michaeljackson@email.com', password: 'password_1', password_confirmation: 'password_1')
      fill_in :name, with: 'micheal impersonator'
      fill_in :email, with: 'michaeljackson@email.com'
      fill_in :password, with: 'password_1'
      fill_in :password_confirmation, with: 'password_1'
      click_on 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content('Error: Email has already been taken')
    end

    it 'should not register the user if passwords do not match' do
      visit register_path

      fill_in :name, with: 'micheal impersonator'
      fill_in :email, with: 'michaeljackson@email.com'
      fill_in :password, with: 'password_1'
      fill_in :password_confirmation, with: 'password_100000'
      click_on 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content("Error: Password confirmation doesn't match Password")
    end

    it 'give alert for invalid data' do
      visit register_path

      fill_in :name, with: ' '
      fill_in :email, with: 'michaeljackson@email.com'
      fill_in :password, with: 'password_1'
      fill_in :password_confirmation, with: 'password_1'

      click_button 'Register'

      expect(page).to have_current_path('/register')
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end
