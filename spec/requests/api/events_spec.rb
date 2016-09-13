require 'rails_helper'

RSpec.describe "API Event#Create", :type => :request do
  
    let(:factory_app) { FactoryGirl.create(:registered_application) }

    before do 
        @event_params = Event.create( name: "New Event" ).to_json
        @valid_request_headers = {"Accept" => "application/json", "Origin" => factory_app.url, "Content-Type" => "application/json"}
        @invalid_request_headers = {"Accept" => "application/json", "Origin" => "", "Content-Type" => "application/json"}
    end

    it "creates a new event with a registered application" do
        post '/api/events', @event_params, @valid_request_headers
            expect(response).to have_http_status(201)
            expect(factory_app.events.first.name).to eq("New Event")
    end

    it "does not create a new event with an invalid event or unregistered application" do
        post '/api/events', @event_params, @invalid_request_headers
            expect(response).to have_http_status(422)
            expect(factory_app.events.count).to eq 0
    end
    
end