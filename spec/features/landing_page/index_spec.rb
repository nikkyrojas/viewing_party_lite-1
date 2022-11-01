# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page | Index', type: :feature do
  describe 'As a user when I visit the Landing Page,' do
    before(:each) do
      @user1 = User.create!(name: 'jojo binks', email: 'jojo_binks@gmail.com', password: 'password_1',
                            password_confirmation: 'password_1')
      @user2 = User.create!(name: 'bobby', email: 'bobby@yahoo.com', password: 'password_2',
                            password_confirmation: 'password_2')
      @user3 = User.create!(name: 'marissa nicole', email: 'marissa.nicole99@gmail.com', password: 'password_3',
                            password_confirmation: 'password_3')
      visit root_path
    end
    it 'I see the title of the Applications' do
      within('#application_title') do
        expect(page).to have_content 'Viewing Party'
      end
    end
    it 'I see a button to create a new user' do
      within('#user_creation') do
        expect(page).to have_button('Register Here')
      end
    end
    it 'I see a link back to the home page' do
      within('#home_page_link') do
        expect(page).to have_link('Home')
        click_on 'Home'
        expect(page.current_path).to eq root_path
      end
    end
    it 'I see a link to login' do
      within('#home_page_link') do
        expect(page).to have_button('Login')
        click_on 'Login'
        expect(page.current_path).to eq login_path
      end
    end
    it 'I see a link to register' do
      within('#home_page_link') do
        expect(page).to have_button('Register Here')
        click_on 'Register Here'
        expect(page.current_path).to eq register_path
      end
    end
  end
end
