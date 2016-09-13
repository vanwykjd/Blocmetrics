class Event < ActiveRecord::Base
  belongs_to :registered_application
  
  validates :registered_application, presence: true
  validates :name, presence: true
  
  
end
