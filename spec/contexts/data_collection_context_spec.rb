require 'spec_helper'

describe DataCollectionContext do
  
  let(:site) { FactoryGirl.create(:site) }
  let(:node) { FactoryGirl.create(:node) }

  describe 'collect!' do
  
    it 'creates node readings from params' do
      data = sample_data(site.id, node.id)

      collection = DataCollectionContext.new(site, data)

      expect{collection.collect!}.to change{node.readings.count}.by(1)
      node.readings.last.soil1.should eq 1.2
    end
    
    it 'from params if it is the most recently updated node_reading' do
      pending "Not implemented yet"
    end
  end
end

def sample_data(site_id, node_id)
  JSON.parse('{"site_id":"' + site_id.to_s + '","node_readings":[{"id":"' + node_id.to_s + '","timestamp":"2013-12-07 04:05:06","channel":"001","project_type":"garden","soil1":"1.2","soil2":"1.3","soil3":"1.4","temp":"58","voltage":"1.4"}]}')
end
