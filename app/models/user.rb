class User < ActiveRecord::Base
  attr_accessor :sign_in
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  def self.find_first_by_auth_conditions(warden_conditions)
        conditions = warden_conditions.dup
    if sign_in = conditions.delete(:sign_in)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => sign_in.downcase }]).first
    else
      if conditions[:email].nil?
        where(conditions).first
      else
        where(email: conditions[:email]).first
      end
    end
  end
  
end
