# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'User | Dashboard', type: :feature do
  describe 'When I visit /dashboard', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'jojo binks', email: 'jojo_binks@gmail.com', password: 'password123')
      @user2 = User.create!(name: 'bobby', email: 'bobby@yahoo.com', password: 'password123')
      @user3 = User.create!(name: 'marissa nicole', email: 'marissa.nicole99@gmail.com', password: 'password123')
      @user4 = User.create!(name: 'dominic od', email: 'domo99@gmail.com', password: 'password123')
      @vp1 = ViewingParty.create!(duration: 100, date: '2022-10-11 17:19:58', time: '17:08', movie_id: 36_600)
      @vp2 = ViewingParty.create!(duration: 180, date: '2022-10-12 16:18:58', time: '19:08', movie_id: 34_601)
      @user_view1 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @vp1.id, role: 1)
      @user_view2 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @vp2.id, role: 0)
      @user_view3 = UserViewingParty.create!(user_id: @user2.id, viewing_party_id: @vp2.id, role: 0)
      @user_view3 = UserViewingParty.create!(user_id: @user3.id, viewing_party_id: @vp2.id, role: 1)
      visit dashboard_path(@user1.id)
    end
    it 'I see the users name at the top of the page' do
      within('#user_name') do
        expect(page).to have_content("#{@user1.name}'s dashboard")
        expect(page).to_not have_content("#{@user2.name}'s dashboard")
        expect(page).to_not have_content("#{@user3.name}'s dashboard")
      end
    end
    it 'I see a button to discover movies' do
      within('#discover') do
        expect(page).to have_button('Discover Movies')
        click_on 'Discover Movies'
        expect(page.current_path).to eq user_discover_index_path(@user1.id)
      end
    end
    it 'I see a section that lists all of my viewing parties' do
      within('#viewing_parties') do
        within("#hosted-#{@vp1.id}") do
          expect(page).to have_content('The Flesh and Blood Show')
          within('#date') do
            expect(page).to have_content('October 11, 2022 05:19 PM')
            expect(page).to_not have_content('October 12, 2022 04:18 PM')
          end
          within('#role') do
            expect(page).to_not have_content('Invited')
            expect(page).to have_content('Host')
          end
        end
        within("#invited-#{@vp2.id}") do
          expect(page).to have_content('Three Way')
          within('#date_invited') do
            expect(page).to have_content('October 12, 2022 04:18 PM')
            expect(page).to_not have_content('October 11, 2022 05:19 PM')
          end
          within('#role_invited') do
            expect(page).to have_content('Invited')
            expect(page).to_not have_content('Host')
          end
        end
      end
    end
    it 'I see the invited viewers, host, and my name in bold' do
      within('#viewing_parties') do
        within("#invited-#{@vp2.id}") do
          within('#host_invited') do
            expect(page).to have_content(@user3.name)
          end
          within('#viewers') do
            expect(page).to have_content(@user1.name)
            expect(page).to have_content(@user2.name)
            expect(page).to_not have_content(@user3.name)
            current_user = find('#current_user')
            expect(current_user.text).to eq @user1.name
            expect(current_user.tag_name).to eq 'strong'
          end
        end
      end
    end
  end
end
