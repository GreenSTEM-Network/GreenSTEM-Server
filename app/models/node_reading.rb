class NodeReading < ActiveRecord::Base
  attr_accessible :node_id, :collection_time, :soil1, :soil2, :soil3, :temp

  belongs_to :node

  default_scope order('collection_time DESC')
end
