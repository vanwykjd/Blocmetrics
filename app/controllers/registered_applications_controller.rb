class RegisteredApplicationsController < ApplicationController
    before_action :authenticate_user!
    
    def index
   	    @registered_applications = RegisteredApplication.all
    end
    
    def show
        @user = User.find(params[:user_id])
        @registered_application = RegisteredApplication.find(params[:id])
        @events = @registered_application.events.group_by(&:name)
    end

    def new
        @user = User.find(params[:user_id])
        @registered_applications = RegisteredApplication.new
    end
    
    def create
        @user = User.find(params[:user_id])
        @registered_application = @user.registered_applications.new(app_params)
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
        @registered_application = RegisteredApplication.find(params[:id])
    end
    
    def update
        @user = User.find(params[:user_id])
        @registered_application = RegisteredApplication.find(params[:id])
        @registered_application.assign_attributes(app_params)
        
    
        if @registered_application.save
            flash[:notice] = "App was updated successfully."
            redirect_to current_user
        else
            flash.now[:alert] = "There was an error registering the applicatoin. Please try again."
            
        end
        
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @registered_application = @user.registered_applications.find(params[:id])
     
        if @registered_application.destroy
            flash[:notice] = "\"#{@registered_application.name}\" was removed successfully."
        else
            flash.now[:alert] = "There was an error removing the registered application."
        end
        
        respond_to do |format|
    		format.html
    		format.js 
    	end
    end
    
    
    private
    
    def app_params
        params.require(:registered_application).permit(:name, :url)
    end

  
end
