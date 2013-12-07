class NodeReading < ActiveRecord::Base
  belongs_to :node
  attr_accessible :collection_time, :soil1, :soil2, :soil3, :temp

  default_scope order('collection_time DESC')
end
