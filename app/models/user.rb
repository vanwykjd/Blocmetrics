class User < ActiveRecord::Base
  has_many :registered_applications, dependent: :destroy
  
  attr_accessor :sign_in
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_uniqueness_of :username, case_sensitive: false
  validates_presence_of   :username
  validates_format_of     :username, :with => /\A[A-Za-z\d]([-\w]{,498}[A-Za-z\d])?\z/i
  
  validates_presence_of   :password_confirmation
  
  validate :validate_username
  
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
  
  
  def sign_in=(sign_in)
    @sign_in = sign_in
  end


  def sign_in
    @sign_in || self.username || self.email
  end
  
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if sign_in = conditions.delete(:sign_in)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => sign_in }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions).first
    end
  end
  
  
  def registered_for(app)
    registered_applications.where(app.id).first
  end

end
