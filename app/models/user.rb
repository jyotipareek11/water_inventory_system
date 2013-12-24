class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # has_many :clients, :class_name => "Client", :foreign_key => "distributor_id", :conditions => "role = 'distributer'" 
  scope :distributors, ->{where(role:'distributor')}
  has_many :clients, :foreign_key => "distributor_id", dependent: :destroy#, -> { where "users.role = 'distributer'" }, :class_name => "Client", :foreign_key => "distributer_id"
  has_many :sales, :foreign_key => "distributor_id", dependent: :destroy
  # has_many :sales, dependent: :destroy
  has_many :vendors, -> { where "users.role = 'admin'" }, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :inventories, dependent: :destroy

  belongs_to :location

  
  ROLES = %w[admin distributor client]     
  
  def self.create_new_distributor(email, password,location_id)
    user = User.new({ :email => email, :password => password, :location_id => location_id})
    user.role = "distributor"
    user.save
    return user
  end

  def is_distributor?
    return role == 'distributor'
  end

  def is_admin?
    return role == 'admin'
  end

  def full_name
    return "#{first_name} #{last_name}"
  end  


end
