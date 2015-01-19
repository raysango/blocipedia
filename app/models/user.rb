class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :wikis
  belongs_to :plan
  
  after_initialize :by_default, :if => :new_record? #must add the if condition otherwise won't be able to chnage users's role to premium after upgrade
  
  
  def admin?
    role == 'admin'
  end
  
  def standard?
    role == 'standard'
  end
  
  def premium?
    role == 'premium'
  end
  
  def upgrade
    self.role = "premium"
  end
  
  private
  
  def by_default
    self.role = "standard"
  end
end
