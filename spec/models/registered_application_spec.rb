require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do
    let(:factory_user) { create(:user) }
    let(:factory_user_app) { create(:registered_application, user: factory_user) }
  
    it { is_expected.to belong_to(:user) }
  
    describe "attributes" do
        it "has a name, url, and user attributes" do
            expect(factory_user_app).to have_attributes( name: factory_user_app.name, url: factory_user_app.url, user: factory_user_app.user )
   	    end
    end
end
