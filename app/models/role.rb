class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  attr_accessible :name
  belongs_to :resource, :polymorphic => true

  scopify
end
