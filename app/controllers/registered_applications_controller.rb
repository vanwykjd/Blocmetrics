class RegisteredApplicationsController < ApplicationController
    before_action :authenticate_user!
    
    def show
        @registered_application = RegisteredApplication.find(params[:url])
    end

    def new
        @user = User.find(params[:id] || current_user.id)
        @registered_application = RegisteredApplication.new
    end
    
    def create
        @user = User.find(params[:user_id])
        @registered_application = @user.registered_applications.build(app_params)
        @registered_application.user = current_user
        @new_app = RegisteredApplication.new
    
        if @registered_application.save
            flash[:notice] = "App was registered successfully."
        else
            flash.now[:alert] = "There was an error registering the applicatoin. Please try again."
        end
        
        respond_to do |format|
            format.html
            format.js
        end
    end
    
    def edit
        @registered_application = RegisteredApplication.find(params[:url])
    end
    
    def update
        @registered_application = RegisteredApplication.find(params[:url])
        @registered_application.assign_attributes(app_params)
    
        if @registered_application.save
            flash[:notice] = "App was updated successfully."
        else
            flash.now[:alert] = "There was an error registering the applicatoin. Please try again."
        end
        
        respond_to do |format|
            format.html
            format.js
        end
    end
    
    def destroy
        @registered_application = RegisteredApplication.find(params[:url])
     
        if @registered_application.destroy
            flash[:notice] = "\"#{@registered_application.name}\" was removed successfully."
        else
            flash.now[:alert] = "There was an error removing the registered application."
        end
    end
    
    
    private
    
    def app_params
        params.require(:registered_application).permit(:name, :url)
    end

  
end
