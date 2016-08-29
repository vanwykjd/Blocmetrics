require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let (:factory_user) { create(:user) }
    
    before do
        sign_in(factory_user)
    end        

    describe "user signed in" do
     it "renders the #show view" do
       get :show, {id: factory_user.id}
       expect(response).to render_template :show
     end
     
     it "assigns factory_user to @user" do
       get :show, {id: factory_user.id}
       expect(assigns(:user)).to eq(factory_user)
     end
   end

end
