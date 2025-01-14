# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page | Index', type: :feature do
  describe 'As a user when I visit the Landing Page,' do
    before(:each) do
      @user1 = User.create!(name: 'jojo binks', email: 'jojo_binks@gmail.com', password: 'password123', role: 2)
      @user2 = User.create!(name: 'bobby', email: 'bobby@yahoo.com', password: 'password123')
      @user3 = User.create!(name: 'marissa nicole', email: 'marissa.nicole99@gmail.com', password: 'password123')
      visit root_path
    end
    it 'I see the title of the Applications' do
      within('#application_title') do
        expect(page).to have_content 'Viewing Party'
      end
    end
    it 'I see a button to create a new user "register here' do
      within('#user_creation') do
        expect(page).to have_button('Register Here')
      end
    end
    it 'I see a button to login' do
      within('#user_creation') do
        expect(page).to have_button('Login')
      end
    end
    it 'I see a list of existing users which links to each users dashboard' do
      click_on 'Login Here'
      fill_in :email, with: 'jojo_binks@gmail.com'
      fill_in :password, with: 'password123'
      click_on 'Login'

      within('#current_users') do
        within("#user-#{@user1.id}") do
          expect(page).to have_link("#{@user1.email}'s dashboard", href: user_path(@user1.id))
          expect(page).to_not have_link("#{@user2.email}'s dashboard", href: user_path(@user2.id))
          expect(page).to_not have_link("#{@user3.email}'s dashboard", href: user_path(@user3.id))
        end
        within("#user-#{@user2.id}") do
          expect(page).to have_link("#{@user2.email}'s dashboard", href: user_path(@user2.id))
          expect(page).to_not have_link("#{@user1.email}'s dashboard", href: user_path(@user1.id))
          expect(page).to_not have_link("#{@user3.email}'s dashboard", href: user_path(@user3.id))
        end
        within("#user-#{@user3.id}") do
          expect(page).to have_link("#{@user3.email}'s dashboard", href: user_path(@user3.id))
          expect(page).to_not have_link("#{@user1.email}'s dashboard", href: user_path(@user1.id))
          expect(page).to_not have_link("#{@user2.email}'s dashboard", href: user_path(@user2.id))
        end
      end
    end
    it 'I see a link back to the home page' do
      click_on 'Login Here'
      fill_in :email, with: 'jojo_binks@gmail.com'
      fill_in :password, with: 'password123'
      click_on 'Login'
      within('#home_page_link') do
        expect(page).to have_link('Home')
        click_on 'Home'
        expect(page.current_path).to eq root_path
      end
    end
  end
end
