class NodeReading < ActiveRecord::Base
  attr_accessible :node_id, :collection_time, :soil1, :soil2, :soil3, :temp

  belongs_to :node

  default_scope order('collection_time DESC')

  include_root_in_json = true

  def as_json(options = {})
    super({methods: [:site_name, :site_id, :converted_values]})
  end

  def site_name
    node.site.name
  end

  def site_id
    node.site.id
  end

  def soil_type
    node.site.soil_type
  end

  def converted_values
    return [convert_value(soil1), convert_value(soil2), convert_value(soil3)]
  end

  def convert_value(value)
    if(soil_type.name == 'Clay') 
      return ((( value * 3.3 / 1024) / 0.02) * 1.8) + 32
    else
      return value
    end
  end
end
