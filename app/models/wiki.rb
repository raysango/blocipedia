class Wiki < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
end
