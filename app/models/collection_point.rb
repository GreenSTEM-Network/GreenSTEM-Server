class CollectionPoint < ActiveRecord::Base
  attr_accessible :title, :body, :name

  belongs_to :site
  has_many :data_collections
  has_many :soilmoistures

end
