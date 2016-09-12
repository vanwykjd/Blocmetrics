require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do
    
    let(:factory_user) { create(:user) }
    let(:factory_user_app) { create(:registered_application, user: factory_user) }
    
    before do
        sign_in(factory_user)
    end
    
    
    describe "GET show" do
      it "returns http success" do
        get :show, user_id: factory_user.id, id: factory_user_app.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, user_id: factory_user.id, id: factory_user_app.id
        expect(response).to render_template :show
      end

      it "assigns factory_user_app to @registered_application" do
        get :show, user_id: factory_user.id, id: factory_user_app.id
        expect(assigns(:registered_application)).to eq(factory_user_app)
      end
    end
    
    describe "GET new" do
      it "returns http success" do
        get :new, user_id: factory_user.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, user_id: factory_user.id
        expect(response).to render_template :new
      end

      it "instantiates @post" do
        get :new, user_id: factory_user.id
        expect(assigns(:registered_applications)).not_to be_nil
      end
    end
    
    describe "POST create" do
        
        render_views
        
        it "creates an Item and redirects to the User's page" do
            post :create, format: :js, user: factory_user, user_id: factory_user.id, registered_application: { name: "Bloc", url: "Bloc.io" } 
            expect(response).to have_http_status(200)
        end
        
        it "increases the number of registered_applications by 1" do
            expect{ post :create, format: :js, user: factory_user, user_id: factory_user.id, registered_application: { name: "Bloc", url: "Bloc.io" } }.to change(RegisteredApplication,:count).by(1)  
        end

        it "assigns the new registered_application to @registered_application" do
            post :create, format: :js, user: factory_user, user_id: factory_user.id, registered_application: { name: "Bloc", url: "Bloc.io" } 
            expect(assigns(:registered_application)).to eq RegisteredApplication.last
        end
    end
    
    describe "GET edit" do
      it "returns http success" do
        get :edit, user_id: factory_user.id, id: factory_user_app.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, user_id: factory_user.id, id: factory_user_app.id
        expect(response).to render_template :edit
      end

      it "assigns registered_application to be updated to @registered_application" do
        get :edit, user_id: factory_user.id, id: factory_user_app.id
        registered_application_instance = assigns(:registered_application)

        expect(registered_application_instance.id).to eq factory_user_app.id
        expect(registered_application_instance.name).to eq registered_application_instance.name
        expect(registered_application_instance.url).to eq registered_application_instance.url
      end
    end
    
    describe "PUT update" do
      it "updates post with expected attributes" do
        new_name = "New Name"
        new_url = "newname.com"

        put :update, user_id: factory_user.id, id: factory_user_app.id, registered_application: {name: new_name, url: new_url}

        updated_app = assigns(:registered_application)
        expect(updated_app.id).to eq factory_user_app.id
        expect(updated_app.name).to eq new_name
        expect(updated_app.url).to eq new_url
      end

      it "redirects to the updated post" do
        new_name = "New Name"
        new_url = "newname.com"

        put :update, user_id: factory_user.id, id: factory_user_app.id, registered_application: {name: new_name, url: new_url}
        expect(response).to redirect_to [factory_user]
      end
    end
    
    describe "DELETE destroy" do
       
       it "deletes the registered_application" do
         delete :destroy, format: :js, user_id: factory_user.id, id: factory_user_app.id
         count = RegisteredApplication.where({user: factory_user.id, id: factory_user_app.id}).count
         expect(count).to eq 0
       end
 
       it "returns http success" do
         delete :destroy, format: :js, user_id: factory_user.id, id: factory_user_app.id
         expect(response).to have_http_status(:success)
       end
     end



end
