require 'rails_helper'

describe User do
  describe 'simple validations' do
    it 'prevents users from having the same email' do
      create :user, email: 'bsmith@example.com'
      invalid_user = build :user, email: 'bsmith@example.com'
      expect(invalid_user).not_to be_valid
    end
  end
  describe 'has_role?' do 
    context 'user has been given role - admin' do
      it 'returns true for admin' do 
        user = create :user, admin: true
        expect(user).to have_role(:admin)
      end
    end
    context 'user has no role' do 
      it 'returns false' do
        user = create :user
        expect(user).not_to have_role(:admin)
        expect(user).not_to have_role(:judge)
        expect(user).not_to have_role(:quiz_scorer)
        expect(user).not_to have_role(:circle_check_scorer)
        expect(user).not_to have_role(:master_of_ceremonies)
      end
    end
  end
end
