require 'spec_helper'

describe SummaryController do
  let(:json) { JSON.parse(response.body) }
  context '#index' do
    it 'should return a json response with readings' do
      get :index, format: 'json'
      expect(json.keys).to match_array(%w[readings weather])
      reading = json['readings'].sample
      expect(reading.keys).to match_array(%w[id node_id soil1 soil2 soil3 temp created_at updated_at site_name site_id converted_values average_status_name status_names voltage local_created_at])
    end
  end
end
