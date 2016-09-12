require 'rails_helper'

RSpec.describe User, type: :model do
 
     let(:new_user) { create(:user) }
 
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
    
    describe "invalid username and email" do
        it "should not save user if username is invalid format" do
            expect(FactoryGirl.build(:user, username: "user@username.com" )).to_not be_valid
        end
        
        it "should not save user if username already exists" do
            expect(FactoryGirl.build(:user, username: new_user.username)).to_not be_valid
        end
        

        it "should not save user if email already exists" do
            expect(FactoryGirl.build(:user, email: new_user.email)).to_not be_valid
        end
    end
    
 
 
 ## Registered Applications
 
    let(:app_user) { create(:user) }
 
  # Shoulda tests for registered application
    it { is_expected.to have_many(:registered_applications) }
    
    describe "#register_for(app)" do
        before do
            @app = RegisteredApplication.create!(name: "Bloc", url: "bloc.io")
        end
        
        it "returns `nil` if the user has not registered the application" do
            expect(app_user.registered_for(@app)).to be_nil
        end
 
        it "returns the appropriate application if it exists" do
            registered_application = app_user.registered_applications.where(name: @app.name, url: @app.url).create
            expect(app_user.registered_for(@app)).to eq(registered_application)
        end
    end
    
end
