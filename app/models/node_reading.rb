class NodeReading < ActiveRecord::Base
  attr_accessible :node_id, :collection_time, :soil1, :soil2, :soil3, :temp

  belongs_to :node

  default_scope order('collection_time DESC')

  include_root_in_json = true

  def as_json(options = {})
    super({methods: [:site_name, :site_id]})
  end

  def site_name
    node.site.name
  end

  def site_id
    node.site.id
  end

  #  def self.all_latest
  #    self.group('node_id').order('collection_time desc').first()
  #  end

  #  scope :last_record_in_each_group, lambda { |name|
  #   cond = "node_reading.id in (select top 1 max(node_reading.colle) from user_details group by user_details.user_id)"
  #   cond << " and upper((CONCAT(first_name,' ', middle_name,' ', last_name))) like ?"
  #   {:conditions => [cond, "%#{name.upcase}%"]}
  # }
end
