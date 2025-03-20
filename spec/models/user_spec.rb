require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    
    context 'password complexity' do
      it 'requires a password with at least 8 characters' do
        user = build(:user, password: 'short', password_confirmation: 'short')
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('is too short (minimum is 8 characters)')
      end
      
      it 'accepts a valid password' do
        user = build(:user, password: 'SecurePass123', password_confirmation: 'SecurePass123')
        expect(user).to be_valid
      end
      
      it 'requires password to contain at least one uppercase letter' do
        user = build(:user, password: 'lowercase123', password_confirmation: 'lowercase123')
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('must include at least one uppercase letter')
      end
      
      it 'requires password to contain at least one number' do
        user = build(:user, password: 'UppercaseOnly', password_confirmation: 'UppercaseOnly')
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('must include at least one number')
      end
    end
  end
  
  describe 'devise modules' do
    it 'should include database_authenticatable module' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end
    
    it 'should include registerable module' do
      expect(User.devise_modules).to include(:registerable)
    end
    
    it 'should include recoverable module' do
      expect(User.devise_modules).to include(:recoverable)
    end
    
    it 'should include rememberable module' do
      expect(User.devise_modules).to include(:rememberable)
    end
    
    it 'should include validatable module' do
      expect(User.devise_modules).to include(:validatable)
    end
    
    it 'should include confirmable module' do
      expect(User.devise_modules).to include(:confirmable)
    end
    
    it 'should include lockable module' do
      expect(User.devise_modules).to include(:lockable)
    end
    
    it 'should include trackable module' do
      expect(User.devise_modules).to include(:trackable)
    end
  end
end
