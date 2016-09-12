require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do
    let(:factory_user) { create(:user) }
    let(:factory_user_app) { create(:registered_application, user: factory_user) }
  
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:events) }
  
    describe "attributes" do
        it "has a name, url, and assigned to a user attributes" do
            expect(factory_user_app).to have_attributes( name: factory_user_app.name, url: factory_user_app.url, user: factory_user_app.user )
   	    end
    end
    
    describe "#event_for(registered_application)" do
     before do
       @event = Event.create!(name: "Log-ins")
     end
 
     it "returns `nil` if the user has not favorited the post" do
       expect(factory_user_app.event_for(@event)).to be_nil
     end
 
     it "returns the appropriate favorite if it exists" do
       event = factory_user_app.events.where(name: @event.name).create
       expect(factory_user_app.event_for(@event)).to eq(event)
     end
   end
end
