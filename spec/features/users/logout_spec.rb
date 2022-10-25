# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User | Logout' do
  let!(:user) { User.create!(name: 'dominic', email: 'dominicod@gmail.com', password: 'password_1', password_confirmation: 'password_1') }
  let!(:stub_user) { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

  describe 'When I am a logged in user,' do
    context 'Happy Path' do
      it 'I see a logout button' do
        visit user_path

        expect(page).to have_button 'Logout'
      end

      it 'When I click logout, I am redirected to the root page and no longer see the button' do
        visit user_path

        click_on 'Logout'

        expect(page.current_path).to eq root_path
        expect(page).to_not have_button 'Logout'
      end
    end
  end
end
