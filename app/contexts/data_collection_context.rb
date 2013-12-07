class DataCollectionContext

  def initialize(site, params)
    @site = site
    @params = params
  end

  def collect!
    create_node_readings!
  end

  private

  def create_node_readings!
    @params['node_readings'].each do |reading|
      node = Node.find(reading['id'])

      node.readings.create(
        collection_time: reading['timestamp'],
        soil1: reading['soil1'],
        soil2: reading['soil2'],
        soil3: reading['soil3'],
        temp: reading['temp']
      )

      update_voltage!(node, reading['voltage'])
    end
  end

  def update_voltage!(node, voltage)
    node.update_attributes(:voltage => voltage)
  end

end
