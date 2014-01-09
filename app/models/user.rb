class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # has_many :clients, :class_name => "Client", :foreign_key => "distributor_id", :conditions => "role = 'distributer'" 
  scope :distributors, ->{where(role:'distributor')}
 has_many :clients, :foreign_key => "distributor_id", dependent: :destroy#, -> { where "users.role = 'distributer'" }, :class_name => "Client", :foreign_key => "distributer_id"
  # has_many :admin_sales, -> { where "users.role = 'admin'" }, :class_name => "Sale", dependent: :destroy
  # has_many :distributor_sales, -> { where "users.role = 'distributor'" }, :class_name => "Sale", dependent: :destroy
  has_many :sales, dependent: :destroy

  has_many :vendors, foreign_key: "admin_id", dependent: :destroy
  
  has_many :purchases, dependent: :destroy
  has_many :inventories, dependent: :destroy

  belongs_to :location
  validates :first_name,:role, presence: true

 # belongs_to :sales , -> { where "users.role = 'distributor'" }
 
  ROLES = %w[admin distributor client]     
  
  def self.create_new_distributor(email, password,first_name,last_name,location_id)
    user = User.new({:email => email, :password => password, :first_name=>first_name,:last_name=>last_name,:location_id => location_id})
    user.role = "distributor"
    user.save if user.valid?
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

  def name
    return "#{first_name} #{last_name}"
  end

  def purchase_ordered
    purchases.purchase_ordered.to_a
  end

  def purchase_received
    purchases.purchase_received.to_a
  end  

  def distributors_order
    Purchase.distributors_order.to_a
    # purchases.distributors_order.to_a
  end  

  def delivered_sales
    sales.delivered
  end

  def all_delivered_sales
    sales.delivered.to_a
  end
  
  def order_initiated_sales
    sales.order_initiated.to_a
  end


end
