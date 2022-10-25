# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User | Discover', type: :feature do
  describe 'When I visit /dashboard/discover;', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'Micheal Jordan', email: 'user235@gmail.com', password: 'password_1', password_confirmation: 'password_1')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit user_discover_index_path
    end
    it 'I see a button to discover top rated movies' do
      expect(page).to have_button('Discover Top Rated Movies')

      click_button 'Discover Top Rated Movies'
      expect(current_path).to eq(user_movies_path)
    end

    it 'has text field to search key words then redirects to matching list' do
      expect(page).to have_button('Search')

      fill_in :search, with: 'Shawshank Redemption'
      click_on 'Search'

      expect(page).to have_content('Shawshank Redemption')
      expect(current_path).to eq(user_movies_path)
    end
  end
end
