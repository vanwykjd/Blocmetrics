require 'rails_helper'

RSpec.describe User, type: :model do
 
     let(:new_user) { build(:user) }
 
 ## User Sign-up
 
  # Shoulda tests for username
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
  
  # Shoulda tests for email
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
   
  # Shoulda tests for password and password_confirmation
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
   
   
    describe "attributes" do 
        it "should have a username, email, password and password confirmation" do
            expect(new_user).to have_attributes( username: new_user.username, email: new_user.email, password: new_user.password, password_confirmation: new_user.password_confirmation)
        end
        
        it "should confirm password confirmation is equal to password" do
            expect(new_user.password_confirmation).to eq(new_user.password)
        end
    end
    
end
