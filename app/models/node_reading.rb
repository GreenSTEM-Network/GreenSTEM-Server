class NodeReading < ActiveRecord::Base
  attr_accessible :node_id, :created_at, :soil1, :soil2, :soil3, :temp

  belongs_to :node

  # default_scope order('created_at DESC')

  include_root_in_json = true

  def self.latest_reading_ids
    group(:node_id).maximum(:id).keys
  end

  def self.latest_readings
    find(latest_reading_ids)
  end

  def as_json(options = {})
    super({methods: [:site_name, :site_id, :converted_values, :average_status_name, :status_names, :temp, :voltage, :local_created_at]})
  end

  def local_created_at
    created_at.strftime("%m/%d/%Y %I:%M %p")
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

  def voltage
    node.voltage
  end

  def converted_values
    return [convert_value(soil1), convert_value(soil2), convert_value(soil3)]
  end

  def status_names
    return converted_values.map do |value|
      NodeReading.node_value_to_status_name(node, value, soil_type)
    end
  end

  def self.node_value_to_status_name(node, value, soil_type)
    if node.disabled?
      'GREY'
    elsif soil_type.nil?
      'GREY'
    elsif value >= soil_type.moist_threshold
      'GREEN'
    elsif value >= soil_type.wilting_threshold
      'YELLOW'
    else 
      'RED'
    end
  end

  def average_status_name
    NodeReading.node_value_to_status_name(node, converted_values.sum() / converted_values.length, soil_type)
  end

  def convert_value(value)
    return value
    # Not sure if we need to have different equations based on soil type, returning raw value for now
    # if(soil_type.name == 'Clay') 
    #   return ((( value * 3.3 / 1024) / 0.02) * 1.8) + 32
    # else
    #   return value
    # end
  end
end
