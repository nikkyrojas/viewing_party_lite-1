# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships' do
    it { should have_many :user_viewing_parties }
    it { should have_many(:viewing_parties).through(:user_viewing_parties) }
  end
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password_digest }
    it { should have_secure_password }
    it { should validate_uniqueness_of :email }
  end

  describe 'Password' do
    it 'ensures password is not stored as plain-text' do
      user = User.create(name: 'Dominic', email: 'dominic@test.com', password: 'password123',
                         password_confirmation: 'password123')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end

  describe 'Class Methods' do
    describe '.other_users' do
      it 'returns all other users given the argument of user obj' do
        user1 = User.create!(name: 'jojo binks', email: 'jojo_binks@gmail.com', password: 'password_1',
                             password_confirmation: 'password_1')
        user2 = User.create!(name: 'bobby', email: 'bobby@yahoo.com', password: 'password_2',
                             password_confirmation: 'password_2')
        user3 = User.create!(name: 'marissa nicole', email: 'marissa.nicole99@gmail.com', password: 'password_3',
                             password_confirmation: 'password_3')
        expect(User.other_users(user1)).to eq [user2, user3]
      end
    end
  end
end
