class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy
  
  
   default_scope { order('updated_at DESC') }
   
   def event_for(registered_application)
     events.where(registered_application_id: registered_application.id).first
   end
   
   
end
