require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:factory_user)    { create(:user) }
  let(:factory_user_app)    { create(:registered_application, user: factory_user) }
  let(:factory_app_event)   { create(:event, registered_application: factory_user_app) }
  
  it { is_expected.to belong_to(:registered_application) }
end
