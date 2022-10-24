# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User | Login' do
  describe 'When I visit /login/new;'
  it 'I see a form to login' do
    visit new_login_path

    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_button('Login')
  end
  
  context 'Happy Path' do
    it "logs in user redirects to home page" do
      kanye = User.create!(name: 'Kanye West', email: 'kanye@gmail.com', password: "kanyizzy")
      visit root_path
      click_on "Login Here"

      expect(current_path).to eq(new_login_path)
      email = 'kanye@gmail.com'
      password = "kanyizzy"
      name = 'Kanye West'
      fill_in :email, with: email
      fill_in :password, with: password
      
      click_on "Login"

      expect(page).to have_content("Welcome, #{email}!")
    end
  end
  context 'Sad Path' do
    it 'should not log in user if credentials are bad/incorrect password' do
      visit new_login_path
      password = "password231"

      User.create(name: 'Michael Jackson', email: 'michaeljackson@email.com', password: 'password4522')
      fill_in :email, with: 'michaeljackson@email.com'
      fill_in :password, with: "wrongpassword"
      click_on 'Login'

      expect(current_path).to eq('/login')
      expect(page).to have_content('Holy guacamole!Sorry, your credentials are bad.')
    end
    it 'should not log in user if credentials are bad/incorrect email' do
      visit new_login_path
      password = "password231"

      User.create(name: 'Michael Jackson', email: 'michaeljackson@email.com', password: 'password4522')
      fill_in :email, with: 'sdrhhljackson@email.com'
      fill_in :password, with: "wrongpassword"
      click_on 'Login'

      expect(current_path).to eq('/login')
      expect(page).to have_content('Holy guacamole!Sorry, your credentials are bad.')
    end
  end
end
